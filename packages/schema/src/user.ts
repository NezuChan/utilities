import { pgEnum, pgTable, text, timestamp, uuid } from "drizzle-orm/pg-core";
import { createdAt, updatedAt } from "./index.js";

export const TierType = pgEnum("TierType", ["FREE", "SUPPORTER", "TIER_1", "TIER_2", "TIER_3"]);

export const User = pgTable("user", {
    id: uuid("id").primaryKey()
        .defaultRandom(),
    email: text("email"),
    discordId: text("discord_id")
        .unique(),
    patreonId: text("patreon_id")
        .unique(),

    premiumProvider: text("premium_provider").default("UNKNOWN"),
    premiumTier: TierType("premium_tier").default("FREE"),
    premiumStartAt: timestamp("premium_start_at").defaultNow(),
    premiumEndsAt: timestamp("premium_ends_at"),

    createdAt: createdAt(),
    updatedAt: updatedAt(),

    votedAt: timestamp("voted_at")
});
