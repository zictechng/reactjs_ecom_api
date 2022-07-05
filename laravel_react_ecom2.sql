-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2022 at 11:19 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_react_ecom2`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_qty` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `meta_tile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_descrip` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `meta_tile`, `meta_keyword`, `meta_descrip`, `slug`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Mobile', 'Samsung. mobile. description', 'Samsung mobile description', 'Mobile', 'Samsung', 'Samsung mobile description here', 0, '2022-06-25 19:22:31', '2022-06-26 19:37:05'),
(3, 'Samsung', 'Good, nice, great, Samsung A9', 'Good nice great Samsung A9', 'Samsung-mobile', 'Samsung A10', 'This is samsung A10 description here', 0, '2022-06-25 19:30:16', '2022-06-26 19:37:47'),
(5, 'System', 'system, laptop, computer', 'system, laptop, computer', 'Computer', 'Laptop 2009', NULL, 0, '2022-06-25 19:39:10', '2022-06-25 19:39:10'),
(7, 'Men fashion', 'Men fashion, key word tags', 'Fashion for men all way fron NYK', 'men-fashion', 'Men fashion', 'Fashion for men all way fron NYK', 0, '2022-06-26 18:33:21', '2022-06-26 18:33:21');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_06_25_113806_create_categories_table', 2),
(7, '2022_06_26_180523_create_products_table', 3),
(8, '2022_07_02_121632_create_carts_table', 4),
(9, '2022_07_03_112028_create_orders_table', 5),
(10, '2022_07_03_112707_create_orderitems_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`id`, `order_id`, `product_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(3, 3, 1, 3, 300, '2022-07-03 20:04:10', '2022-07-03 20:04:10'),
(4, 3, 2, 2, 455, '2022-07-03 20:04:10', '2022-07-03 20:04:10'),
(5, 4, 1, 2, 300, '2022-07-03 22:54:49', '2022-07-03 22:54:49'),
(6, 4, 2, 3, 455, '2022-07-03 22:54:49', '2022-07-03 22:54:49'),
(7, 5, 1, 1, 300, '2022-07-03 23:00:25', '2022-07-03 23:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipcode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_mode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tracking_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `remark` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `firstname`, `lastname`, `phone`, `email`, `address`, `city`, `state`, `zipcode`, `payment_id`, `payment_mode`, `tracking_no`, `status`, `remark`, `created_at`, `updated_at`) VALUES
(3, 3, 'Young', 'King', '909898878787', 'ben22@gmail.com', 'dbefbefre', 'UK', 'NG', '432343', NULL, 'COD', 'PID725276', 0, NULL, '2022-07-03 20:04:10', '2022-07-03 20:04:10'),
(4, 3, 'Young', 'King', '909898878787', 'done@gmail.com', 'rtjrstjtfyjtykyu', 'UK', 'NG', '5866566', NULL, 'Paid by Paypal', 'PID234717', 0, NULL, '2022-07-03 22:54:48', '2022-07-03 22:54:48'),
(5, 3, 'Young', 'King', '909898878787', 'eee@gmail.com', 'efvererfaer', 'UK', 'NG', '443322', '3RB04550FX104031C', 'Paid by Paypal', 'PID480488', 0, NULL, '2022-07-03 23:00:24', '2022-07-03 23:00:24');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(33, 'App\\Models\\User', 1, 'admin@gmail.com_AdminToken', 'de8bca295a0a21ee6c4359fe36124fea164dd2da4da99e34559a71bd216fb32c', '[\"server:admin\"]', '2022-07-04 00:35:25', '2022-07-03 23:55:56', '2022-07-04 00:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) NOT NULL,
  `meta_tile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_descrip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `selling_price` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_price` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` tinyint(4) DEFAULT 0,
  `popular` tinyint(4) DEFAULT 0,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `meta_tile`, `meta_keyword`, `meta_descrip`, `slug`, `name`, `description`, `brand`, `selling_price`, `original_price`, `qty`, `image`, `featured`, `popular`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Red Mi', 'this is the description of red Mi note 7', 'this is the description of red Mi note 7', 'red-mi', 'Red Mi Note 7', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam hendrerit commodo sodales. Maecenas in tempus magna. Fusce imperdiet tellus nisi, sed consectetur dolor rutrum eget. Suspendisse vitae felis quis justo sagittis imperdiet. Nam congue quam id congue placerat. Quisque suscipit aliquam ex, nec accumsan libero lobortis eget. Morbi eleifend quam ut urna finibus maximus. ', 'Mobile', '300', '250', '94', 'uploads/product_image/1656271650.jpg', 0, 0, 0, '2022-06-27 02:27:30', '2022-07-03 23:00:24'),
(2, 3, 'Men fashion', 'yg6tuky6uk6ty7u', 'ukmyumuym', 'fgbedr', 'tgerg', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam hendrerit commodo sodales. Maecenas in tempus magna. Fusce imperdiet tellus nisi, sed consectetur dolor rutrum eget. Suspendisse vitae felis quis justo sagittis imperdiet. Nam congue quam id congue placerat. Quisque suscipit aliquam ex, nec accumsan libero lobortis eget. Morbi eleifend quam ut urna finibus maximus. ', 'tntfynt', '455', '6666', '55', 'uploads/product_image/1656330055.jpg', 0, 0, 0, '2022-06-27 18:40:55', '2022-07-03 22:54:49'),
(5, 5, 'Computer', 'yg6tuky6uk6ty7u', 'ukmyumuym', 'laptop-computer', 'HP Computer', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam hendrerit commodo sodales. Maecenas in tempus magna. Fusce imperdiet tellus nisi, sed consectetur dolor rutrum eget. Suspendisse vitae felis quis justo sagittis imperdiet. Nam congue quam id congue placerat. Quisque suscipit aliquam ex, nec accumsan libero lobortis eget. Morbi eleifend quam ut urna finibus maximus. ', 'tntfynt', '1500', '1000', '200', 'uploads/product_image/1656338402.png', 0, 0, 1, '2022-06-27 18:41:32', '2022-06-27 21:45:27'),
(6, 7, 'T-Shirt', 'fveskrvelr', 'frvhneirhkerf', 'men-shirt', 'T-Shirt Blue', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam hendrerit commodo sodales. Maecenas in tempus magna. Fusce imperdiet tellus nisi, sed consectetur dolor rutrum eget. Suspendisse vitae felis quis justo sagittis imperdiet. Nam congue quam id congue placerat. Quisque suscipit aliquam ex, nec accumsan libero lobortis eget. Morbi eleifend quam ut urna finibus maximus. ', 'Scollor Shirt', '200', '180', '100', 'uploads/product_image/1656341555.jpg', 1, 1, 1, '2022-06-27 21:52:35', '2022-06-27 21:52:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_as` int(11) DEFAULT 0 COMMENT 'Role permission: 0=users, 1=Admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `email`, `email_verified_at`, `password`, `remember_token`, `role_as`, `created_at`, `updated_at`) VALUES
(1, 'Perry', '0987654321', 'admin@gmail.com', NULL, '$2y$10$vLRNaWY/4WOT3oMr0RpCQey.S621SnRVUXIthwiOEBlee4Wg77Cxe', NULL, 1, '2022-06-22 18:57:35', '2022-06-22 18:57:35'),
(2, 'John More', '34567898765', 'more@gmail.com', NULL, '$2y$10$dIFy6h69ZAo0DJDoRTsegeYly64mRMUOEHMdg203OBzZVplKaw2gu', NULL, 0, '2022-06-22 19:41:59', '2022-06-22 19:41:59'),
(3, 'Perry Jack', '90898909878', 'jack@gmail.com', NULL, '$2y$10$Xq4Pzn3zCw260GwcOOoca.dBULJIK5o8Z8uRTaxvDdZVZXWdOqApG', NULL, 0, '2022-06-22 19:42:59', '2022-06-22 19:42:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
