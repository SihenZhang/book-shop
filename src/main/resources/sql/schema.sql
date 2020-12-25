SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(20) NOT NULL UNIQUE,
  `password` varchar(100) NOT NULL,
  `email` varchar(100)
);

DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `price` decimal(11, 2) NOT NULL,
  `sales` int UNSIGNED NOT NULL,
  `stock` int UNSIGNED NOT NULL,
  `img_path` varchar(200) NOT NULL
);

DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `order_id` varchar(50) PRIMARY KEY,
  `create_time` datetime NOT NULL,
  `price` decimal(11, 2) NOT NULL,
  `status` int NOT NULL DEFAULT 0,
  `user_id` int UNSIGNED NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
);

DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `id` int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `count` int UNSIGNED NOT NULL,
  `price` decimal(11, 2) NOT NULL,
  `order_id` varchar(50) NOT NULL,
  FOREIGN KEY (`order_id`) REFERENCES `t_order` (`order_id`)
);

SET FOREIGN_KEY_CHECKS = 1;