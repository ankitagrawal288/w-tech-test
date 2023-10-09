-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2023 at 11:21 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `w_tech`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` enum('0','1') DEFAULT '1',
  `added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `status`, `added_at`, `updated_at`) VALUES
(1, 'SAMSUNG Galaxy Z Flip5 (Graphite, 256 GB)  (8 GB RAM)', '1', '2023-10-08 13:24:45', '2023-10-08 13:24:45'),
(2, 'SAMSUNG Galaxy (Graphite, 256 GB)  (8 GB RAM)', '1', '2023-10-08 13:24:45', '2023-10-08 13:24:45'),
(3, 'SAMSUNG', '1', '2023-10-08 16:08:31', '2023-10-08 16:08:31'),
(4, 'SAMSUNG1', '1', '2023-10-08 16:10:48', '2023-10-08 16:10:48'),
(5, 'SAMSUNG12', '1', '2023-10-09 04:35:18', '2023-10-09 04:35:18'),
(6, 'SAMSUNG122', '1', '2023-10-09 04:41:03', '2023-10-09 04:41:03'),
(7, 'SAMSUNG1212', '1', '2023-10-09 04:41:05', '2023-10-09 04:41:05'),
(8, 'SAMSUdNG122', '1', '2023-10-09 04:41:10', '2023-10-09 04:41:10'),
(9, 'SAMSUdNG1f22', '1', '2023-10-09 04:41:12', '2023-10-09 04:41:12'),
(10, 'SAMSUdeNG1f22', '1', '2023-10-09 04:41:15', '2023-10-09 04:41:15'),
(11, 'SAMSUdeNGw1f22', '1', '2023-10-09 04:41:17', '2023-10-09 04:41:17'),
(12, 'SAMS', '1', '2023-10-09 04:41:21', '2023-10-09 04:41:21'),
(13, 'SAMS1', '1', '2023-10-09 04:41:24', '2023-10-09 04:41:24'),
(14, 'SAMS12', '1', '2023-10-09 04:41:26', '2023-10-09 04:41:26'),
(15, 'SAMS132', '0', '2023-10-09 04:41:29', '2023-10-09 04:41:29'),
(16, 'SAMSUNG1s', '1', '2023-10-09 09:20:14', '2023-10-09 09:20:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_role` enum('1','2') NOT NULL DEFAULT '2' COMMENT '1: admin, 2: user',
  `first_name` varchar(500) NOT NULL,
  `last_name` varchar(500) DEFAULT NULL,
  `email` varchar(500) NOT NULL,
  `password` varchar(500) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_role`, `first_name`, `last_name`, `email`, `password`, `status`, `date_added`, `date_updated`) VALUES
(1, '1', 'admin', 'test', 'admin@test.com', 'e10adc3949ba59abbe56e057f20f883e', '1', '2023-05-07 09:12:25', '2023-05-07 09:12:25');

-- --------------------------------------------------------

--
-- Table structure for table `user_token`
--

CREATE TABLE `user_token` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `added_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expired_on` datetime NOT NULL,
  `is_expired` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0:active, 1:expired'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_token`
--

INSERT INTO `user_token` (`id`, `user_id`, `token`, `added_at`, `expired_on`, `is_expired`) VALUES
(1, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJNeUFwcGxpY2F0aW9uTmFtZS5jb20iLCJhdWQiOiJNeUFwcGxpY2F0aW9uIE5hbWUiLCJpYXQiOjE2OTY4Mzc1MTQsIm5iZiI6MTY5NjgzNzUxNCwiZXhwIjoxNjk5NDI5NTE0LCJkYXRhIjoiMSJ9.3I0AYC-WVZ9ggEcF1xoPhl7-GfczaayGRyqoe8H8TmY', '2023-10-09 13:15:14', '2023-10-09 19:15:14', '1'),
(2, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJNeUFwcGxpY2F0aW9uTmFtZS5jb20iLCJhdWQiOiJNeUFwcGxpY2F0aW9uIE5hbWUiLCJpYXQiOjE2OTY4Mzc2MDUsIm5iZiI6MTY5NjgzNzYwNSwiZXhwIjoxNjk5NDI5NjA1LCJkYXRhIjoiMSJ9.CJpyAPl4cac3sFOjwKSbvkiMAX5aYRP2hirEjmaXSfU', '2023-10-09 13:16:45', '2023-10-09 19:16:45', '1'),
(3, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJNeUFwcGxpY2F0aW9uTmFtZS5jb20iLCJhdWQiOiJNeUFwcGxpY2F0aW9uIE5hbWUiLCJpYXQiOjE2OTY4Mzc2MTUsIm5iZiI6MTY5NjgzNzYxNSwiZXhwIjoxNjk5NDI5NjE1LCJkYXRhIjoiMSJ9.V_UtFBBqXXapu7pxeBFICBLTh8I5KUePzeYRYHd_9VY', '2023-10-09 13:16:55', '2023-10-09 19:16:55', '1'),
(4, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJNeUFwcGxpY2F0aW9uTmFtZS5jb20iLCJhdWQiOiJNeUFwcGxpY2F0aW9uIE5hbWUiLCJpYXQiOjE2OTY4Mzk5NjcsIm5iZiI6MTY5NjgzOTk2NywiZXhwIjoxNjk5NDMxOTY3LCJkYXRhIjoiMSJ9.Oz4Z4RkbUAwzRAHJ826iApY0e0VZO2oLPKpayoP5Hgo', '2023-10-09 13:56:07', '2023-10-09 19:56:07', '1'),
(5, 1, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJNeUFwcGxpY2F0aW9uTmFtZS5jb20iLCJhdWQiOiJNeUFwcGxpY2F0aW9uIE5hbWUiLCJpYXQiOjE2OTY4NDAyNDMsIm5iZiI6MTY5Njg0MDI0MywiZXhwIjoxNjk5NDMyMjQzLCJkYXRhIjoiMSJ9.OL-plCgOqm7_b1pq635m8CmEoBWq4EspPIwm1yG24Xk', '2023-10-09 14:00:43', '2023-10-09 20:00:43', '0'),
(6, 2, 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJNeUFwcGxpY2F0aW9uTmFtZS5jb20iLCJhdWQiOiJNeUFwcGxpY2F0aW9uIE5hbWUiLCJpYXQiOjE2OTY4NDAyNTEsIm5iZiI6MTY5Njg0MDI1MSwiZXhwIjoxNjk5NDMyMjUxLCJkYXRhIjoiMiJ9.eFE9zqZGvXnN1zfUdErQArVJBKqMFRiuKxrHSN_EheA', '2023-10-09 14:00:51', '2023-10-09 20:00:51', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_token`
--
ALTER TABLE `user_token`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_token`
--
ALTER TABLE `user_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
