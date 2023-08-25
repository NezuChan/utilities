/*
  Warnings:

  - You are about to drop the column `additionalPlaylistsSize` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `additionalTracksSize` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "User" DROP COLUMN "additionalPlaylistsSize",
DROP COLUMN "additionalTracksSize";
