/*
  Warnings:

  - The primary key for the `DJRole` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `DJUser` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE "DJRole" DROP CONSTRAINT "DJRole_pkey",
ADD CONSTRAINT "DJRole_pkey" PRIMARY KEY ("guildId", "clientId", "roleId");

-- AlterTable
ALTER TABLE "DJUser" DROP CONSTRAINT "DJUser_pkey",
ADD CONSTRAINT "DJUser_pkey" PRIMARY KEY ("guildId", "clientId", "userId");
