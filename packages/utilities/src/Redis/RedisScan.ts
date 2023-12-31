import { Redis, Cluster, NodeRole } from "ioredis";

export function redisScan(redis: Cluster | Redis, key: string, count: number, nodeRole: NodeRole = "slave"): Promise<string[]> {
    return new Promise((resolve, reject) => {
        const keys: string[] = [];

        if (redis instanceof Cluster) {
            const results = redis.nodes(nodeRole).map(node => redisScan(node, key, count, nodeRole));
            Promise.all(results)
                .then(res => {
                    res.forEach(result => keys.push(...result));
                    resolve(keys);
                })
                .catch(reject);
        } else {
            redis.scanStream({ match: `${key}*`, count })
                .on("data", (keyChunk: string[]) => keys.push(...keyChunk))
                .on("end", () => resolve(keys))
                .on("error", reject);
        }
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
