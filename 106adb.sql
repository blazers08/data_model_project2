-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- 主機: localhost:3306
-- 產生時間： 2017 年 11 月 15 日 09:49
-- 伺服器版本: 5.6.35
-- PHP 版本： 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- 資料庫： `106adb`
--

-- --------------------------------------------------------

--
-- 資料表結構 `ball`
--

CREATE TABLE `ball` (
  `play_id` int(11) NOT NULL,
  `ball_order` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `half` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 資料表結構 `player`
--

CREATE TABLE `player` (
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `player_salary` int(11) NOT NULL,
  `player_position` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 資料表的匯出資料 `player`
--

INSERT INTO `player` (`player_id`, `player_name`, `player_salary`, `player_position`) VALUES
(1, 'Clayton Kershaw', 32000000, 'SP'),
(2, 'José Altuve', 505700, '2B'),
(3, 'Carlos Correa', 516700, 'SS');

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
(5, '底特律老虎', 1);

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
-- 使用資料表 AUTO_INCREMENT `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
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
  ADD CONSTRAINT `ball_ibfk_1` FOREIGN KEY (`play_id`) REFERENCES `play` (`play_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `fk1` FOREIGN KEY (`pitcher_id`) REFERENCES `player` (`player_id`),
  ADD CONSTRAINT `play_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `match` (`match_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `play_ibfk_2` FOREIGN KEY (`batter_id`) REFERENCES `player` (`player_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
