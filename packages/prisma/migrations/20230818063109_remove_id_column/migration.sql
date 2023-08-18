/*
  Warnings:

  - You are about to drop the column `id` on the `Case` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `DJRole` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `DJUser` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `TempVoice` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Case" DROP COLUMN "id";

-- AlterTable
ALTER TABLE "DJRole" DROP COLUMN "id";

-- AlterTable
ALTER TABLE "DJUser" DROP COLUMN "id";

-- AlterTable
ALTER TABLE "TempVoice" DROP COLUMN "id";
