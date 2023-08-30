-- CreateTable
CREATE TABLE "Instance" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "botId" TEXT NOT NULL,
    "memoryLimit" TEXT NOT NULL DEFAULT '128',
    "type" TEXT NOT NULL,
    "node" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Instance_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Instance" ADD CONSTRAINT "Instance_id_fkey" FOREIGN KEY ("id") REFERENCES "User"("userId") ON DELETE CASCADE ON UPDATE NO ACTION;
