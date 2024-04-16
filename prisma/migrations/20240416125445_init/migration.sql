/*
  Warnings:

  - Made the column `idCurrentClient` on table `Orders` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `Orders` DROP FOREIGN KEY `Orders_idCurrentClient_fkey`;

-- AlterTable
ALTER TABLE `Food` MODIFY `idCategory` INTEGER NULL;

-- AlterTable
ALTER TABLE `Orders` MODIFY `idCurrentClient` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Orders` ADD CONSTRAINT `Orders_idCurrentClient_fkey` FOREIGN KEY (`idCurrentClient`) REFERENCES `CurrentClient`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
