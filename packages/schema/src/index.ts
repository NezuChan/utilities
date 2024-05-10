import { HasDefault, NotNull } from "drizzle-orm";
import { PgTimestampBuilderInitial, timestamp } from "drizzle-orm/pg-core";

export function createdAt(name?: string): HasDefault<NotNull<PgTimestampBuilderInitial<string>>> {
    return timestamp(name ?? "created_at")
        .notNull()
        .defaultNow();
}

export function updatedAt(name?: string): HasDefault<NotNull<PgTimestampBuilderInitial<string>>> {
    return timestamp(name ?? "updated_at")
        .notNull()
        .$onUpdate(() => new Date());
}

export * from "./guild.js";
export * from "./user.js";
export * from "./playlist.js";
