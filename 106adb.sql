-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- 主機: localhost:3306
-- 產生時間： 2017 年 11 月 18 日 18:22
-- 伺服器版本: 5.6.35
-- PHP 版本： 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `106adb`
--

-- --------------------------------------------------------

--
-- 資料表結構 `ball`
--

CREATE TABLE `ball` (
  `play_id` int(11) NOT NULL,
  `ball_order` int(2) NOT NULL,
  `kind` enum('4FB','2FB','CUT','SLD','SNK','CHG','SPL','CRV','KNU','KCV','SLV','PLM','CCH','FRK','SCR') NOT NULL,
  `speed` int(2) NOT NULL,
  `result` enum('S','B','f_ball','1h','2h','3h','HR','K','out','BB','HBP') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `ball`
--

INSERT INTO `ball` (`play_id`, `ball_order`, `kind`, `speed`, `result`) VALUES
(1, 1, '4FB', 94, 'f_ball'),
(1, 2, 'CRV', 74, 'S'),
(1, 3, '4FB', 91, 'f_ball'),
(1, 4, 'SLD', 90, 'K'),
(2, 1, '4FB', 94, 'B'),
(2, 2, '4FB', 94, 'B'),
(2, 3, '4FB', 95, 'out'),
(3, 1, '4FB', 91, 'S'),
(3, 2, 'CRV', 75, 'out'),
(4, 1, '4FB', 88, 'HR'),
(5, 1, '2FB', 90, 'S'),
(5, 2, '4FB', 88, 'S'),
(5, 3, 'SLD', 80, 'B'),
(5, 4, '4FB', 88, 'f_ball'),
(5, 5, '4FB', 92, 'B'),
(5, 6, '2FB', 91, 'f_ball'),
(5, 7, 'CUT', 88, 'K'),
(6, 1, '2FB', 91, 'B'),
(6, 2, 'SLD', 80, 'S'),
(6, 3, '2FB', 90, 'out'),
(7, 1, '2FB', 90, 'B'),
(7, 2, '2FB', 90, 'B'),
(7, 3, '2FB', 90, 'out'),
(8, 1, '4FB', 93, 'out'),
(9, 1, '4FB', 93, 'S'),
(9, 2, '4FB', 93, 'S'),
(9, 3, 'SLD', 90, 'B'),
(9, 4, 'SLD', 90, 'f_ball'),
(9, 5, 'SLD', 89, 'B'),
(9, 6, '4FB', 94, 'K'),
(10, 1, 'SLD', 88, 'S'),
(10, 2, '4FB', 93, 'S'),
(10, 3, 'SLD', 89, 'out'),
(11, 1, '2FB', 88, 'B'),
(11, 2, '2FB', 88, 'S'),
(11, 3, 'SLD', 77, '1h'),
(12, 1, '2FB', 90, 'out'),
(13, 1, '2FB', 89, 'S'),
(13, 2, 'SLD', 79, 'B'),
(13, 3, '2FB', 90, 'f_ball'),
(13, 4, '2FB', 88, 'out'),
(14, 1, '4FB', 93, 'S'),
(14, 2, 'SLD', 89, 'f_ball'),
(14, 3, '4FB', 93, 'B'),
(14, 4, 'SLD', 90, 'B'),
(14, 5, 'CRV', 75, 'K'),
(15, 1, '4FB', 94, 'B'),
(15, 2, '4FB', 93, 'S'),
(15, 3, 'CRV', 73, '1h'),
(16, 1, '4FB', 93, 'S'),
(16, 2, '4FB', 93, 'f_ball'),
(16, 3, '4FB', 93, 'B'),
(16, 4, '4FB', 93, 'B'),
(16, 5, '4FB', 93, 'K'),
(17, 1, 'SLD', 90, 'S'),
(17, 2, '4FB', 93, 'S'),
(17, 3, 'SLD', 90, 'K'),
(18, 1, '2FB', 90, 'S'),
(18, 2, '2FB', 90, 'B'),
(18, 3, '2FB', 90, '1h'),
(19, 1, '2FB', 90, 'B'),
(19, 2, '2FB', 89, 'f_ball'),
(19, 3, 'CHG', 80, 'out'),
(20, 1, 'CUT', 87, 'S'),
(20, 2, 'CUT', 87, 'B'),
(20, 3, 'CHG', 80, 'out'),
(21, 1, 'SLD', 90, 'S'),
(21, 2, '4FB', 93, 'B'),
(21, 3, '4FB', 93, 'HR'),
(22, 1, 'SLD', 88, 'S'),
(22, 2, '4FB', 91, 'B'),
(22, 3, 'CRV', 75, 'B'),
(22, 4, 'SLD', 90, 'B'),
(22, 5, 'SLD', 90, 'f_ball'),
(22, 6, 'SLD', 90, 'K'),
(23, 1, 'CRV', 74, 'S'),
(23, 2, 'SLD', 89, 'S'),
(23, 3, 'CRV', 74, 'K'),
(24, 1, '4FB', 94, 'B'),
(24, 2, 'SLD', 89, 'f_ball'),
(24, 3, '4FB', 92, 'f_ball'),
(24, 4, 'SLD', 88, 'K'),
(25, 1, 'CUT', 85, 'S'),
(25, 2, 'SLD', 78, 'B'),
(25, 3, 'CUT', 87, 'out'),
(26, 1, '2FB', 90, 'B'),
(26, 2, '2FB', 90, 'S'),
(26, 3, 'SLD', 82, 'B'),
(26, 4, '2FB', 90, 'f_ball'),
(26, 5, 'SLD', 82, 'out'),
(27, 1, 'CUT', 87, 'B'),
(27, 2, '2FB', 89, 'B'),
(27, 3, 'CUT', 86, 'B'),
(27, 4, '2FB', 88, 'S'),
(27, 5, 'CHG', 80, 'out'),
(28, 1, 'SLD', 88, 'B'),
(28, 2, '4FB', 92, 'out'),
(29, 1, 'SLD', 88, 'out'),
(30, 1, '4FB', 93, 'S'),
(30, 2, '4FB', 92, 'S'),
(30, 3, '4FB', 94, 'K'),
(31, 1, '2FB', 89, 'S'),
(31, 2, '2FB', 89, 'S'),
(31, 3, 'SLD', 82, 'B'),
(31, 4, 'CHG', 82, 'K'),
(32, 1, '2FB', 90, '1h'),
(33, 1, '2FB', 89, 'B'),
(33, 2, '2FB', 89, 'S'),
(33, 3, 'SLD', 79, 'B'),
(33, 4, '4FB', 87, 'S'),
(33, 5, '4FB', 87, 'out'),
(34, 1, '4FB', 92, 'B'),
(34, 2, '4FB', 92, 'S'),
(34, 3, '4FB', 92, 'S'),
(34, 4, 'CRV', 74, 'B'),
(34, 5, '4FB', 93, 'K'),
(35, 1, 'SLD', 90, 'B'),
(35, 2, 'SLD', 88, 'B'),
(35, 3, 'SLD', 88, 'S'),
(35, 4, '4FB', 93, 'S'),
(35, 5, 'SLD', 89, 'f_ball'),
(35, 6, 'CRV', 74, 'B'),
(35, 7, 'SLD', 90, 'K'),
(36, 1, '4FB', 93, 'S'),
(36, 2, 'CRV', 74, 'B'),
(36, 3, 'CRV', 74, 'B'),
(36, 4, 'SLD', 89, 'out'),
(37, 1, '2FB', 89, 'out'),
(38, 1, '2FB', 90, 'B'),
(38, 2, '2FB', 90, 'B'),
(38, 3, '2FB', 88, 'S'),
(38, 4, '2FB', 89, 'out'),
(39, 1, 'SLD', 77, 'B'),
(39, 2, '4FB', 88, 'B'),
(39, 3, 'CUT', 87, 'f_ball'),
(39, 4, 'CHG', 80, 'B'),
(39, 5, '2FB', 89, 'BB'),
(40, 1, 'CUT', 87, 'B'),
(40, 2, 'CUT', 87, 'S'),
(40, 3, '2FB', 90, 'S'),
(40, 4, 'CUT', 87, 'HR'),
(41, 1, 'SLD', 81, 'S'),
(41, 2, '2FB', 90, 'B'),
(41, 3, '2FB', 90, 'S'),
(41, 4, 'SLD', 82, 'K'),
(42, 1, 'SLD', 89, 'f_ball'),
(42, 2, 'SLD', 88, 'B'),
(42, 3, 'CRV', 73, 'B'),
(42, 4, 'SLD', 87, '1h'),
(43, 1, 'SLD', 89, 'out'),
(44, 1, '4FB', 92, 'out'),
(45, 1, 'SLD', 88, 'B'),
(45, 2, 'SLD', 88, 'f_ball'),
(45, 3, '4FB', 93, 'B'),
(45, 4, '4FB', 93, 'out'),
(46, 1, '2FB', 88, 'B'),
(46, 2, 'CUT', 86, 'B'),
(46, 3, '2FB', 88, 'S'),
(46, 4, 'CUT', 86, 'S'),
(46, 5, 'CUT', 86, 'out'),
(47, 1, '2FB', 90, 'B'),
(47, 2, 'SLD', 78, 'S'),
(47, 3, '2FB', 90, 'B'),
(47, 4, 'SLD', 80, 'S'),
(47, 5, '2FB', 91, 'out'),
(48, 1, 'SLD', 81, 'B'),
(48, 2, 'SLD', 80, '1h'),
(49, 1, '4FB', 92, 'B'),
(49, 2, '4FB', 93, 'S'),
(49, 3, 'SLD', 84, 'B'),
(49, 4, 'SLD', 85, 'B'),
(49, 5, '4FB', 94, 'BB'),
(50, 1, '4FB', 94, 'S'),
(50, 2, 'CHG', 81, 'S'),
(50, 3, 'SLD', 84, 'B'),
(50, 4, '4FB', 94, 'B'),
(50, 5, 'SLD', 84, 'B'),
(50, 6, 'CHG', 80, 'out'),
(51, 1, 'CUT', 92, 'f_ball'),
(51, 2, 'CUT', 92, 'out'),
(52, 1, '4FB', 98, 'S'),
(52, 2, '4FB', 98, 'f_ball'),
(52, 3, '4FB', 99, 'f_ball'),
(52, 4, 'SLD', 88, 'B'),
(52, 5, '4FB', 100, 'B'),
(52, 6, '4FB', 98, 'out'),
(53, 1, 'CUT', 93, 'B'),
(53, 2, '4FB', 98, 'out'),
(54, 1, '4FB', 94, 'f_ball'),
(54, 2, '4FB', 94, 'f_ball'),
(54, 3, 'CHG', 83, 'B'),
(54, 4, 'SLD', 80, 'K'),
(55, 1, '4FB', 96, 'out'),
(56, 1, 'SLD', 78, 'S'),
(56, 2, '4FB', 95, 'B'),
(56, 3, 'SLD', 79, 'S'),
(56, 4, 'CHG', 82, 'K'),
(57, 1, 'CUT', 93, 'S'),
(57, 2, 'CUT', 94, 'S'),
(57, 3, 'CUT', 96, 'B'),
(57, 4, 'CUT', 94, 'B'),
(57, 5, 'CUT', 93, 'S'),
(58, 1, 'CUT', 92, 'B'),
(58, 2, 'CUT', 90, 'B'),
(58, 3, 'CUT', 91, 'f_ball'),
(58, 4, 'CUT', 90, 'S'),
(58, 5, 'CUT', 90, 'f_ball'),
(58, 6, 'CUT', 91, 'B'),
(58, 7, 'CUT', 92, 'f_ball'),
(58, 8, 'CUT', 92, 'out'),
(59, 1, 'CUT', 93, 'out');

-- --------------------------------------------------------

--
-- 資料表結構 `field`
--

CREATE TABLE `field` (
  `field_id` int(11) NOT NULL COMMENT '唯一碼',
  `name` varchar(256) NOT NULL COMMENT '名稱',
  `address` varchar(256) NOT NULL COMMENT '地址',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='場地';

--
-- 資料表的匯出資料 `field`
--

INSERT INTO `field` (`field_id`, `name`, `address`, `created`, `modified`, `status`) VALUES
(1, '天母棒球場', '忠誠路', '2017-09-29 12:57:54', '2017-11-14 16:17:43', 1),
(3, '政大', '指南路', '2017-09-29 14:42:45', '2017-09-29 14:42:45', 1),
(4, '桃園', '中壢', '2017-11-11 19:51:48', '2017-11-11 19:51:48', 1),
(5, '新莊', '新北市新莊區', '2017-11-11 19:53:00', '2017-11-11 20:00:48', 1),
(6, '洲際', '台中', '2017-11-11 20:00:22', '2017-11-11 20:00:22', 1),
(7, '澄清湖', '高雄市ＸＸ區', '2017-11-11 20:04:58', '2017-11-11 20:05:10', 1),
(8, 'Dodger Stadium', '1000 Vin Scully Ave, Los Angeles, CA, USA', '2017-11-11 23:19:59', '2017-11-11 23:19:59', 1),
(9, 'Minute Maid Park', '501 Crawford ST, Huston, TX, USA', '2017-11-12 22:45:57', '2017-11-12 22:45:57', 1);

-- --------------------------------------------------------

--
-- 資料表結構 `match`
--

CREATE TABLE `match` (
  `match_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `m_hometeam` int(11) NOT NULL,
  `m_awayteam` int(11) NOT NULL,
  `m_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `match`
--

INSERT INTO `match` (`match_id`, `field_id`, `m_hometeam`, `m_awayteam`, `m_date`) VALUES
(1, 8, 1, 2, '2017-10-24'),
(2, 8, 1, 2, '2017-10-25'),
(3, 9, 2, 1, '2017-10-27');

-- --------------------------------------------------------

--
-- 資料表結構 `play`
--

CREATE TABLE `play` (
  `play_id` int(11) NOT NULL,
  `pitcher_id` int(11) NOT NULL,
  `batter_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `inning` int(11) NOT NULL,
  `half` enum('TOP','BOT') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `play`
--

INSERT INTO `play` (`play_id`, `pitcher_id`, `batter_id`, `match_id`, `inning`, `half`) VALUES
(1, 21, 1, 1, 1, 'TOP'),
(2, 21, 2, 1, 1, 'TOP'),
(3, 21, 3, 1, 1, 'TOP'),
(4, 9, 13, 1, 1, 'BOT'),
(5, 9, 14, 1, 1, 'BOT'),
(6, 9, 15, 1, 1, 'BOT'),
(7, 9, 16, 1, 1, 'BOT'),
(8, 21, 4, 1, 2, 'TOP'),
(9, 21, 5, 1, 2, 'TOP'),
(10, 21, 6, 1, 2, 'TOP'),
(11, 9, 17, 1, 2, 'BOT'),
(12, 9, 18, 1, 2, 'BOT'),
(13, 9, 19, 1, 2, 'BOT'),
(14, 21, 7, 1, 3, 'TOP'),
(15, 21, 8, 1, 3, 'TOP'),
(16, 21, 9, 1, 3, 'TOP'),
(17, 21, 1, 1, 3, 'TOP'),
(18, 9, 20, 1, 3, 'BOT'),
(19, 9, 21, 1, 3, 'BOT'),
(20, 9, 13, 1, 3, 'BOT'),
(21, 21, 2, 1, 4, 'TOP'),
(22, 21, 3, 1, 4, 'TOP'),
(23, 21, 4, 1, 4, 'TOP'),
(24, 21, 5, 1, 4, 'TOP'),
(25, 9, 14, 1, 4, 'BOT'),
(26, 9, 15, 1, 4, 'BOT'),
(27, 9, 16, 1, 4, 'BOT'),
(28, 21, 6, 1, 5, 'TOP'),
(29, 21, 7, 1, 5, 'TOP'),
(30, 21, 8, 1, 5, 'TOP'),
(31, 9, 17, 1, 5, 'BOT'),
(32, 9, 18, 1, 5, 'BOT'),
(33, 9, 19, 1, 5, 'BOT'),
(34, 21, 9, 1, 6, 'TOP'),
(35, 21, 1, 1, 6, 'TOP'),
(36, 21, 2, 1, 6, 'TOP'),
(37, 9, 20, 1, 6, 'BOT'),
(38, 9, 21, 1, 6, 'BOT'),
(39, 9, 13, 1, 6, 'BOT'),
(40, 9, 14, 1, 6, 'BOT'),
(41, 9, 15, 1, 6, 'BOT'),
(42, 21, 3, 1, 7, 'TOP'),
(43, 21, 4, 1, 7, 'TOP'),
(44, 21, 5, 1, 7, 'TOP'),
(45, 21, 6, 1, 7, 'TOP'),
(46, 9, 16, 1, 7, 'BOT'),
(47, 9, 17, 1, 7, 'BOT'),
(48, 9, 18, 1, 7, 'BOT'),
(49, 10, 19, 1, 7, 'BOT'),
(50, 10, 20, 1, 7, 'BOT'),
(51, 22, 7, 1, 8, 'TOP'),
(52, 22, 8, 1, 8, 'TOP'),
(53, 22, 11, 1, 8, 'TOP'),
(54, 12, 22, 1, 8, 'BOT'),
(55, 12, 13, 1, 8, 'BOT'),
(56, 12, 14, 1, 8, 'BOT'),
(57, 24, 1, 1, 9, 'TOP'),
(58, 24, 2, 1, 9, 'TOP'),
(59, 24, 3, 1, 9, 'TOP');

-- --------------------------------------------------------

--
-- 資料表結構 `player`
--

CREATE TABLE `player` (
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `player_number` int(11) NOT NULL,
  `player_salary` int(11) NOT NULL,
  `player_position` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `player`
--

INSERT INTO `player` (`player_id`, `player_name`, `player_number`, `player_salary`, `player_position`) VALUES
(1, 'George Springer', 4, 10, 'CF'),
(2, 'Alex Bregman', 2, 10, '3B'),
(3, 'José Altuve', 27, 10, '2B'),
(4, 'Carlos Correa', 1, 10, 'SS'),
(5, 'Yuli Gurriel', 10, 10, '1B'),
(6, 'Brian McCann', 16, 10, 'C'),
(7, 'Marwin Gonzalez', 9, 10, 'LF'),
(8, 'Josh Reddick', 22, 10, 'RF'),
(9, 'Dallas Keuchel', 60, 10, 'P'),
(10, 'Brad Peacock', 41, 10, 'P'),
(11, 'Carlos Beltrán', 15, 10, 'DH'),
(12, 'Chris Devenski', 47, 10, 'P'),
(13, 'Chris Taylor', 3, 10, 'LF'),
(14, 'Justin Turner', 10, 10, '3B'),
(15, 'Cody Bellinger', 35, 10, '1B'),
(16, 'Yasiel Puig', 66, 10, 'RF'),
(17, 'Enrique Hernández', 14, 10, 'CF'),
(18, 'Corey Seager', 5, 10, 'SS'),
(19, 'Logan Forsythe', 11, 10, '2B'),
(20, 'Austin Barnes', 15, 10, 'C'),
(21, 'Clayton Kershaw', 22, 10, 'P'),
(22, 'Brandon Morrow', 17, 10, 'P'),
(23, 'Charlie Culberson', 37, 10, 'SS'),
(24, 'Kenley Jansen', 74, 10, 'P');

-- --------------------------------------------------------

--
-- 資料表結構 `team`
--

CREATE TABLE `team` (
  `team_id` int(11) NOT NULL,
  `team_name` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `team`
--

INSERT INTO `team` (`team_id`, `team_name`, `status`) VALUES
(1, '洛杉磯道奇', 1),
(2, '休士頓太空人', 1),
(3, '紐約洋基', 0),
(4, '華盛頓國民', 1),
(5, '底特律老虎', 1),
(6, '巴爾地摩金鶯', 1),
(7, '辛辛那提紅人', 1),
(8, '聖路易紅雀', 1),
(9, '亞利桑那響尾蛇', 1),
(10, '芝加哥小熊', 1),
(11, '芝加哥白襪', 1),
(12, '波士頓紅襪', 1),
(13, '克里夫蘭印地安人', 1);

-- --------------------------------------------------------

--
-- 資料表結構 `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(128) NOT NULL COMMENT '登入用的email',
  `name` varchar(128) NOT NULL,
  `password` char(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `user`
--

INSERT INTO `user` (`id`, `email`, `name`, `password`) VALUES
(1, '106356008@nccu.edu.tw', '王振軒', 'a642a77abd7d4f51bf9226ceaf891fcbb5b299b8');

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `ball`
--
ALTER TABLE `ball`
  ADD PRIMARY KEY (`play_id`,`ball_order`),
  ADD KEY `play_id` (`play_id`);

--
-- 資料表索引 `field`
--
ALTER TABLE `field`
  ADD PRIMARY KEY (`field_id`);

--
-- 資料表索引 `match`
--
ALTER TABLE `match`
  ADD PRIMARY KEY (`match_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `m_hometeam` (`m_hometeam`),
  ADD KEY `m_awayteam` (`m_awayteam`),
  ADD KEY `field_id_2` (`field_id`);

--
-- 資料表索引 `play`
--
ALTER TABLE `play`
  ADD PRIMARY KEY (`play_id`),
  ADD KEY `match_id` (`match_id`),
  ADD KEY `batter_id` (`batter_id`),
  ADD KEY `pitcher_id` (`pitcher_id`) USING BTREE;

--
-- 資料表索引 `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`player_id`);

--
-- 資料表索引 `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`team_id`);

--
-- 資料表索引 `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `field`
--
ALTER TABLE `field`
  MODIFY `field_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一碼', AUTO_INCREMENT=10;
--
-- 使用資料表 AUTO_INCREMENT `match`
--
ALTER TABLE `match`
  MODIFY `match_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用資料表 AUTO_INCREMENT `play`
--
ALTER TABLE `play`
  MODIFY `play_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;
--
-- 使用資料表 AUTO_INCREMENT `player`
--
ALTER TABLE `player`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- 使用資料表 AUTO_INCREMENT `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- 使用資料表 AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 已匯出資料表的限制(Constraint)
--

--
-- 資料表的 Constraints `ball`
--
ALTER TABLE `ball`
  ADD CONSTRAINT `ball_ibfk_1` FOREIGN KEY (`play_id`) REFERENCES `play` (`play_id`);

--
-- 資料表的 Constraints `match`
--
ALTER TABLE `match`
  ADD CONSTRAINT `match_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `match_ibfk_2` FOREIGN KEY (`m_hometeam`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `match_ibfk_3` FOREIGN KEY (`m_awayteam`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 資料表的 Constraints `play`
--
ALTER TABLE `play`
  ADD CONSTRAINT `play_ibfk_2` FOREIGN KEY (`pitcher_id`) REFERENCES `player` (`player_id`),
  ADD CONSTRAINT `play_ibfk_3` FOREIGN KEY (`batter_id`) REFERENCES `player` (`player_id`),
  ADD CONSTRAINT `play_ibfk_4` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
