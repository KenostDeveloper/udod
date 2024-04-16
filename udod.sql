-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 16 2024 г., 20:53
-- Версия сервера: 5.7.39
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `udod`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Category`
--

CREATE TABLE `Category` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `CurrentClient`
--

CREATE TABLE `CurrentClient` (
  `id` int(11) NOT NULL,
  `date` datetime(3) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tel` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `CurrentClient`
--

INSERT INTO `CurrentClient` (`id`, `date`, `name`, `address`, `tel`, `total_price`) VALUES
(4, '2024-04-16 17:04:51.081', 'Дмитрий', 'Буксирная 10', '79194456598', 2842.4),
(5, '2024-04-16 17:09:07.125', 'Дмитрий', 'Буксирная 10', '79194464596', 1640.65),
(6, '2024-04-16 17:09:33.923', 'Дмитрий', 'Буксирная 10', '79892307102', 3505.4),
(7, '2024-04-16 17:26:33.550', 'Дмитрий', 'Буксирная 10', '79892307102', 1811.65),
(8, '2024-04-16 17:30:05.971', 'Кузнецов', 'Буксирная 10', '79495689565', 2560.5),
(9, '2024-04-16 17:36:31.392', 'Дмитрий', 'Буксирная 10', '72937409234', 2219.4),
(10, '2024-04-16 17:37:38.851', 'Дмитрий', 'Буксирная 10', '75456446546', 2219.4),
(11, '2024-04-16 17:38:51.820', 'Дмитрий', 'Буксирная 10', '74544564564', 1640.65),
(12, '2024-04-16 17:43:48.513', 'Дмитрий', 'Буксирная 10', '75425456565', 1640.65),
(13, '2024-04-16 17:45:09.254', 'Дмитрий', 'Буксирная 10', '79131231231', 2596.75),
(14, '2024-04-16 17:48:10.017', 'Дмитрий', 'Буксирная 10', '72342342342', 2596.75);

-- --------------------------------------------------------

--
-- Структура таблицы `Food`
--

CREATE TABLE `Food` (
  `id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `idCategory` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `Food`
--

INSERT INTO `Food` (`id`, `name`, `price`, `idCategory`) VALUES
(1, 'Пицца \"Креветки со сладким чили\"', 589, NULL),
(2, 'Пицца \"Сырная\"', 559, NULL),
(3, 'Пицца \"Жюльен\"', 539, NULL),
(4, 'Пицца \"Карбонара\"', 629, NULL),
(5, 'Пицца \"Удод Микс\"', 739, NULL),
(6, 'Пицца \"Бургер-пицца\"', 619, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `Orders`
--

CREATE TABLE `Orders` (
  `id` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `idFood` int(11) NOT NULL,
  `idCurrentClient` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `Orders`
--

INSERT INTO `Orders` (`id`, `count`, `idFood`, `idCurrentClient`) VALUES
(10, 1, 2, 4),
(11, 4, 3, 4),
(12, 1, 4, 4),
(13, 1, 2, 5),
(14, 1, 3, 5),
(15, 1, 4, 5),
(16, 1, 3, 6),
(17, 1, 4, 6),
(18, 4, 5, 6),
(19, 1, 3, 7),
(20, 1, 4, 7),
(21, 1, 5, 7),
(22, 3, 2, 8),
(23, 1, 3, 8),
(24, 1, 4, 8),
(25, 1, 2, 9),
(26, 1, 3, 9),
(27, 1, 4, 9),
(28, 1, 5, 9),
(29, 1, 2, 10),
(30, 1, 3, 10),
(31, 1, 4, 10),
(32, 1, 5, 10),
(33, 1, 2, 11),
(34, 1, 3, 11),
(35, 1, 4, 11),
(36, 1, 2, 12),
(37, 1, 3, 12),
(38, 1, 4, 12),
(39, 1, 1, 13),
(40, 1, 2, 13),
(41, 1, 3, 13),
(42, 1, 4, 13),
(43, 1, 5, 13),
(44, 1, 1, 14),
(45, 1, 2, 14),
(46, 1, 3, 14),
(47, 1, 4, 14),
(48, 1, 5, 14);

-- --------------------------------------------------------

--
-- Структура таблицы `Promo`
--

CREATE TABLE `Promo` (
  `id` int(11) NOT NULL,
  `main_total_price` int(11) NOT NULL,
  `proccent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `Promo`
--

INSERT INTO `Promo` (`id`, `main_total_price`, `proccent`) VALUES
(1, 1000, 5),
(2, 2000, 10),
(3, 3000, 15);

-- --------------------------------------------------------

--
-- Структура таблицы `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('13a1c0cf-8418-4880-a6bf-7916dd58fa20', '61b1e2ba7c50cd6c0d381c454e54fd6d38fe14871215654bd62df16c2f15b789', '2024-04-16 10:35:16.452', '20240416103512_init', NULL, NULL, '2024-04-16 10:35:12.948', 1),
('64ae0852-2814-4db4-873e-47bee17be43c', '5e074239e6fb82524f640d9618139614138afc2ad6ac4fb3f26edafd1613768b', '2024-04-16 16:53:50.817', '20240416165349_init', NULL, NULL, '2024-04-16 16:53:49.570', 1),
('65cc5a16-8d4f-40f6-9f2d-1b3d0e2abf7a', '297f031b0fd1c1cc22032bd259154ce173b632d1d456dd6aa2ec4f629be4afc2', '2024-04-16 12:50:03.519', '20240416125002_init', NULL, NULL, '2024-04-16 12:50:02.617', 1),
('db48da9a-038f-4abb-97ad-e5e311de677a', '40d04429223a72cfe573f55583d877a72afaa010b9513d0d0d4f366f2108152c', '2024-04-16 12:54:47.570', '20240416125445_init', NULL, NULL, '2024-04-16 12:54:45.738', 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `CurrentClient`
--
ALTER TABLE `CurrentClient`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Food`
--
ALTER TABLE `Food`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Food_idCategory_fkey` (`idCategory`);

--
-- Индексы таблицы `Orders`
--
ALTER TABLE `Orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Orders_idFood_fkey` (`idFood`),
  ADD KEY `Orders_idCurrentClient_fkey` (`idCurrentClient`);

--
-- Индексы таблицы `Promo`
--
ALTER TABLE `Promo`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Category`
--
ALTER TABLE `Category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `CurrentClient`
--
ALTER TABLE `CurrentClient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `Food`
--
ALTER TABLE `Food`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `Orders`
--
ALTER TABLE `Orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT для таблицы `Promo`
--
ALTER TABLE `Promo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Food`
--
ALTER TABLE `Food`
  ADD CONSTRAINT `Food_idCategory_fkey` FOREIGN KEY (`idCategory`) REFERENCES `Category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Orders`
--
ALTER TABLE `Orders`
  ADD CONSTRAINT `Orders_idCurrentClient_fkey` FOREIGN KEY (`idCurrentClient`) REFERENCES `CurrentClient` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Orders_idFood_fkey` FOREIGN KEY (`idFood`) REFERENCES `Food` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
