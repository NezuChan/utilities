export enum RabbitMQ {
    PLAYER_EXCHANGE = "nezu-player",
    PLAYER_RECV = "nezu-player.recv",
    PLAYER_SEND = "nezu-player.send",
    TASKS_SEND = "scheduled-tasks.send",
    TASKS_RECV = "scheduled-tasks.recv",
    TASKS_EXCHANGE = "scheduled-tasks",
    API_RECV = "nezu-api.recv",
    API_SEND = "nezu-api.send",
    API_EXCHANGE = "nezu-api",
    BOT_RPC = "nezu-bot.rpc",
    GATEWAY_EXCHANGE = "nezu-gateway",
    GATEWAY_QUEUE_RECV = "nezu-gateway.recv",
    GATEWAY_QUEUE_SEND = "nezu-gateway.send",
    GATEWAY_QUEUE_STATS = "nezu-gateway.stats",
    GATEWAY_QUEUE_STATS_POOLER = "nezu-gateway.stats_pooler"
}

export enum RabbitMQRpc {
    COMMANDS = "commands"
}
