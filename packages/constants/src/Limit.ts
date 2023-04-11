export enum QueueLimit {
    FREE = 350,
    USER_TIER_1 = 512,
    GUILD_TIER_1 = 320,
    VOTE = 800,
    TIER_2 = Number.MAX_SAFE_INTEGER
}

export enum PlaylistLimit {
    FREE = 5,
    TIER_1 = 10,
    TIER_2 = 30
}

export enum PlaylistTrackLimit {
    FREE = 20,
    TIER_1 = 40,
    TIER_2 = 70
}

export function resolveQueueLimit(tier: number | string, user?: boolean): number {
    switch (tier) {
        case "TIER_1":
        case 1:
            return user ? QueueLimit.USER_TIER_1 : QueueLimit.GUILD_TIER_1;
        case "TIER_2":
        case 2:
            return QueueLimit.TIER_2;
        default:
            return QueueLimit.FREE;
    }
}

export function resolvePlaylistLimit(tier: number | string): number {
    switch (tier) {
        case "TIER_1":
        case 1:
            return PlaylistLimit.TIER_1;
        case "TIER_2":
        case 2:
            return PlaylistLimit.TIER_2;
        default:
            return PlaylistLimit.FREE;
    }
}

export function resolvePlaylistTrackLimit(tier: number | string): number {
    switch (tier) {
        case "TIER_1":
        case 1:
            return PlaylistTrackLimit.TIER_1;
        case "TIER_2":
        case 2:
            return PlaylistTrackLimit.TIER_2;
        default:
            return PlaylistTrackLimit.FREE;
    }
}
