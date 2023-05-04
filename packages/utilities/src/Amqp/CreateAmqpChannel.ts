import amqplib, { AmqpConnectionManagerOptions, ChannelWrapper, ConnectionUrl } from "amqp-connection-manager";

export function createAmqpChannel(urls: ConnectionUrl | ConnectionUrl[] | null | undefined, options?: AmqpConnectionManagerOptions | undefined): ChannelWrapper {
    const connection = amqplib.connect(urls, options);
    return connection.createChannel();
}
