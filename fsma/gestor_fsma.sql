-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 17-05-2023 a las 22:22:02
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestor_fsma`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `apikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `review` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `userscore` float NOT NULL,
  `timesWatched` int NOT NULL,
  PRIMARY KEY (`email`,`apikey`),
  KEY `APIKEY_OPINION_CINEMA` (`apikey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE IF NOT EXISTS `film` (
  `apikey` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `score` float NOT NULL,
  `usersHaveWatched` int NOT NULL,
  PRIMARY KEY (`apikey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `films`
--

DROP TABLE IF EXISTS `films`;
CREATE TABLE IF NOT EXISTS `films` (
  `api_key` varchar(255) NOT NULL,
  `score` float DEFAULT NULL,
  `user_have_watched` int DEFAULT NULL,
  PRIMARY KEY (`api_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listfilms`
--

DROP TABLE IF EXISTS `listfilms`;
CREATE TABLE IF NOT EXISTS `listfilms` (
  `apikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `watcheddate` date NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`apikey`,`email`,`watcheddate`),
  KEY `EMAIL_LISTFILMS_USER` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `apikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `score` float NOT NULL,
  `usersHaveWatched` int NOT NULL,
  PRIMARY KEY (`apikey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `series`
--

DROP TABLE IF EXISTS `series`;
CREATE TABLE IF NOT EXISTS `series` (
  `apikey` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `score` float NOT NULL,
  `usersHaveWatched` int NOT NULL,
  `api_key` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `user_have_watched` int DEFAULT NULL,
  PRIMARY KEY (`apikey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serieshistory`
--

DROP TABLE IF EXISTS `serieshistory`;
CREATE TABLE IF NOT EXISTS `serieshistory` (
  `apikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `season` int NOT NULL,
  `episode` int NOT NULL,
  PRIMARY KEY (`apikey`,`email`,`season`,`episode`),
  KEY `EMAIL_LISTSERIES_USER` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `serieslist`
--

DROP TABLE IF EXISTS `serieslist`;
CREATE TABLE IF NOT EXISTS `serieslist` (
  `apikey` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `startdate` date NOT NULL,
  `finishdate` date NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`apikey`,`email`,`startdate`,`finishdate`),
  KEY `EMAIL_DATASERIES_USER` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `image` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `language` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT 'en',
  `region` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT 'US',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`email`, `username`, `password`, `image`, `language`, `region`) VALUES
('dasd@gmail.com', 'asd', 'asd', '2.png', 'es', 'ES'),
('edorta@gmail.com', 'Edorta', 'edorta', '4.png', 'es', 'ES'),
('elpapeles@gmail.com', 'raya', 'decocaquemehemetioo', '5.png', 'en', 'US'),
('leo@messi.com', 'elamigodesergio', 'balondeoro', '3.png', 'es', 'ES'),
('sergiodanielgroppa@gmail.com', 'Sergio1025', 'sergio', '2.png', 'es', 'ES'),
('txema@gmail.com', 'txema', 'sensillito', '4.png', 'es', 'ES');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `APIKEY_OPINION_CINEMA` FOREIGN KEY (`apikey`) REFERENCES `media` (`apikey`),
  ADD CONSTRAINT `EMAIL_OPINION_USER` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Filtros para la tabla `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `APIKEY_FILM_MEDIA` FOREIGN KEY (`apikey`) REFERENCES `media` (`apikey`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `listfilms`
--
ALTER TABLE `listfilms`
  ADD CONSTRAINT `APIKEY_LISTFILMS_FILMS` FOREIGN KEY (`apikey`) REFERENCES `film` (`apikey`),
  ADD CONSTRAINT `EMAIL_LISTFILMS_USER` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Filtros para la tabla `series`
--
ALTER TABLE `series`
  ADD CONSTRAINT `APIKEY_SERIES_MEDIA` FOREIGN KEY (`apikey`) REFERENCES `media` (`apikey`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `serieshistory`
--
ALTER TABLE `serieshistory`
  ADD CONSTRAINT `APIKEY_LISTSERIES_SERIES` FOREIGN KEY (`apikey`) REFERENCES `series` (`apikey`),
  ADD CONSTRAINT `EMAIL_LISTSERIES_USER` FOREIGN KEY (`email`) REFERENCES `user` (`email`);

--
-- Filtros para la tabla `serieslist`
--
ALTER TABLE `serieslist`
  ADD CONSTRAINT `APIKEY_DATASERIES_SERIES` FOREIGN KEY (`apikey`) REFERENCES `series` (`apikey`),
  ADD CONSTRAINT `EMAIL_DATASERIES_USER` FOREIGN KEY (`email`) REFERENCES `user` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
