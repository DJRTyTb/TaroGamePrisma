/*
  Warnings:

  - You are about to drop the `GameConfig` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Level` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `LevelProgress` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Player` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PlayerCard` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PlayerQuestProgress` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PlayerShape` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Quest` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Shape` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TarotCard` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Transaction` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('CARD', 'SHAPE', 'CURRENCY', 'BOOSTER', 'SKIN', 'OTHER');

-- DropForeignKey
ALTER TABLE "LevelProgress" DROP CONSTRAINT "LevelProgress_levelId_fkey";

-- DropForeignKey
ALTER TABLE "LevelProgress" DROP CONSTRAINT "LevelProgress_playerId_fkey";

-- DropForeignKey
ALTER TABLE "PlayerCard" DROP CONSTRAINT "PlayerCard_cardId_fkey";

-- DropForeignKey
ALTER TABLE "PlayerCard" DROP CONSTRAINT "PlayerCard_playerId_fkey";

-- DropForeignKey
ALTER TABLE "PlayerQuestProgress" DROP CONSTRAINT "PlayerQuestProgress_playerId_fkey";

-- DropForeignKey
ALTER TABLE "PlayerQuestProgress" DROP CONSTRAINT "PlayerQuestProgress_questId_fkey";

-- DropForeignKey
ALTER TABLE "PlayerShape" DROP CONSTRAINT "PlayerShape_playerId_fkey";

-- DropForeignKey
ALTER TABLE "PlayerShape" DROP CONSTRAINT "PlayerShape_shapeId_fkey";

-- DropForeignKey
ALTER TABLE "Transaction" DROP CONSTRAINT "Transaction_playerId_fkey";

-- DropTable
DROP TABLE "GameConfig";

-- DropTable
DROP TABLE "Level";

-- DropTable
DROP TABLE "LevelProgress";

-- DropTable
DROP TABLE "Player";

-- DropTable
DROP TABLE "PlayerCard";

-- DropTable
DROP TABLE "PlayerQuestProgress";

-- DropTable
DROP TABLE "PlayerShape";

-- DropTable
DROP TABLE "Quest";

-- DropTable
DROP TABLE "Shape";

-- DropTable
DROP TABLE "TarotCard";

-- DropTable
DROP TABLE "Transaction";

-- CreateTable
CREATE TABLE "players" (
    "id" TEXT NOT NULL,
    "telegramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastDailyLevelDate" TIMESTAMP(3),
    "streak" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "players_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tarot_cards" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "rarity" INTEGER NOT NULL,
    "descriptionTemplate" TEXT,
    "imageBaseUrl" TEXT NOT NULL,
    "isSpecial" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "tarot_cards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shapes" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "complexityLevel" INTEGER NOT NULL,
    "spriteUrl" TEXT,
    "unlockCondition" JSONB,

    CONSTRAINT "shapes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "items" (
    "id" TEXT NOT NULL,
    "type" "ItemType" NOT NULL,
    "entityId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "rarity" INTEGER NOT NULL DEFAULT 1,
    "iconUrl" TEXT,
    "isTradeable" BOOLEAN NOT NULL DEFAULT false,
    "maxStack" INTEGER NOT NULL DEFAULT 1,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_items" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "obtainedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metadata" JSONB DEFAULT '{}',

    CONSTRAINT "inventory_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "levels" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3),
    "data" JSONB NOT NULL,
    "patternsAvailable" JSONB,

    CONSTRAINT "levels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "level_progress" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "levelId" TEXT NOT NULL,
    "starsEarned" INTEGER NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "level_progress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quests" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "conditionJson" JSONB NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "repeatsDaily" BOOLEAN NOT NULL DEFAULT false,
    "maxCompletions" INTEGER,

    CONSTRAINT "quests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "player_quest_progress" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "questId" TEXT NOT NULL,
    "completions" INTEGER NOT NULL DEFAULT 0,
    "lastCompletedAt" TIMESTAMP(3),
    "progressData" JSONB DEFAULT '{}',

    CONSTRAINT "player_quest_progress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quest_rewards" (
    "id" TEXT NOT NULL,
    "questId" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "probability" INTEGER NOT NULL DEFAULT 100,
    "isGuaranteed" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "quest_rewards_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "currencies" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "iconUrl" TEXT,
    "isPremium" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "currencies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shop_items" (
    "id" TEXT NOT NULL,
    "itemId" TEXT NOT NULL,
    "priceCurrency" TEXT,
    "priceAmount" INTEGER NOT NULL,
    "discount" INTEGER DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "availableFrom" TIMESTAMP(3),
    "availableTo" TIMESTAMP(3),

    CONSTRAINT "shop_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "itemId" TEXT,
    "currencyId" TEXT,
    "amount" INTEGER,
    "quantity" INTEGER,
    "type" TEXT NOT NULL,
    "metadata" JSONB DEFAULT '{}',
    "context" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "game_config" (
    "id" TEXT NOT NULL DEFAULT 'main',
    "data" JSONB NOT NULL DEFAULT '{}',
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "game_config_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "players_telegramId_key" ON "players"("telegramId");

-- CreateIndex
CREATE UNIQUE INDEX "items_type_entityId_key" ON "items"("type", "entityId");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_items_playerId_itemId_key" ON "inventory_items"("playerId", "itemId");

-- CreateIndex
CREATE UNIQUE INDEX "level_progress_playerId_levelId_key" ON "level_progress"("playerId", "levelId");

-- CreateIndex
CREATE UNIQUE INDEX "player_quest_progress_playerId_questId_key" ON "player_quest_progress"("playerId", "questId");

-- CreateIndex
CREATE UNIQUE INDEX "quest_rewards_questId_itemId_key" ON "quest_rewards"("questId", "itemId");

-- CreateIndex
CREATE UNIQUE INDEX "currencies_code_key" ON "currencies"("code");

-- AddForeignKey
ALTER TABLE "inventory_items" ADD CONSTRAINT "inventory_items_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_items" ADD CONSTRAINT "inventory_items_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "level_progress" ADD CONSTRAINT "level_progress_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "level_progress" ADD CONSTRAINT "level_progress_levelId_fkey" FOREIGN KEY ("levelId") REFERENCES "levels"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_quest_progress" ADD CONSTRAINT "player_quest_progress_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_quest_progress" ADD CONSTRAINT "player_quest_progress_questId_fkey" FOREIGN KEY ("questId") REFERENCES "quests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "quest_rewards" ADD CONSTRAINT "quest_rewards_questId_fkey" FOREIGN KEY ("questId") REFERENCES "quests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "quest_rewards" ADD CONSTRAINT "quest_rewards_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shop_items" ADD CONSTRAINT "shop_items_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shop_items" ADD CONSTRAINT "shop_items_priceCurrency_fkey" FOREIGN KEY ("priceCurrency") REFERENCES "currencies"("code") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "players"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_currencyId_fkey" FOREIGN KEY ("currencyId") REFERENCES "currencies"("id") ON DELETE SET NULL ON UPDATE CASCADE;
