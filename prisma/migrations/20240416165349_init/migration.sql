/*
  Warnings:

  - You are about to alter the column `total_price` on the `CurrentClient` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Double`.

*/
-- AlterTable
ALTER TABLE `CurrentClient` MODIFY `total_price` DOUBLE NOT NULL;
