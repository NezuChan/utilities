import amqplib from "amqplib";

export async function createAmqpChannel(url: amqplib.Options.Connect | string, socketOptions?: any): Promise<amqplib.Channel> {
    const connection = await amqplib.connect(url, socketOptions);
    return connection.createChannel();
}
