-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-06-2019 a las 01:28:43
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.1

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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNurse` (IN `_rfid` VARCHAR(11), IN `_firstName` VARCHAR(100), IN `_lastName` VARCHAR(100), IN `_ci` VARCHAR(20), IN `_cellphone` VARCHAR(50))  BEGIN

    DECLARE error INT DEFAULT 0;
    DECLARE msg TEXT DEFAULT '';
    DECLARE failed BOOLEAN DEFAULT false;
    DECLARE idRepeat INT;
    DECLARE idInsert INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET error=1;
		SELECT "HANDLER FOR SQLEXCEPTION" error,"Transacción no completada: insertNurse." msg,'true' failed;
	END;

    START TRANSACTION;

    -- CHECK REPEAT
    SET idRepeat = (SELECT id_nurse FROM nurse WHERE ci = _ci OR rfid = _rfid ORDER BY id_nurse DESC LIMIT 1);
    
    if isnull(idRepeat) THEN
        INSERT INTO nurse VALUES(
            null,
            _rfid,
            _firstName, 
            _lastName, 
            _ci,	
            _cellphone, 
            CURRENT_TIMESTAMP, 
            CURRENT_TIMESTAMP,
            1
        );
        SET msg = "Insertado con exito";
        SET idInsert = @@identity;
    ELSE
		SET msg = "Ya fue registrado";
        SET idInsert = idRepeat;
        SET failed = true;
    END IF;
    
    IF (error = 1) THEN
		ROLLBACK;
	ELSE
		SELECT idInsert, msg, failed;
		COMMIT;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateNurse` (IN `_idNurse` INT(11), IN `_firstName` VARCHAR(100), IN `_lastName` VARCHAR(100), IN `_ci` VARCHAR(20), IN `_cellphone` VARCHAR(50))  BEGIN

    DECLARE error INT DEFAULT 0;
    DECLARE msg TEXT DEFAULT '';
    DECLARE failed BOOLEAN DEFAULT false;
    DECLARE idRepeat INT;
    DECLARE idInsert INT;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
		SET error=1;
		SELECT "HANDLER FOR SQLEXCEPTION" error,"Transacción no completada: insertNurse." msg,'true' failed;
	END;

    START TRANSACTION;

    -- CHECK REPEAT
    SET idRepeat = (SELECT id_nurse FROM nurse WHERE id_nurse = _idNurse ORDER BY id_nurse DESC LIMIT 1);
    
    if !isnull(idRepeat) THEN
        UPDATE nurse SET
            first_name = _firstName, 
            last_name = _lastName, 
            ci = _ci,	
            cellphone = _cellphone,
            updated = CURRENT_TIMESTAMP
            WHERE id_nurse = _idNurse;
        SET msg = "Actualizado con exito";
        SET idInsert = _idNurse;
    ELSE
		SET msg = "El usuario no esta registrado";
        SET idInsert = idRepeat;
        SET failed = true;
    END IF;
    
    IF (error = 1) THEN
		ROLLBACK;
	ELSE
		SELECT idInsert, msg, failed;
		COMMIT;
	END IF;
END$$

DELIMITER ;

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
  `nurse_id` int(11) NOT NULL,
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

--
-- Volcado de datos para la tabla `nurse`
--

INSERT INTO `nurse` (`id_nurse`, `rfid`, `first_name`, `last_name`, `ci`, `cellphone`, `created`, `updated`, `enabled`) VALUES
(1, '6f87e8ff44', 'Lady Ximena', 'Ramos Lopez', '12395700', '79413052', '2019-06-22 17:17:34', '2019-06-22 18:06:30', b'1');

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
  ADD KEY `emergency_id_foreign_key` (`emergency_id`),
  ADD KEY `nurse_id_foreign_key` (`nurse_id`);

--
-- Indices de la tabla `emergency`
--
ALTER TABLE `emergency`
  ADD PRIMARY KEY (`id_emergency`),
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
  MODIFY `id_nurse` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `emergency_id_foreign_key` FOREIGN KEY (`emergency_id`) REFERENCES `emergency` (`id_emergency`),
  ADD CONSTRAINT `nurse_id_foreign_key` FOREIGN KEY (`nurse_id`) REFERENCES `nurse` (`id_nurse`);

--
-- Filtros para la tabla `emergency`
--
ALTER TABLE `emergency`
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
