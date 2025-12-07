/*
  Warnings:

  - You are about to drop the column `entityId` on the `items` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `items` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[tarotCardId]` on the table `items` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[shapeId]` on the table `items` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[currencyId]` on the table `items` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "items_type_entityId_key";

-- AlterTable
ALTER TABLE "items" DROP COLUMN "entityId",
DROP COLUMN "type",
ADD COLUMN     "currencyId" TEXT,
ADD COLUMN     "shapeId" TEXT,
ADD COLUMN     "tarotCardId" TEXT;

-- DropEnum
DROP TYPE "ItemType";

-- CreateIndex
CREATE UNIQUE INDEX "items_tarotCardId_key" ON "items"("tarotCardId");

-- CreateIndex
CREATE UNIQUE INDEX "items_shapeId_key" ON "items"("shapeId");

-- CreateIndex
CREATE UNIQUE INDEX "items_currencyId_key" ON "items"("currencyId");

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_tarotCardId_fkey" FOREIGN KEY ("tarotCardId") REFERENCES "tarot_cards"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_shapeId_fkey" FOREIGN KEY ("shapeId") REFERENCES "shapes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_currencyId_fkey" FOREIGN KEY ("currencyId") REFERENCES "currencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;
