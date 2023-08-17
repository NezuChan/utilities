/*
  Warnings:

  - You are about to drop the `PremiumUser` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `clientId` to the `Guild` table without a default value. This is not possible if the table is not empty.
  - Made the column `prefix` on table `Guild` required. This step will fail if there are existing NULL values in that column.

*/
-- CreateEnum
CREATE TYPE "CaseType" AS ENUM ('BAN', 'KICK', 'MUTE', 'UNBAN', 'UNMUTE', 'WARN');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "TierType" ADD VALUE 'SUPPORTER';
ALTER TYPE "TierType" ADD VALUE 'TIER_3';

-- AlterTable
ALTER TABLE "Guild" ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "prefix" SET NOT NULL,
ALTER COLUMN "prefix" SET DEFAULT 'n!';

-- DropTable
DROP TABLE "PremiumUser";

-- CreateTable
CREATE TABLE "Instance" (
    "id" SERIAL NOT NULL,
    "instanceId" TEXT NOT NULL,
    "guildId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Instance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TempVoice" (
    "id" SERIAL NOT NULL,
    "guildId" TEXT NOT NULL,
    "channelId" TEXT NOT NULL,
    "parentChannelId" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "taskId" TEXT,

    CONSTRAINT "TempVoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Case" (
    "id" SERIAL NOT NULL,
    "guildId" TEXT NOT NULL,
    "caseId" VARCHAR NOT NULL,
    "userId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "executorId" TEXT NOT NULL,
    "type" "CaseType" NOT NULL,

    CONSTRAINT "Case_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "patreonUserId" TEXT,
    "tier" "TierType" NOT NULL DEFAULT 'FREE',
    "type" "PremiumType" NOT NULL DEFAULT 'OTHER',
    "additionalTracksSize" INTEGER NOT NULL DEFAULT 0,
    "additionalPlaylistsSize" INTEGER NOT NULL DEFAULT 0,
    "tier1Tickets" INTEGER NOT NULL DEFAULT 0,
    "tier2Tickets" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Instance_instanceId_key" ON "Instance"("instanceId");

-- CreateIndex
CREATE UNIQUE INDEX "User_userId_key" ON "User"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "User_patreonUserId_key" ON "User"("patreonUserId");

-- AddForeignKey
ALTER TABLE "Instance" ADD CONSTRAINT "Instance_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "TempVoice" ADD CONSTRAINT "TempVoice_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Case" ADD CONSTRAINT "Case_guildId_fkey" FOREIGN KEY ("guildId") REFERENCES "Guild"("guildId") ON DELETE CASCADE ON UPDATE NO ACTION;
