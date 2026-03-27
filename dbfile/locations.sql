-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Мар 20 2026 г., 12:05
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
-- Структура таблицы `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `location_id` varchar(255) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `location_img` varchar(255) DEFAULT NULL,
  `status` enum('old','new') NOT NULL DEFAULT 'new',
  `last_update` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `locations`
--

INSERT INTO `locations` (`id`, `location_id`, `location_name`, `location_img`, `status`, `last_update`) VALUES
(1, '70000001033310378', 'Facility Management Group ', 'https://i6.photo.2gis.com/images/branch/0/30258560058360086_fe1c.jpg', 'old', '2026-03-20 11:00:05');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
