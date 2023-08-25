-- CreateEnum
CREATE TYPE "PlaylistVisibility" AS ENUM ('PUBLIC', 'PRIVATE');

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
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "locale" TEXT NOT NULL DEFAULT 'en-US',
    "prefix" TEXT NOT NULL DEFAULT 'n!',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "premiumTierType" "TierType" NOT NULL DEFAULT 'FREE',
    "premiumActivatedBy" TEXT,

    CONSTRAINT "Guild_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "TempVoice" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "parentId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "taskId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TempVoice_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Case" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "caseId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "executorId" TEXT NOT NULL,
    "type" "CaseType" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Case_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "DJRole" (
    "id" TEXT NOT NULL,
    "roleId" VARCHAR NOT NULL,
    "authorId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DJRole_pkey" PRIMARY KEY ("guildId","clientId","roleId")
);

-- CreateTable
CREATE TABLE "DJUser" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DJUser_pkey" PRIMARY KEY ("guildId","clientId","userId")
);

-- CreateTable
CREATE TABLE "defaultVolume" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "defaultVolume" INTEGER NOT NULL DEFAULT 100,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "defaultVolume_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "clearQueueAfterEnd" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "clearQueueAfterEnd_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "DJMode" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DJMode_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "autoPlay" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "autoPlay_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "announceTrackStart" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "channel" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "announceTrackStart_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "StayInVc" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "activatedBy" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "StayInVc_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Invite" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "adminBypass" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Invite_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "Phising" (
    "id" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT false,
    "level" "PhisingLevel" NOT NULL DEFAULT 'MEDIUM',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Phising_pkey" PRIMARY KEY ("guildId","clientId")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "email" TEXT,
    "patreonUserId" TEXT,
    "tier" "TierType" NOT NULL DEFAULT 'FREE',
    "type" "PremiumType" NOT NULL DEFAULT 'OTHER',
    "additionalTracksSize" INTEGER NOT NULL DEFAULT 0,
    "additionalPlaylistsSize" INTEGER NOT NULL DEFAULT 0,
    "tier1Tickets" INTEGER NOT NULL DEFAULT 0,
    "tier2Tickets" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Playlist" (
    "id" TEXT NOT NULL,
    "playlistId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "playlistName" TEXT NOT NULL,
    "trackLimit" INTEGER NOT NULL DEFAULT 20,
    "visibility" "PlaylistVisibility" NOT NULL DEFAULT 'PUBLIC',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Playlist_pkey" PRIMARY KEY ("playlistId")
);

-- CreateTable
CREATE TABLE "PlaylistTrack" (
    "id" TEXT NOT NULL,
    "trackId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "playlistId" TEXT NOT NULL,
    "track" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlaylistTrack_pkey" PRIMARY KEY ("trackId")
);

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
