/*
  Warnings:

  - The primary key for the `Case` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `DJMode` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `DJRole` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `DJUser` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Guild` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Invite` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Phising` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `StayInVc` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `TempVoice` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `announceTrackStart` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `autoPlay` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `clearQueueAfterEnd` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `defaultVolume` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `clientId` to the `Case` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `DJMode` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `DJRole` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `DJUser` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `Invite` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `Phising` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `StayInVc` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `TempVoice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `announceTrackStart` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `autoPlay` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `clearQueueAfterEnd` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clientId` to the `defaultVolume` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Case" DROP CONSTRAINT "Case_guildId_fkey";

-- DropForeignKey
ALTER TABLE "DJMode" DROP CONSTRAINT "DJMode_guildId_fkey";

-- DropForeignKey
ALTER TABLE "DJRole" DROP CONSTRAINT "DJRole_guildId_fkey";

-- DropForeignKey
ALTER TABLE "DJUser" DROP CONSTRAINT "DJUser_guildId_fkey";

-- DropForeignKey
ALTER TABLE "Invite" DROP CONSTRAINT "Invite_guildId_fkey";

-- DropForeignKey
ALTER TABLE "Phising" DROP CONSTRAINT "Phising_guildId_fkey";

-- DropForeignKey
ALTER TABLE "StayInVc" DROP CONSTRAINT "StayInVc_guildId_fkey";

-- DropForeignKey
ALTER TABLE "TempVoice" DROP CONSTRAINT "TempVoice_guildId_fkey";

-- DropForeignKey
ALTER TABLE "announceTrackStart" DROP CONSTRAINT "announceTrackStart_guildId_fkey";

-- DropForeignKey
ALTER TABLE "autoPlay" DROP CONSTRAINT "autoPlay_guildId_fkey";

-- DropForeignKey
ALTER TABLE "clearQueueAfterEnd" DROP CONSTRAINT "clearQueueAfterEnd_guildId_fkey";

-- DropForeignKey
ALTER TABLE "defaultVolume" DROP CONSTRAINT "defaultVolume_guildId_fkey";

-- DropIndex
DROP INDEX "Invite_guildId_key";

-- AlterTable
ALTER TABLE "Case" DROP CONSTRAINT "Case_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ADD CONSTRAINT "Case_pkey" PRIMARY KEY ("guildId", "clientId");
DROP SEQUENCE "Case_id_seq";

-- AlterTable
ALTER TABLE "DJMode" DROP CONSTRAINT "DJMode_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "DJMode_pkey" PRIMARY KEY ("guildId", "clientId");

-- AlterTable
ALTER TABLE "DJRole" DROP CONSTRAINT "DJRole_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ADD CONSTRAINT "DJRole_pkey" PRIMARY KEY ("guildId", "clientId");
DROP SEQUENCE "DJRole_id_seq";

-- AlterTable
ALTER TABLE "DJUser" DROP CONSTRAINT "DJUser_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ADD CONSTRAINT "DJUser_pkey" PRIMARY KEY ("guildId", "clientId");
DROP SEQUENCE "DJUser_id_seq";

-- AlterTable
ALTER TABLE "Guild" DROP CONSTRAINT "Guild_pkey",
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "Guild_pkey" PRIMARY KEY ("guildId", "clientId");

-- AlterTable
ALTER TABLE "Invite" DROP CONSTRAINT "Invite_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ADD CONSTRAINT "Invite_pkey" PRIMARY KEY ("guildId", "clientId");
DROP SEQUENCE "Invite_id_seq";

-- AlterTable
ALTER TABLE "Phising" DROP CONSTRAINT "Phising_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ADD CONSTRAINT "Phising_pkey" PRIMARY KEY ("guildId", "clientId");
DROP SEQUENCE "Phising_id_seq";

-- AlterTable
ALTER TABLE "StayInVc" DROP CONSTRAINT "StayInVc_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "StayInVc_pkey" PRIMARY KEY ("guildId", "clientId");

-- AlterTable
ALTER TABLE "TempVoice" DROP CONSTRAINT "TempVoice_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ADD CONSTRAINT "TempVoice_pkey" PRIMARY KEY ("guildId", "clientId");
DROP SEQUENCE "TempVoice_id_seq";

-- AlterTable
ALTER TABLE "User" DROP CONSTRAINT "User_pkey",
ALTER COLUMN "id" DROP DEFAULT;
DROP SEQUENCE "User_id_seq";

-- AlterTable
ALTER TABLE "announceTrackStart" DROP CONSTRAINT "announceTrackStart_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "announceTrackStart_pkey" PRIMARY KEY ("guildId", "clientId");

-- AlterTable
ALTER TABLE "autoPlay" DROP CONSTRAINT "autoPlay_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "autoPlay_pkey" PRIMARY KEY ("guildId", "clientId");

-- AlterTable
ALTER TABLE "clearQueueAfterEnd" DROP CONSTRAINT "clearQueueAfterEnd_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "clearQueueAfterEnd_pkey" PRIMARY KEY ("guildId", "clientId");

-- AlterTable
ALTER TABLE "defaultVolume" DROP CONSTRAINT "defaultVolume_pkey",
ADD COLUMN     "clientId" TEXT NOT NULL,
ALTER COLUMN "guildId" SET DATA TYPE TEXT,
ADD CONSTRAINT "defaultVolume_pkey" PRIMARY KEY ("guildId", "clientId");

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
