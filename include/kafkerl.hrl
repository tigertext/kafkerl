%% Error codes
-define(UNKNOWN_SERVER_ERROR, -1).
-define(NONE, 0).
-define(OFFSET_OUT_OF_RANGE, 1).
-define(CORRUPT_MESSAGE, 2).
-define(UNKNOWN_TOPIC_OR_PARTITION, 3).
-define(INVALID_FETCH_SIZE, 4).
-define(LEADER_NOT_AVAILABLE, 5).
-define(NOT_LEADER_OR_FOLLOWER, 6).
-define(REQUEST_TIMED_OUT, 7).
-define(BROKER_NOT_AVAILABLE, 8).
-define(REPLICA_NOT_AVAILABLE, 9).
-define(MESSAGE_TOO_LARGE, 10).
-define(STALE_CONTROLLER_EPOCH, 11).
-define(OFFSET_METADATA_TOO_LARGE, 12).
-define(NETWORK_EXCEPTION, 13).
-define(COORDINATOR_LOAD_IN_PROGRESS, 14).
-define(COORDINATOR_NOT_AVAILABLE, 15).
-define(NOT_COORDINATOR, 16).
-define(INVALID_TOPIC_EXCEPTION, 17).
-define(RECORD_LIST_TOO_LARGE, 18).
-define(NOT_ENOUGH_REPLICAS, 19).
-define(NOT_ENOUGH_REPLICAS_AFTER_APPEND, 20).
-define(INVALID_REQUIRED_ACKS, 21).
-define(ILLEGAL_GENERATION, 22).
-define(INCONSISTENT_GROUP_PROTOCOL, 23).
-define(INVALID_GROUP_ID, 24).
-define(UNKNOWN_MEMBER_ID, 25).
-define(INVALID_SESSION_TIMEOUT, 26).
-define(REBALANCE_IN_PROGRESS, 27).
-define(INVALID_COMMIT_OFFSET_SIZE, 28).
-define(TOPIC_AUTHORIZATION_FAILED, 29).
-define(GROUP_AUTHORIZATION_FAILED, 30).
-define(CLUSTER_AUTHORIZATION_FAILED, 31).
-define(INVALID_TIMESTAMP, 32).
-define(UNSUPPORTED_SASL_MECHANISM, 33).
-define(ILLEGAL_SASL_STATE, 34).
-define(UNSUPPORTED_VERSION, 35).
-define(TOPIC_ALREADY_EXISTS, 36).
-define(INVALID_PARTITIONS, 37).
-define(INVALID_REPLICATION_FACTOR, 38).
-define(INVALID_REPLICA_ASSIGNMENT, 39).
-define(INVALID_CONFIG, 40).
-define(NOT_CONTROLLER, 41).
-define(INVALID_REQUEST, 42).
-define(UNSUPPORTED_FOR_MESSAGE_FORMAT, 43).
-define(POLICY_VIOLATION, 44).
-define(OUT_OF_ORDER_SEQUENCE_NUMBER, 45).
-define(DUPLICATE_SEQUENCE_NUMBER, 46).
-define(INVALID_PRODUCER_EPOCH, 47).
-define(INVALID_TXN_STATE, 48).
-define(INVALID_PRODUCER_ID_MAPPING, 49).
-define(INVALID_TRANSACTION_TIMEOUT, 50).
-define(CONCURRENT_TRANSACTIONS, 51).
-define(TRANSACTION_COORDINATOR_FENCED, 52).
-define(TRANSACTIONAL_ID_AUTHORIZATION_FAILED, 53).
-define(SECURITY_DISABLED, 54).
-define(OPERATION_NOT_ATTEMPTED, 55).
-define(KAFKA_STORAGE_ERROR, 56).
-define(LOG_DIR_NOT_FOUND, 57).
-define(SASL_AUTHENTICATION_FAILED, 58).
-define(UNKNOWN_PRODUCER_ID, 59).
-define(REASSIGNMENT_IN_PROGRESS, 60).
-define(DELEGATION_TOKEN_AUTH_DISABLED, 61).
-define(DELEGATION_TOKEN_NOT_FOUND, 62).
-define(DELEGATION_TOKEN_OWNER_MISMATCH, 63).
-define(DELEGATION_TOKEN_REQUEST_NOT_ALLOWED, 64).
-define(DELEGATION_TOKEN_AUTHORIZATION_FAILED, 65).
-define(DELEGATION_TOKEN_EXPIRED, 66).
-define(INVALID_PRINCIPAL_TYPE, 67).
-define(NON_EMPTY_GROUP, 68).
-define(GROUP_ID_NOT_FOUND, 69).
-define(FETCH_SESSION_ID_NOT_FOUND, 70).
-define(INVALID_FETCH_SESSION_EPOCH, 71).
-define(LISTENER_NOT_FOUND, 72).
-define(TOPIC_DELETION_DISABLED, 73).
-define(FENCED_LEADER_EPOCH, 74).
-define(UNKNOWN_LEADER_EPOCH, 75).
-define(UNSUPPORTED_COMPRESSION_TYPE, 76).
-define(STALE_BROKER_EPOCH, 77).
-define(OFFSET_NOT_AVAILABLE, 78).
-define(MEMBER_ID_REQUIRED, 79).
-define(PREFERRED_LEADER_NOT_AVAILABLE, 80).
-define(GROUP_MAX_SIZE_REACHED, 81).
-define(FENCED_INSTANCE_ID, 82).
-define(ELIGIBLE_LEADERS_NOT_AVAILABLE, 83).
-define(ELECTION_NOT_NEEDED, 84).
-define(NO_REASSIGNMENT_IN_PROGRESS, 85).
-define(GROUP_SUBSCRIBED_TO_TOPIC, 86).
-define(INVALID_RECORD, 87).
-define(UNSTABLE_OFFSET_COMMIT, 88).
-define(THROTTLING_QUOTA_EXCEEDED, 89).
-define(PRODUCER_FENCED, 90).
-define(RESOURCE_NOT_FOUND, 91).
-define(DUPLICATE_RESOURCE, 92).
-define(UNACCEPTABLE_CREDENTIAL, 93).
-define(INCONSISTENT_VOTER_SET, 94).
-define(INVALID_UPDATE_VERSION, 95).
-define(FEATURE_UPDATE_FAILED, 96).
