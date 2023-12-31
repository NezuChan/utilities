/* eslint-disable max-len */
import { Redis, Cluster, NatMap, NodeRole, ClusterNode } from "ioredis";

export function createRedis({ redisPassword, redisUsername, redisHost, redisPort, redisDb, redisClusters, redisClusterScaleReads, redisNatMap, enableAutoPipelining = true }: CreateRedisOptions): Cluster | Redis {
    return redisClusters?.length
        ? new Cluster(
            redisClusters,
            {
                scaleReads: redisClusterScaleReads,
                redisOptions: {
                    password: redisPassword,
                    username: redisUsername,
                    db: redisDb
                },
                natMap: redisNatMap,
                enableAutoPipelining
            }
        )
        : new Redis({
            username: redisUsername,
            password: redisPassword,
            host: redisHost,
            port: redisPort,
            db: redisDb,
            natMap: redisNatMap,
            enableAutoPipelining
        });
}

export interface CreateRedisOptions {
    redisPassword?: string;
    redisUsername?: string;
    redisHost?: string;
    redisPort?: number;
    redisDb?: number;
    redisClusters?: ClusterNode[];
    redisClusterScaleReads?: NodeRole;
    redisNatMap?: NatMap;
    enableAutoPipelining: boolean;
}
