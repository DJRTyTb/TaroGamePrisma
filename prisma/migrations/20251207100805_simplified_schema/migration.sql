/*
  Warnings:

  - You are about to drop the column `currencyId` on the `items` table. All the data in the column will be lost.
  - You are about to drop the column `isTradeable` on the `items` table. All the data in the column will be lost.
  - You are about to drop the `currencies` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `game_config` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `shop_items` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transactions` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "items" DROP CONSTRAINT "items_currencyId_fkey";

-- DropForeignKey
ALTER TABLE "shop_items" DROP CONSTRAINT "shop_items_itemId_fkey";

-- DropForeignKey
ALTER TABLE "shop_items" DROP CONSTRAINT "shop_items_priceCurrency_fkey";

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_currencyId_fkey";

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_itemId_fkey";

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_playerId_fkey";

-- DropIndex
DROP INDEX "items_currencyId_key";

-- AlterTable
ALTER TABLE "items" DROP COLUMN "currencyId",
DROP COLUMN "isTradeable";

-- DropTable
DROP TABLE "currencies";

-- DropTable
DROP TABLE "game_config";

-- DropTable
DROP TABLE "shop_items";

-- DropTable
DROP TABLE "transactions";
