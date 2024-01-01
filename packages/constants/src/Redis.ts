export enum RedisKey {
    SESSIONS_KEY = "gateway_shard_session",
    STATUSES_KEY = "gateway_shard_status",
    STARTED_KEY = "gateway_started",
    SHARDS_KEY = "gateway_shards",

    BOT_USER_KEY = "bot_user",
    GUILD_KEY = "guild",
    CHANNEL_KEY = "channel",
    MESSAGE_KEY = "message",
    ROLE_KEY = "role",
    EMOJI_KEY = "emoji",
    MEMBER_KEY = "member",
    PRESENCE_KEY = "presence",
    VOICE_KEY = "voice",
    VOICE_SERVER_KEY = "voice_server",
    USER_KEY = "user",

    COUNT = "count",
    // used by redis sets (for storing voice states keys)
    LIST = "list",

    EXPIRY_KEYS = "expiry_keys"
}
