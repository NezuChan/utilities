import { Redis, Cluster } from "ioredis";

export function redisScan(redis: Cluster | Redis, key: string, match: string, count: number): Promise<string[]> {
    return new Promise((resolve, reject) => {
        const keys: string[] = [];
        redis.sscanStream(key, { match, count })
            .on("data", (keyChunk: string[]) => keys.push(...keyChunk))
            .on("end", () => resolve(keys))
            .on("error", reject);
    });
}

export function redisSScan(redis: Cluster | Redis, key: string, match: string, count: number): Promise<string[]> {
    return new Promise((resolve, reject) => {
        const keys: string[] = [];
        redis.sscanStream(key, { match, count })
            .on("data", (keyChunk: string[]) => keys.push(...keyChunk))
            .on("end", () => resolve(keys))
            .on("error", reject);
    });
}
