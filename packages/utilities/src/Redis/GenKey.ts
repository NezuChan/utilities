export function GenKey(clientId: string, prefix: string, key?: string, guildId?: string): string {
    return guildId ? [clientId, prefix, guildId, key].join(":") : [clientId, prefix, key].join(":");
}
