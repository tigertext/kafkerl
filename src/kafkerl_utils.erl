-module(kafkerl_utils).
-author('hernanrivasacosta@gmail.com').

-export([send_event/2, send_error/2]).
-export([get_tcp_options/1]).
-export([merge_messages/1, split_messages/1]).
-export([buffer_name/2, default_buffer_name/0]).
-export([gather_consume_responses/0, gather_consume_responses/1]).
-export([proplists_set/2]).
-export([
    connect/3,
    connect/4,
    send/3,
    recv/4,
    close/2,
    controlling_process/3
]).

%%==============================================================================
%% API
%%==============================================================================
-spec send_error(kafkerl:callback(), any()) -> ok.
send_error(Callback, Reason) ->
  send_event(Callback, {error, Reason}).

-spec send_event(kafkerl:callback(), any()) -> ok | {error, {bad_callback, any()}}.
send_event({M, F}, Data) ->
  spawn(fun() -> M:F(Data) end),
  ok;
send_event({M, F, A}, Data) ->
  spawn(fun() -> apply(M, F, A ++ [Data]) end),
  ok;
send_event(Pid, Data) when is_pid(Pid) ->
  Pid ! Data,
  ok;
send_event(Function, Data) when is_function(Function, 1) ->
  spawn(fun() -> Function(Data) end),
  ok;
send_event(BadCallback, _Data) ->
  {error, {bad_callback, BadCallback}}.

default_tcp_options() ->
  % This list has to be sorted
  [{mode, binary}, {packet, 0}].
get_tcp_options(Options) -> % TODO: refactor
  UnfoldedOptions = proplists:unfold(Options),
  lists:ukeymerge(1, lists:sort(UnfoldedOptions), default_tcp_options()).

% This is rather costly, and for obvious reasons does not maintain the order of
% the partitions or topics, but it does keep the order of the messages within a
% specific topic-partition pair
-spec merge_messages([kafkerl_protocol:basic_message()]) ->
  kafkerl_protocol:merged_message().
merge_messages(Topics) ->
  merge_topics(Topics).

% Not as costly, but still avoid this in a place where performance is critical
-spec split_messages(kafkerl_protocol:merged_message()) ->
  [kafkerl_protocol:basic_message()].
split_messages({Topic, {Partition, Messages}}) ->
  {Topic, Partition, Messages};
split_messages({Topic, Partitions}) ->
  [{Topic, Partition, Messages} || {Partition, Messages} <- Partitions];
split_messages(Topics) ->
  lists:flatten([split_messages(Topic) || Topic <- Topics]).

-spec buffer_name(kafkerl_protocol:topic(), kafkerl_protocol:partition()) ->
  atom().
buffer_name(Topic, Partition) ->
  Bin = <<Topic/binary, $., (integer_to_binary(Partition))/binary, "_buffer">>,
  binary_to_atom(Bin, utf8).

-spec default_buffer_name() -> atom().
default_buffer_name() ->
  default_message_buffer.

-type proplist_value() :: {atom(), any()} | atom().
-type proplist()       :: [proplist_value].
-spec proplists_set(proplist(), proplist_value() | [proplist_value()]) ->
  proplist().
proplists_set(Proplist, {K, _V} = NewValue) ->
  lists:keystore(K, 1, proplists:unfold(Proplist), NewValue);
proplists_set(Proplist, []) ->
  Proplist;
proplists_set(Proplist, [H | T]) ->
  proplists_set(proplists_set(Proplist, H), T).

connect(Host, Port, Options) ->
    connect(Host, Port, Options, infinity).

connect(Host, 9092, Options, Timeout) ->
    {gen_tcp:connect(Host, 9092, Options, Timeout), false};
connect(Host, 9094, Options, Timeout) ->
    {ssl:connect(Host, 9094, Options, Timeout), true};
connect(Host, Port, Options, Timeout) ->
    case ssl:connect(Host, Port, Options, Timeout) of
        {ok, _} = R->
            {R, true};
        _ ->
            {gen_tcp:connect(Host, Port, Options, Timeout), false}
  end.

send(Socket, Request, true) ->
    ssl:send(Socket, Request);
send(Socket, Request, false) ->
    gen_tcp:send(Socket, Request).

recv(Socket, Length, Timeout, true) ->
    ssl:recv(Socket, Length, Timeout);
recv(Socket, Length, Timeout, false) ->
    gen_tcp:recv(Socket, Length, Timeout).

close(Socket, false) ->
    gen_tcp:close(Socket);
close(Socket, true) ->
    ssl:close(Socket).

controlling_process(Socket, Pid, false) ->
    gen_tcp:controlling_process(Socket, Pid);
controlling_process(Socket, Pid, true) ->
    ssl:controlling_process(Socket, Pid).
%%==============================================================================
%% Utils
%%==============================================================================
%% Merge
merge_topics({Topic, Partition, Message}) ->
  merge_topics([{Topic, Partition, Message}]);
merge_topics([{Topic, Partition, Message}]) ->
  [{Topic, [{Partition, Message}]}];
merge_topics(Topics) ->
  merge_topics(Topics, []).

merge_topics([], Acc) ->
  Acc;
merge_topics([{Topic, Partition, Messages} | T], Acc) ->
  merge_topics([{Topic, [{Partition, Messages}]} | T], Acc);
merge_topics([{Topic, Partitions} | T], Acc) ->
  case lists:keytake(Topic, 1, Acc) of
    false ->
      merge_topics(T, [{Topic, merge_partitions(Partitions)} | Acc]);
    {value, {Topic, OldPartitions}, NewAcc} ->
      NewPartitions = Partitions ++ OldPartitions,
      merge_topics(T, [{Topic, merge_partitions(NewPartitions)} | NewAcc])
  end.

merge_partitions(Partitions) ->
  merge_partitions(Partitions, []).

merge_partitions([], Acc) ->
  Acc;
merge_partitions([{Partition, Messages} | T], Acc) ->
  case lists:keytake(Partition, 1, Acc) of
    false ->
      merge_partitions(T, [{Partition, Messages} | Acc]);
    {value, {Partition, OldMessages}, NewAcc} ->
      NewMessages = merge_messages(OldMessages, Messages),
      merge_partitions(T, [{Partition, NewMessages} | NewAcc])
  end.

merge_messages(A, B) ->
  case {is_list(A), is_list(B)} of
    {true, true}   -> B ++ A;
    {false, true}  -> B ++ [A];
    {true, false}  -> [B | A];
    {false, false} -> [B, A]
  end.

gather_consume_responses() ->
  gather_consume_responses(2500).
gather_consume_responses(Timeout) ->
  gather_consume_responses(Timeout, []).
gather_consume_responses(Timeout, Acc) ->
  receive
    {consumed, Messages} ->
      gather_consume_responses(Timeout, Acc ++ Messages);
    {offset, Offset} ->
      {Acc, Offset};
    {error, _Reason} = Error ->
      Error
  after Timeout ->
    []
  end.
