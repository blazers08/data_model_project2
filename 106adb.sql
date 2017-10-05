-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- 主機: localhost
-- 產生時間： 2017 年 10 月 05 日 15:19
-- 伺服器版本: 5.7.19-0ubuntu0.16.04.1
-- PHP 版本： 7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
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
-- 資料表結構 `field`
--

CREATE TABLE `field` (
  `id` int(11) NOT NULL COMMENT '唯一碼',
  `name` varchar(256) NOT NULL COMMENT '名稱',
  `address` varchar(256) NOT NULL COMMENT '地址',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='場地';

--
-- 資料表的匯出資料 `field`
--

INSERT INTO `field` (`id`, `name`, `address`, `created`, `modified`, `status`) VALUES
(1, '天母棒球場', '忠誠路', '2017-09-29 12:57:54', '2017-09-29 12:57:54', 1),
(2, '台大體育管', '羅斯福路', '2017-09-29 12:57:54', '2017-09-29 12:57:54', 1),
(3, '政大', '指南路', '2017-09-29 14:42:45', '2017-09-29 14:42:45', 1);

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
-- 資料表索引 `field`
--
ALTER TABLE `field`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一碼', AUTO_INCREMENT=5;
--
-- 使用資料表 AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
