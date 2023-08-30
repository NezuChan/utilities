/*
  Warnings:

  - You are about to drop the column `node` on the `Instance` table. All the data in the column will be lost.
  - The `memoryLimit` column on the `Instance` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `nodeId` to the `Instance` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Instance" DROP COLUMN "node",
ADD COLUMN     "nodeId" TEXT NOT NULL,
DROP COLUMN "memoryLimit",
ADD COLUMN     "memoryLimit" INTEGER NOT NULL DEFAULT 128;

-- CreateTable
CREATE TABLE "InstanceNode" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "memoryLimit" INTEGER NOT NULL DEFAULT 1024,
    "ip" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InstanceNode_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Instance" ADD CONSTRAINT "Instance_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "InstanceNode"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
