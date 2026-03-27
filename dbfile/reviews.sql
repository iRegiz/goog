-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Мар 20 2026 г., 12:06
-- Версия сервера: 10.6.7-MariaDB-1:10.6.7+maria~bionic
-- Версия PHP: 7.2.24-0ubuntu0.18.04.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `reviews_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `review_id` varchar(255) NOT NULL,
  `sys_location_id` int(11) NOT NULL,
  `sys_author_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `rating` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `review_date` datetime NOT NULL,
  `sys_add_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `review_id`, `sys_location_id`, `sys_author_id`, `content`, `rating`, `likes`, `review_date`, `sys_add_date`) VALUES
(1, '43505883', 9, 1, 'Хорошее расположение', 5, 0, '2023-01-09 13:38:41', '2023-04-18 12:12:35');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `review_id` (`review_id`),
  ADD KEY `sys_location_id` (`sys_location_id`,`sys_author_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14475;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
