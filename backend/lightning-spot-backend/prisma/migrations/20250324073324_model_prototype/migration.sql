/*
  Warnings:

  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to alter the column `email` on the `User` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `username` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'MEMBER');

-- CreateEnum
CREATE TYPE "LightningCategory" AS ENUM ('CODING', 'ETC', 'TOUR');

-- CreateEnum
CREATE TYPE "LightningStatus" AS ENUM ('RECRUITING', 'CLOSED', 'CANCELED', 'FINISHED', 'ONGOING');

-- CreateEnum
CREATE TYPE "BlahPostCategory" AS ENUM ('RECOMMEND', 'ETC');

-- CreateEnum
CREATE TYPE "NoticeCategory" AS ENUM ('EVENT', 'GUIDE', 'WARNING');

-- AlterTable
ALTER TABLE "User" DROP COLUMN "name",
ADD COLUMN     "password" VARCHAR(255) NOT NULL,
ADD COLUMN     "role" "Role" NOT NULL,
ADD COLUMN     "username" VARCHAR(100) NOT NULL,
ALTER COLUMN "email" SET DATA TYPE VARCHAR(255);

-- CreateTable
CREATE TABLE "LightningPost" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "scheduledAt" TIMESTAMP(3) NOT NULL,
    "status" "LightningStatus" NOT NULL,
    "category" "LightningCategory" NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "LightningPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LightningPostLike" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "lightningPostId" INTEGER NOT NULL,

    CONSTRAINT "LightningPostLike_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LightningPostComment" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "content" TEXT NOT NULL,
    "lightningPostId" INTEGER NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "LightningPostComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BlahPost" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "category" "BlahPostCategory" NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "BlahPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BlahPostComment" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "content" TEXT NOT NULL,
    "userId" INTEGER,
    "blahPostId" INTEGER NOT NULL,

    CONSTRAINT "BlahPostComment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BlahPostLike" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "blahPostId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "BlahPostLike_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notice" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "category" "NoticeCategory" NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Notice_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "LightningPost_title_idx" ON "LightningPost"("title");

-- CreateIndex
CREATE INDEX "LightningPost_category_idx" ON "LightningPost"("category");

-- CreateIndex
CREATE INDEX "LightningPostLike_userId_idx" ON "LightningPostLike"("userId");

-- CreateIndex
CREATE INDEX "LightningPostLike_lightningPostId_idx" ON "LightningPostLike"("lightningPostId");

-- CreateIndex
CREATE INDEX "BlahPostComment_userId_idx" ON "BlahPostComment"("userId");

-- CreateIndex
CREATE INDEX "BlahPostComment_blahPostId_idx" ON "BlahPostComment"("blahPostId");

-- CreateIndex
CREATE INDEX "BlahPostLike_userId_idx" ON "BlahPostLike"("userId");

-- CreateIndex
CREATE INDEX "BlahPostLike_blahPostId_idx" ON "BlahPostLike"("blahPostId");

-- AddForeignKey
ALTER TABLE "LightningPost" ADD CONSTRAINT "LightningPost_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LightningPostLike" ADD CONSTRAINT "LightningPostLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LightningPostLike" ADD CONSTRAINT "LightningPostLike_lightningPostId_fkey" FOREIGN KEY ("lightningPostId") REFERENCES "LightningPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LightningPostComment" ADD CONSTRAINT "LightningPostComment_lightningPostId_fkey" FOREIGN KEY ("lightningPostId") REFERENCES "LightningPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LightningPostComment" ADD CONSTRAINT "LightningPostComment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlahPost" ADD CONSTRAINT "BlahPost_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlahPostComment" ADD CONSTRAINT "BlahPostComment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlahPostComment" ADD CONSTRAINT "BlahPostComment_blahPostId_fkey" FOREIGN KEY ("blahPostId") REFERENCES "BlahPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlahPostLike" ADD CONSTRAINT "BlahPostLike_blahPostId_fkey" FOREIGN KEY ("blahPostId") REFERENCES "BlahPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BlahPostLike" ADD CONSTRAINT "BlahPostLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notice" ADD CONSTRAINT "Notice_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;
