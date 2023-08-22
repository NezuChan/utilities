-- CreateEnum
CREATE TYPE "CaseType" AS ENUM ('BAN', 'KICK', 'MUTE', 'UNBAN', 'UNMUTE', 'WARN');

-- CreateEnum
CREATE TYPE "PhisingLevel" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'HIGHEST');

-- CreateEnum
CREATE TYPE "TierType" AS ENUM ('FREE', 'SUPPORTER', 'TIER_1', 'TIER_2', 'TIER_3');

-- CreateEnum
CREATE TYPE "PremiumType" AS ENUM ('OTHER', 'PATREON', 'GIVEAWAY');

-- CreateTable
CREATE TABLE "Guild" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "locale" TEXT NOT NULL DEFAULT 'en-US',
    "prefix" TEXT NOT NULL DEFAULT 'n!',
    "premiumTierType" "TierType" NOT NULL DEFAULT 'FREE',
    "premiumActivatedBy" TEXT,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Instance" (
    "instanceId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Instance_pkey" PRIMARY KEY ("instanceId")
);

-- CreateTable
CREATE TABLE "TempVoice" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "parentChannelId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "taskId" TEXT,

    CONSTRAINT "TempVoice_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Case" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "caseId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "executorId" TEXT NOT NULL,
    "type" "CaseType" NOT NULL,

    CONSTRAINT "Case_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "DJRole" (
    "roleId" VARCHAR NOT NULL,
    "authorId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,

    CONSTRAINT "DJRole_pkey" PRIMARY KEY ("guildId","clientId","roleId")
);

-- CreateTable
CREATE TABLE "DJUser" (
    "userId" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,

    CONSTRAINT "DJUser_pkey" PRIMARY KEY ("guildId","clientId","userId")
);

-- CreateTable
CREATE TABLE "defaultVolume" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "defaultVolume" INTEGER NOT NULL DEFAULT 100,

    CONSTRAINT "defaultVolume_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "clearQueueAfterEnd" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "clearQueueAfterEnd_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "DJMode" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "DJMode_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "autoPlay" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "autoPlay_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "announceTrackStart" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "channel" TEXT,

    CONSTRAINT "announceTrackStart_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "StayInVc" (
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "StayInVc_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Invite" (
    "id" INTEGER NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "adminBypass" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Invite_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Phising" (
    "id" INTEGER NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "level" "PhisingLevel" NOT NULL DEFAULT 'MEDIUM',

    CONSTRAINT "Phising_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "User" (
    "userId" TEXT NOT NULL,
    "email" TEXT,
    "patreonUserId" TEXT,
    "tier" "TierType" NOT NULL DEFAULT 'FREE',
    "type" "PremiumType" NOT NULL DEFAULT 'OTHER',
    "additionalTracksSize" INTEGER NOT NULL DEFAULT 0,
    "additionalPlaylistsSize" INTEGER NOT NULL DEFAULT 0,
    "tier1Tickets" INTEGER NOT NULL DEFAULT 0,
    "tier2Tickets" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
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
CREATE UNIQUE INDEX "Phising_guildId_key" ON "Phising"("guildId");

-- AddForeignKey
ALTER TABLE "Instance" ADD CONSTRAINT "Instance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "TempVoice" ADD CONSTRAINT "TempVoice_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Case" ADD CONSTRAINT "Case_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DJRole" ADD CONSTRAINT "DJRole_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DJUser" ADD CONSTRAINT "DJUser_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "defaultVolume" ADD CONSTRAINT "defaultVolume_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "clearQueueAfterEnd" ADD CONSTRAINT "clearQueueAfterEnd_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "DJMode" ADD CONSTRAINT "DJMode_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "autoPlay" ADD CONSTRAINT "autoPlay_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "announceTrackStart" ADD CONSTRAINT "announceTrackStart_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "StayInVc" ADD CONSTRAINT "StayInVc_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Invite" ADD CONSTRAINT "Invite_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Phising" ADD CONSTRAINT "Phising_guildId_clientId_fkey" FOREIGN KEY ("guildId", "clientId") REFERENCES "Guild"("guildId", "clientId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "PlaylistTrack" ADD CONSTRAINT "PlaylistTrack_playlistId_fkey" FOREIGN KEY ("playlistId") REFERENCES "Playlist"("playlistId") ON DELETE CASCADE ON UPDATE NO ACTION;
