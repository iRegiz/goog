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
-- Структура таблицы `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `profile_id` varchar(255) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `profile_link` varchar(255) NOT NULL,
  `profile_img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `authors`
--

INSERT INTO `authors` (`id`, `profile_id`, `author_name`, `profile_link`, `profile_img`) VALUES
(1, '18052671', 'Рая Жилиева', '', 'https://i4.photo.2gis.com/images/profile/844424968422821_050a.jpg');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `profile_id` (`profile_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1222;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
