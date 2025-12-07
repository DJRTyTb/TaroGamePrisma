/*
  Warnings:

  - You are about to drop the `game_config` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `level_progress` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `levels` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `player_cards` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `player_quest_progress` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `player_shapes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `players` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `quests` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `shapes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tarot_cards` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transactions` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "level_progress" DROP CONSTRAINT "level_progress_levelId_fkey";

-- DropForeignKey
ALTER TABLE "level_progress" DROP CONSTRAINT "level_progress_playerId_fkey";

-- DropForeignKey
ALTER TABLE "player_cards" DROP CONSTRAINT "player_cards_cardId_fkey";

-- DropForeignKey
ALTER TABLE "player_cards" DROP CONSTRAINT "player_cards_playerId_fkey";

-- DropForeignKey
ALTER TABLE "player_quest_progress" DROP CONSTRAINT "player_quest_progress_playerId_fkey";

-- DropForeignKey
ALTER TABLE "player_quest_progress" DROP CONSTRAINT "player_quest_progress_questId_fkey";

-- DropForeignKey
ALTER TABLE "player_shapes" DROP CONSTRAINT "player_shapes_playerId_fkey";

-- DropForeignKey
ALTER TABLE "player_shapes" DROP CONSTRAINT "player_shapes_shapeId_fkey";

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_playerId_fkey";

-- DropTable
DROP TABLE "game_config";

-- DropTable
DROP TABLE "level_progress";

-- DropTable
DROP TABLE "levels";

-- DropTable
DROP TABLE "player_cards";

-- DropTable
DROP TABLE "player_quest_progress";

-- DropTable
DROP TABLE "player_shapes";

-- DropTable
DROP TABLE "players";

-- DropTable
DROP TABLE "quests";

-- DropTable
DROP TABLE "shapes";

-- DropTable
DROP TABLE "tarot_cards";

-- DropTable
DROP TABLE "transactions";

-- CreateTable
CREATE TABLE "Player" (
    "id" TEXT NOT NULL,
    "telegramId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastDailyLevelDate" TIMESTAMP(3),
    "streak" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Player_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Shape" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "complexityLevel" INTEGER NOT NULL,
    "spriteUrl" TEXT,
    "unlockCondition" JSONB,

    CONSTRAINT "Shape_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerShape" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "shapeId" TEXT NOT NULL,
    "obtainedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PlayerShape_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TarotCard" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "rarity" INTEGER NOT NULL,
    "descriptionTemplate" TEXT,
    "imageBaseUrl" TEXT NOT NULL,
    "isSpecial" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "TarotCard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerCard" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "cardId" TEXT NOT NULL,
    "rank" INTEGER NOT NULL,
    "obtainedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PlayerCard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Level" (
    "id" TEXT NOT NULL,
    "date" TIMESTAMP(3),
    "data" JSONB NOT NULL,
    "patternsAvailable" JSONB,

    CONSTRAINT "Level_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LevelProgress" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "levelId" TEXT NOT NULL,
    "starsEarned" INTEGER NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LevelProgress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Quest" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "conditionJson" JSONB NOT NULL,
    "rewardJson" JSONB NOT NULL,

    CONSTRAINT "Quest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerQuestProgress" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "questId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "progressData" JSONB,

    CONSTRAINT "PlayerQuestProgress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transaction" (
    "id" TEXT NOT NULL,
    "playerId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Transaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GameConfig" (
    "id" TEXT NOT NULL DEFAULT 'main',
    "data" JSONB NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GameConfig_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Player_telegramId_key" ON "Player"("telegramId");

-- AddForeignKey
ALTER TABLE "PlayerShape" ADD CONSTRAINT "PlayerShape_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerShape" ADD CONSTRAINT "PlayerShape_shapeId_fkey" FOREIGN KEY ("shapeId") REFERENCES "Shape"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerCard" ADD CONSTRAINT "PlayerCard_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerCard" ADD CONSTRAINT "PlayerCard_cardId_fkey" FOREIGN KEY ("cardId") REFERENCES "TarotCard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LevelProgress" ADD CONSTRAINT "LevelProgress_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LevelProgress" ADD CONSTRAINT "LevelProgress_levelId_fkey" FOREIGN KEY ("levelId") REFERENCES "Level"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerQuestProgress" ADD CONSTRAINT "PlayerQuestProgress_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerQuestProgress" ADD CONSTRAINT "PlayerQuestProgress_questId_fkey" FOREIGN KEY ("questId") REFERENCES "Quest"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Transaction" ADD CONSTRAINT "Transaction_playerId_fkey" FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;
