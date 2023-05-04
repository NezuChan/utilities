import amqplib, { AmqpConnectionManagerOptions, ChannelWrapper, ConnectionUrl, CreateChannelOpts } from "amqp-connection-manager";

export function createAmqpChannel(
    urls: ConnectionUrl | ConnectionUrl[] | null | undefined,
    channelOptions?: CreateChannelOpts | undefined,
    options?: AmqpConnectionManagerOptions | undefined
): ChannelWrapper {
    const connection = amqplib.connect(urls, options);
    return connection.createChannel(channelOptions);
}
