export function RoutingKey(clientId: string, id: number | string): string {
    return `${clientId}:${id}`;
}

export function RoutingKeyToId(clientId: string, routingKey: string): number {
    return parseInt(routingKey.split(":")[1]);
}
