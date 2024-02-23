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

    GATEWAY_EXCHANGE = "kanao-gateway"
}

export enum GatewayExchangeRoutes {
    DISPATCH = "dispatch",
    RECEIVE = "receive",
    REQUEST = "request",
    SEND = "send"
}

export enum RabbitMQRpc {
    COMMANDS = "commands"
}
