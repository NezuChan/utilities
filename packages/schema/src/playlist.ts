import { pgTable, uuid, text, pgEnum, integer, json } from "drizzle-orm/pg-core";
import { LavalinkTrack } from "lavalink-api-types/v3";
import { createdAt, updatedAt } from "./index.js";

export const Visibility = pgEnum("Visibility", ["PUBLIC", "PRIVATE"]);

export const Playlist = pgTable("playlist", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    externalId: text("external_id").unique(),
    userId: text("user_id"),

    name: text("name"),
    visibility: Visibility("visibility").default("PUBLIC"),
    trackLimit: integer("track_limit").default(20),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});

export const PlaylistTrack = pgTable("playlist_track", {
    id: uuid("id").primaryKey()
        .defaultRandom(),

    playlistId: uuid("playlist_id").references(() => Playlist.id),
    externalId: text("external_id").unique(),
    userId: text("user_id"),

    track: json("track").$type<LavalinkTrack>(),

    createdAt: createdAt(),
    updatedAt: updatedAt()
});
