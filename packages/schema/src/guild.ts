import { boolean, integer, pgTable, text, timestamp, uuid } from "drizzle-orm/pg-core";
import { TierType, User } from "./user.js";
import { createdAt, updatedAt } from "./index.js";
import { sql } from "drizzle-orm";

export const Guild = pgTable("guild", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    guildId: text("guild_id"),
    clientId: text("client_id"),

    keyId: text("key_id"),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});

export const ActivationKey = pgTable("activation_key", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    tier: TierType("tier").default("FREE"),
    provider: text("provider"),

    guildId: uuid("guild_id").references(() => Guild.id),
    clientId: text("client_id"),

    startAt: timestamp("start_at"),
    endsAt: timestamp("ends_at"),

    key: text("key"),

    userId: uuid("user_id").references(() => User.id),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});

export const DefaultVolume = pgTable("default_volume", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    guildId: uuid("guild_id").references(() => Guild.id),
    clientId: text("client_id"),

    activatedBy: text("activated_by"),
    state: integer("state").default(100),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});

export const Crossfade = pgTable("crossfade", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    guildId: uuid("guild_id").references(() => Guild.id),
    clientId: text("client_id"),

    activatedBy: text("activated_by"),
    state: boolean("state").default(false),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});

export const Gapless = pgTable("gapless", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    guildId: uuid("guild_id").references(() => Guild.id),
    clientId: text("client_id"),

    activatedBy: text("activated_by"),
    state: boolean("state").default(false),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});


export const StayInVc = pgTable("stay_in_vc", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    guildId: uuid("guild_id").references(() => Guild.id),
    clientId: text("client_id"),

    activatedBy: text("activated_by"),
    state: boolean("state").default(false),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});

export const DJ = pgTable("dj", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    guildId: uuid("guild_id").references(() => Guild.id),
    clientId: text("client_id"),

    activatedBy: text("activated_by"),
    state: boolean("state").default(false),

    createdAt: createdAt(),
    updatedAt: updatedAt(),

    users: text("users")
        .array()
        .notNull()
        .default(sql`'{}'::text[]`),
    roles: text("roles")
        .array()
        .notNull()
        .default(sql`'{}'::text[]`)
});
