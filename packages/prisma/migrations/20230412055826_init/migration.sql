-- CreateEnum
CREATE TYPE "PhisingLevel" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'HIGHEST');

-- CreateEnum
CREATE TYPE "TierType" AS ENUM ('FREE', 'TIER_1', 'TIER_2');

-- CreateEnum
CREATE TYPE "PremiumType" AS ENUM ('OTHER', 'PATREON', 'GIVEAWAY');

-- CreateTable
CREATE TABLE "Guild" (
    "guildId" VARCHAR NOT NULL,
    "locale" TEXT NOT NULL DEFAULT 'en-US',
    "prefix" TEXT,
    "premiumTierType" "TierType" NOT NULL DEFAULT 'FREE',
    "premiumActivatedBy" TEXT,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "DJRole" (
    "id" SERIAL NOT NULL,
    "roleId" VARCHAR NOT NULL,
    "authorId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,

    CONSTRAINT "DJRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DJUser" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,

    CONSTRAINT "DJUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "defaultVolume" (
    "guildId" VARCHAR NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "defaultVolume" INTEGER NOT NULL DEFAULT 100,

    CONSTRAINT "defaultVolume_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "clearQueueAfterEnd" (
    "guildId" VARCHAR NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "clearQueueAfterEnd_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "DJMode" (
    "guildId" VARCHAR NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "DJMode_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "autoPlay" (
    "guildId" VARCHAR NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "autoPlay_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "announceTrackStart" (
    "guildId" VARCHAR NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "channel" TEXT,

    CONSTRAINT "announceTrackStart_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "StayInVc" (
    "guildId" VARCHAR NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "StayInVc_pkey" PRIMARY KEY ("guildId")
);

-- CreateTable
CREATE TABLE "PremiumUser" (
    "id" SERIAL NOT NULL,
    "userId" TEXT,
    "patreonUserId" TEXT,
    "tier" "TierType" NOT NULL DEFAULT 'FREE',
    "type" "PremiumType" NOT NULL DEFAULT 'OTHER',
    "additionalTracksSize" INTEGER NOT NULL DEFAULT 0,
    "additionalPlaylistsSize" INTEGER NOT NULL DEFAULT 0,
    "tier1Tickets" INTEGER NOT NULL DEFAULT 0,
    "tier2Tickets" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "PremiumUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invite" (
    "id" SERIAL NOT NULL,
    "guildId" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "adminBypass" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Invite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Phising" (
    "id" SERIAL NOT NULL,
    "guildId" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "level" "PhisingLevel" NOT NULL DEFAULT 'MEDIUM',

    CONSTRAINT "Phising_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Playlist" (
    "playlistId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "playlistName" TEXT NOT NULL,
    "trackLimit" INTEGER NOT NULL DEFAULT 20,

    CONSTRAINT "Playlist_pkey" PRIMARY KEY ("playlistId")
);

-- CreateTable
CREATE TABLE "PlaylistTrack" (
    "trackId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "playlistId" TEXT NOT NULL,
    "track" JSONB NOT NULL,

    CONSTRAINT "PlaylistTrack_pkey" PRIMARY KEY ("trackId")
);

-- CreateIndex
CREATE UNIQUE INDEX "PremiumUser_userId_key" ON "PremiumUser"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PremiumUser_patreonUserId_key" ON "PremiumUser"("patreonUserId");

-- CreateIndex
CREATE UNIQUE INDEX "Invite_guildId_key" ON "Invite"("guildId");

-- CreateIndex
CREATE UNIQUE INDEX "Phising_guildId_key" ON "Phising"("guildId");

-- AddForeignKey
ALTER TABLE "DJRole" ADD CONSTRAINT "DJRole_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DJUser" ADD CONSTRAINT "DJUser_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "defaultVolume" ADD CONSTRAINT "defaultVolume_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "clearQueueAfterEnd" ADD CONSTRAINT "clearQueueAfterEnd_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DJMode" ADD CONSTRAINT "DJMode_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "autoPlay" ADD CONSTRAINT "autoPlay_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "announceTrackStart" ADD CONSTRAINT "announceTrackStart_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "StayInVc" ADD CONSTRAINT "StayInVc_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Invite" ADD CONSTRAINT "Invite_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Phising" ADD CONSTRAINT "Phising_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "PlaylistTrack" ADD CONSTRAINT "PlaylistTrack_playlistId_fkey" FOREIGN KEY ("playlistId") REFERENCES "Playlist"("playlistId") ON DELETE CASCADE ON UPDATE NO ACTION;
