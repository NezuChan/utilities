export enum RabbitMQ {
    PLAYER_EXCHANGE = "nezu-player",
    PLAYER_RECV = "nezu-player.recv",
    PLAYER_SEND = "nezu-player.send",
    TASKS_SEND = "scheduled-tasks.send",
    TASKS_RECV = "scheduled-tasks.recv",
    API_RECV = "nezu-api.recv",
    API_SEND = "nezu-api.send",
    BOT_RPC = "nezu-bot.rpc"
}

export enum RabbitMQRpc {
    COMMANDS = "commands"
}
