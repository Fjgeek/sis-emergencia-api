-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 05-07-2019 a las 18:48:46
-- Versión del servidor: 10.3.16-MariaDB
-- Versión de PHP: 7.3.6

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
        SET idRepeat = (SELECT id_nurse FROM nurse WHERE id_nurse != _idNurse AND ci = _ci ORDER BY id_nurse DESC LIMIT 1);
        if isnull(idRepeat) THEN
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
			SET msg = "El ci ya esta en uso";
			SET idInsert = idRepeat;
            SET failed = true;
        END IF;
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

--
-- Volcado de datos para la tabla `bed`
--

INSERT INTO `bed` (`id_bed`, `label`, `created`, `updated`, `enabled`) VALUES
(1, 'Cama 1', '2019-06-22 00:00:00', '2019-06-22 00:00:00', b'1'),
(2, 'Cama 2', '2019-06-22 00:00:00', '2019-06-22 00:00:00', b'1'),
(3, 'Cama 3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(4, 'Cama 4', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(5, 'Cama 5', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(6, 'Cama 6', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(7, 'Cama 7', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(8, 'Cama 8', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(9, 'Cama 9', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(10, 'Cama 10', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(11, 'Cama 11', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(12, 'Cama 12', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(13, 'Cama 13', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(14, 'Cama 14', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(15, 'Cama 15', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(16, 'Cama 16', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(17, 'Cama 17', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(18, 'Cama 18', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(19, 'Cama 19', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(20, 'Cama 20', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(21, 'Cama 21', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(22, 'Cama 22', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(23, 'Cama 23', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(24, 'Cama 24', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(25, 'Cama 25', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(26, 'Cama 26', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(27, 'Cama 27', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(28, 'Cama 28', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(29, 'Cama 29', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(30, 'Cama 30', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(31, 'Cama 31', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(32, 'Cama 32', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(33, 'Cama 33', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(34, 'Cama 34', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(35, 'Cama 35', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(36, 'Cama A1', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(37, 'Cama A2', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(38, 'Cama A3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(39, 'Cama B1', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(40, 'Cama B2', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(41, 'Cama B3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(42, 'Cama C1', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(43, 'Cama C2', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(44, 'Cama C3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(45, 'Cama D1', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(46, 'Cama D2', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(47, 'Cama D3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(48, 'Cama E1', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(49, 'Cama E2', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(50, 'Cama E3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `demand`
--

CREATE TABLE `demand` (
  `id_demand` int(11) NOT NULL,
  `nurse_id` int(11) NOT NULL,
  `emergency_id` int(11) NOT NULL,
  `time_attend` time NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `demand`
--

INSERT INTO `demand` (`id_demand`, `nurse_id`, `emergency_id`, `time_attend`, `created`) VALUES
(1, 2, 8, '01:39:55', '2019-07-04 01:39:55'),
(2, 2, 3, '01:41:45', '2019-07-04 01:41:45'),
(3, 2, 6, '01:42:24', '2019-07-04 01:42:24'),
(4, 2, 4, '01:42:43', '2019-07-04 01:42:43'),
(5, 2, 7, '01:45:46', '2019-07-04 01:45:46');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `emergency`
--

CREATE TABLE `emergency` (
  `id_emergency` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `bed_id` int(11) NOT NULL,
  `time_request` time NOT NULL,
  `created` datetime NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `emergency`
--

INSERT INTO `emergency` (`id_emergency`, `room_id`, `bed_id`, `time_request`, `created`, `enabled`) VALUES
(1, 1, 1, '04:04:06', '2019-06-29 00:00:00', b'0'),
(2, 1, 2, '15:27:45', '2019-06-29 15:27:45', b'0'),
(3, 11, 34, '15:39:55', '2019-06-29 15:39:55', b'0'),
(4, 2, 3, '19:39:32', '2019-06-29 19:39:32', b'0'),
(5, 9, 30, '00:30:07', '2019-07-04 00:30:07', b'1'),
(6, 3, 5, '00:30:20', '2019-07-04 00:30:20', b'0'),
(7, 12, 35, '00:30:42', '2019-07-04 00:30:42', b'0'),
(8, 14, 40, '00:30:50', '2019-07-04 00:30:50', b'0');

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
(1, '78f588ju32', 'Maria Rene', 'Ramos Daga', '12345678', '67895532', '2019-06-25 20:23:11', '2019-06-29 01:35:14', b'1'),
(2, '65ff54gg43', 'Lady Ximena', 'Ramos Lopez', '12395771', '78668455', '2019-06-25 20:31:42', '2019-06-29 01:29:35', b'1'),
(3, '', 'Lupe Ximena', 'Lopez Mamani', '45237880', '79412345', '2019-06-25 20:35:13', '2019-06-29 01:55:34', b'0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rfid_read`
--

CREATE TABLE `rfid_read` (
  `id_rfid_read` int(11) NOT NULL,
  `rfid` varchar(11) COLLATE utf8_spanish_ci NOT NULL,
  `enabled` bit(1) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rfid_read`
--

INSERT INTO `rfid_read` (`id_rfid_read`, `rfid`, `enabled`, `created`, `updated`) VALUES
(1, '45ff66dd56', b'0', '2019-06-26 18:34:20', '2019-06-26 20:04:12'),
(2, '45gg44hh56', b'0', '2019-06-26 19:04:18', '2019-06-26 19:08:05'),
(3, '78f588ju32', b'0', '2019-06-26 19:09:28', '2019-06-29 01:34:45'),
(4, '93tt55yy21', b'0', '2019-06-26 19:10:24', '2019-06-26 20:03:49'),
(6, '12ff23gg34', b'0', '2019-06-26 20:17:34', '2019-06-27 15:15:04'),
(7, '34ff56gg78', b'0', '2019-06-27 15:15:48', '2019-06-29 01:30:00'),
(8, '45ff78gg12', b'0', '2019-06-27 15:16:11', '2019-06-27 15:17:55');

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

--
-- Volcado de datos para la tabla `room`
--

INSERT INTO `room` (`id_room`, `label`, `created`, `updated`, `enabled`) VALUES
(1, 'Sala 1', '2019-06-22 00:00:00', '2019-06-22 00:00:00', b'1'),
(2, 'Sala 2', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(3, 'Sala 3', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(4, 'Sala 4', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(5, 'Sala 5', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(6, 'Sala 6', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(7, 'Sala 7', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(8, 'Sala 8', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(9, 'Sala 9', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(10, 'Sala 10', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(11, 'Sala 11', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(12, 'Sala 12', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(13, 'Sala A', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(14, 'Sala B', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(15, 'Sala C', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(16, 'Sala D', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1'),
(17, 'Sala E', '2019-06-23 00:00:00', '2019-06-23 00:00:00', b'1');

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
-- Volcado de datos para la tabla `room_bed`
--

INSERT INTO `room_bed` (`id_room_bed`, `room_id`, `bed_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 2, 4),
(5, 3, 5),
(6, 3, 6),
(7, 3, 7),
(8, 3, 8),
(9, 3, 9),
(10, 3, 10),
(11, 3, 5),
(12, 3, 6),
(13, 3, 7),
(14, 3, 8),
(15, 3, 9),
(16, 3, 10),
(17, 4, 11),
(18, 4, 12),
(19, 4, 13),
(20, 4, 14),
(21, 4, 15),
(22, 4, 16),
(23, 5, 17),
(24, 5, 18),
(25, 5, 19),
(26, 5, 20),
(27, 5, 21),
(28, 5, 22),
(29, 6, 23),
(30, 6, 24),
(31, 7, 25),
(32, 8, 26),
(33, 8, 27),
(34, 8, 28),
(35, 9, 29),
(36, 9, 30),
(37, 10, 31),
(38, 10, 32),
(39, 11, 33),
(40, 11, 34),
(41, 12, 35),
(42, 13, 36),
(43, 13, 37),
(44, 13, 38),
(45, 14, 39),
(46, 14, 40),
(47, 14, 41),
(48, 15, 42),
(49, 15, 43),
(50, 15, 44),
(51, 16, 45),
(52, 16, 46),
(53, 16, 47),
(54, 17, 48),
(55, 17, 49),
(56, 17, 50);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_emergency_now_detail`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_emergency_now_detail` (
`id_emergency` int(11)
,`labelRoom` varchar(40)
,`labelBed` varchar(40)
,`time_request` time
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_history_attend`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_history_attend` (
`id_demand` int(11)
,`id_nurse` int(11)
,`nurseEnabled` bit(1)
,`first_name` varchar(100)
,`last_name` varchar(100)
,`time_request` time
,`time_attend` time
,`labelBed` varchar(40)
,`labelRoom` varchar(40)
,`demand_created` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_room_bed`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `view_room_bed` (
`id_room` int(11)
,`room_label` varchar(40)
,`id_bed` int(11)
,`bed_label` varchar(40)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `view_emergency_now_detail`
--
DROP TABLE IF EXISTS `view_emergency_now_detail`;

CREATE VIEW `view_emergency_now_detail`  AS  select `e`.`id_emergency` AS `id_emergency`,`r`.`label` AS `labelRoom`,`b`.`label` AS `labelBed`,`e`.`time_request` AS `time_request` from ((`emergency` `e` join `room` `r` on(`e`.`room_id` = `r`.`id_room`)) join `bed` `b` on(`e`.`bed_id` = `b`.`id_bed`)) where `e`.`enabled` = 1 ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_history_attend`
--
DROP TABLE IF EXISTS `view_history_attend`;

CREATE VIEW `view_history_attend`  AS  select `dem`.`id_demand` AS `id_demand`,`nr`.`id_nurse` AS `id_nurse`,`nr`.`enabled` AS `nurseEnabled`,`nr`.`first_name` AS `first_name`,`nr`.`last_name` AS `last_name`,`em`.`time_request` AS `time_request`,`dem`.`time_attend` AS `time_attend`,`b`.`label` AS `labelBed`,`r`.`label` AS `labelRoom`,`dem`.`created` AS `demand_created` from ((((`demand` `dem` join `nurse` `nr` on(`dem`.`nurse_id` = `nr`.`id_nurse`)) join `emergency` `em` on(`dem`.`emergency_id` = `em`.`id_emergency`)) join `room` `r` on(`em`.`room_id` = `r`.`id_room`)) join `bed` `b` on(`em`.`bed_id` = `b`.`id_bed`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `view_room_bed`
--
DROP TABLE IF EXISTS `view_room_bed`;

CREATE VIEW `view_room_bed`  AS  select `r`.`id_room` AS `id_room`,`r`.`label` AS `room_label`,`b`.`id_bed` AS `id_bed`,`b`.`label` AS `bed_label` from ((`room_bed` `rb` join `bed` `b` on(`b`.`id_bed` = `rb`.`bed_id`)) join `room` `r` on(`r`.`id_room` = `rb`.`room_id`)) ;

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
  ADD PRIMARY KEY (`id_demand`),
  ADD KEY `emergency_id_foreign_key` (`emergency_id`),
  ADD KEY `fk_id_nurse_demand` (`nurse_id`);

--
-- Indices de la tabla `emergency`
--
ALTER TABLE `emergency`
  ADD PRIMARY KEY (`id_emergency`),
  ADD KEY `room_bed_id_foreign_key` (`room_id`),
  ADD KEY `fk_bed_id_emergency` (`bed_id`);

--
-- Indices de la tabla `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`id_nurse`);

--
-- Indices de la tabla `rfid_read`
--
ALTER TABLE `rfid_read`
  ADD PRIMARY KEY (`id_rfid_read`);

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
  ADD KEY `fk_room_id_room_bed` (`room_id`),
  ADD KEY `fk_bed_id_room_bed` (`bed_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bed`
--
ALTER TABLE `bed`
  MODIFY `id_bed` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `demand`
--
ALTER TABLE `demand`
  MODIFY `id_demand` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `emergency`
--
ALTER TABLE `emergency`
  MODIFY `id_emergency` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `nurse`
--
ALTER TABLE `nurse`
  MODIFY `id_nurse` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rfid_read`
--
ALTER TABLE `rfid_read`
  MODIFY `id_rfid_read` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `room`
--
ALTER TABLE `room`
  MODIFY `id_room` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `room_bed`
--
ALTER TABLE `room_bed`
  MODIFY `id_room_bed` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `demand`
--
ALTER TABLE `demand`
  ADD CONSTRAINT `fk_id_emergency_demand` FOREIGN KEY (`emergency_id`) REFERENCES `emergency` (`id_emergency`),
  ADD CONSTRAINT `fk_id_nurse_demand` FOREIGN KEY (`nurse_id`) REFERENCES `nurse` (`id_nurse`);

--
-- Filtros para la tabla `emergency`
--
ALTER TABLE `emergency`
  ADD CONSTRAINT `fk_bed_id_emergency` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`id_bed`),
  ADD CONSTRAINT `fk_room_id_emergency` FOREIGN KEY (`room_id`) REFERENCES `room` (`id_room`);

--
-- Filtros para la tabla `room_bed`
--
ALTER TABLE `room_bed`
  ADD CONSTRAINT `fk_bed_id_room_bed` FOREIGN KEY (`bed_id`) REFERENCES `bed` (`id_bed`),
  ADD CONSTRAINT `fk_room_id_room_bed` FOREIGN KEY (`room_id`) REFERENCES `room` (`id_room`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
