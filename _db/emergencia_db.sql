-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-06-2019 a las 18:35:48
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `emergencia_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bed`
--

CREATE TABLE `bed` (
  `id_bed` int(11) NOT NULL,
  `label` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `demand`
--

CREATE TABLE `demand` (
  `id_deman` int(11) NOT NULL,
  `emergency_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emergency`
--

CREATE TABLE `emergency` (
  `id_emergency` int(11) NOT NULL,
  `room_bed_id` int(11) NOT NULL,
  `nurse_id` int(11) NOT NULL,
  `time_start` time NOT NULL,
  `time_finish` time NOT NULL,
  `created` datetime NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nurse`
--

CREATE TABLE `nurse` (
  `id_nurse` int(11) NOT NULL,
  `rfid` varchar(11) COLLATE utf8_spanish_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `ci` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `cellphone` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `room`
--

CREATE TABLE `room` (
  `id_room` int(11) NOT NULL,
  `label` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `room_bed`
--

CREATE TABLE `room_bed` (
  `id_room_bed` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `bed_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bed`
--
ALTER TABLE `bed`
  ADD PRIMARY KEY (`id_bed`);

--
-- Indices de la tabla `demand`
--
ALTER TABLE `demand`
  ADD PRIMARY KEY (`id_deman`),
  ADD KEY `emergency_id_foreign_key` (`emergency_id`);

--
-- Indices de la tabla `emergency`
--
ALTER TABLE `emergency`
  ADD PRIMARY KEY (`id_emergency`),
  ADD KEY `nurse_id_foreign_key` (`nurse_id`),
  ADD KEY `room_bed_id_foreign_key` (`room_bed_id`);

--
-- Indices de la tabla `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`id_nurse`);

--
-- Indices de la tabla `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id_room`);

--
-- Indices de la tabla `room_bed`
--
ALTER TABLE `room_bed`
  ADD PRIMARY KEY (`id_room_bed`),
  ADD KEY `room_id_foreign_key` (`room_id`),
  ADD KEY `bed_id_foreign_key` (`bed_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bed`
--
ALTER TABLE `bed`
  MODIFY `id_bed` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `demand`
--
ALTER TABLE `demand`
  MODIFY `id_deman` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `emergency`
--
ALTER TABLE `emergency`
  MODIFY `id_emergency` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `nurse`
--
ALTER TABLE `nurse`
  MODIFY `id_nurse` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `room`
--
ALTER TABLE `room`
  MODIFY `id_room` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `room_bed`
--
ALTER TABLE `room_bed`
  MODIFY `id_room_bed` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `demand`
--
ALTER TABLE `demand`
  ADD CONSTRAINT `emergency_id_foreign_key` FOREIGN KEY (`emergency_id`) REFERENCES `emergency` (`id_emergency`);

--
-- Filtros para la tabla `emergency`
--
ALTER TABLE `emergency`
  ADD CONSTRAINT `nurse_id_foreign_key` FOREIGN KEY (`nurse_id`) REFERENCES `nurse` (`id_nurse`),
  ADD CONSTRAINT `room_bed_id_foreign_key` FOREIGN KEY (`room_bed_id`) REFERENCES `room_bed` (`id_room_bed`);

--
-- Filtros para la tabla `room_bed`
--
ALTER TABLE `room_bed`
  ADD CONSTRAINT `bed_id_foreign_key` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`id_bed`),
  ADD CONSTRAINT `room_id_foreign_key` FOREIGN KEY (`room_id`) REFERENCES `room` (`id_room`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
