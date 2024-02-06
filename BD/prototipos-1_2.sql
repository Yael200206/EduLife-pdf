-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-01-2024 a las 08:37:41
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prototipos`
--
CREATE DATABASE IF NOT EXISTS `prototipos` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `prototipos`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
CREATE TABLE IF NOT EXISTS `alumnos` (
  `idalumnos` int(11) NOT NULL AUTO_INCREMENT,
  `no_control` varchar(14) NOT NULL,
  `curp` varchar(18) NOT NULL,
  `grado` varchar(1) NOT NULL,
  `grupo_idgrupo` int(11) NOT NULL,
  PRIMARY KEY (`idalumnos`,`no_control`,`curp`,`grupo_idgrupo`),
  KEY `fk_alumnos_grupo_idx` (`grupo_idgrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`idalumnos`, `no_control`, `curp`, `grado`, `grupo_idgrupo`) VALUES
(1, '21301061550046', 'ZARJ061110HASRDLA3', '6', 1),
(2, '21301061550024', '  MODH060220HASNRR', '5', 1),
(3, '21301061550020', 'MAMS050929HASCRNA1', '5', 1),
(4, '21301061550038', 'ROCD060120MASDRNA9', '5', 1),
(5, '22301061550035', 'OOHP070312MASCRLA6', '1', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avisos`
--

DROP TABLE IF EXISTS `avisos`;
CREATE TABLE IF NOT EXISTS `avisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `avisos`
--

INSERT INTO `avisos` (`id`, `titulo`, `descripcion`, `fecha`) VALUES
(1, 'Kicka fest aviso', 'NUEVA KICKS FEST 19 NOVIEMBRE ALGO BIEN ', '2023-11-19'),
(2, 'CREDENCIAL DE ELECTOR', 'SE LES INFORMA QUE EL PRÓXIMO MARTES 21 DE NOVIEMBRE, ESTARÁ EL PERSONAL DEL INE, PARA REALIZAR LA ENTREGA DE LAS CREDENCIALES DE ELECTOR QUE SE TRAMITARON EN SU VISITA DE HACE UNOS DÍAS, EN EL MISMO LUGAR, EN UN HORARIO DE 10:00 A 17:00 HRS.\r\nATENTAMENTE\r\nDEPTO. DE VINCULACIÓN', '2023-11-17'),
(3, 'Becas Bienestar Benito Juárez ', 'Se les informa que ya empezó el proceso para el cobro de beca de los bimestres sep-oct y nov-dic por lo que se les pide seguir las indicaciones que se les comparten a continuación.\r\n\r\nPara saber si son alumnos beneficiados para la beca lo pueden ir consultando en:\r\n\r\nHttps://buscador.becasbenitojuarez.gob.mx/consulta/', '2023-11-21'),
(4, 'Becas Bienestar Benito Juárez ', 'Se les informa que ya empezó el proceso para el cobro de beca de los bimestres sep-oct y nov-dic por lo que se les pide seguir las indicaciones que se les comparten a continuación.\r\n\r\nPara saber si son alumnos beneficiados para la beca lo pueden ir consultando en:\r\n\r\nHttps://buscador.becasbenitojuarez.gob.mx/consulta/', '2023-11-21'),
(5, 'Edu Sex', 'Buen día estimados alumnos, estarán los de la caravana Edu Sex en el aula de audiovisuales a partir de las 12:20am , al término de sus clases podrán pasar para cualquier duda que tengan sobre sexualidad.\r\n\r\nNota:\r\n\r\nLos que son sexualmente activos pasar para checar expediente. Gracias ', '2023-11-14'),
(6, 'Aviso 92', 'El seguimiento a la indicación a honores a la bandera con respecto al programa de protección civil, les recuerdo que a partir de mañana 8 de noviembre queda vigente el portar su credencial dentro de las instalaciones, cualquier situación particular, atender de forma presencial en dirección y sub-direccion ', '2023-11-07'),
(7, 'Prototipos', 'Hoy dia 21/10/23 se realizo la etapa local de prototipos', '2023-11-21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clubs`
--

DROP TABLE IF EXISTS `clubs`;
CREATE TABLE IF NOT EXISTS `clubs` (
  `idclubs` int(11) NOT NULL,
  `img` longtext NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `horario` varchar(100) NOT NULL,
  `encargado` varchar(100) NOT NULL,
  `lugar` varchar(100) NOT NULL,
  PRIMARY KEY (`idclubs`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `concursos`
--

DROP TABLE IF EXISTS `concursos`;
CREATE TABLE IF NOT EXISTS `concursos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `url_imagen` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `concursos`
--

INSERT INTO `concursos` (`id`, `titulo`, `descripcion`, `url_imagen`, `fecha`) VALUES
(1, '2da COPA UTMA', 'e-SPORTS', 'https://web.whatsapp.com/f18e64f5-6049-49cb-ac28-9e0f971309a1', '2023-11-17'),
(2, '2da COPA UTMA', 'e-SPORTS', 'blob:https://web.whatsapp.com/f18e64f5-6049-49cb-ac28-9e0f971309a1', '2023-11-17'),
(3, '2da COPA UTMA', '', 'blob:https://web.whatsapp.com/f18e64f5-6049-49cb-ac28-9e0f971309a1', '2023-11-17'),
(4, '2da COPA UTMA.', '', 'https://drive.google.com/file/d/1yI7PPHwsTrdKnAhOpl3wVIg6lHQyiV3n/view?usp=drive_link', '2023-11-17'),
(5, 'Festival Academico ', '', 'https://scontent-qro1-1.xx.fbcdn.net/v/t39.30808-6/395405007_820346570099617_5365172789911010944_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeE6n8pjo-WjBwk4CcNkREWy2dR0htL3g3rZ1HSG0veDen90ZsXR2wajQMb2vmnxwxSuTe5a2sOA42_9TYuU29WV&_nc_ohc=_jbE0JTNR-Q', '2023-10-26'),
(6, 'Spelling bee', '', 'https://scontent-qro1-2.xx.fbcdn.net/v/t39.30808-6/387179473_808040491330225_8212021760299380973_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeHMoFS7uV8biLlSAMn1eWJBr4FqK9aHL3qvgWor1ocvegAafJiX2-fU4ERSm3Y9xlSPs-mK3xltoA7gGmUQEkbe&_nc_ohc=ipA4-UJVTr4', '2023-10-10'),
(7, 'Expo ciencias ', 'El Gobierno del Estado de Aguascalientes, a través de la RED Nacional de Actividades Juveniles en Ciencia y Tecnología (LaREDMex) con el respaldo del Movimiento Internacional para el Recreo Científico y Técnico de América Latina (MILSET AMLAT) y el Instituto de Ciencia y\r\nTecnología del Estado de Aguascalientes (INCyTEA).\r\nCONVOCAN\r\nA todos los niños, niñas y jóvenes que estudien en una institución educativa del Estado de Aguascalientes, interesados en el desarrollo y presentación de Proyectos científicos y técnicos, a participar en la ExpoCiencias Aguascalientes 2023, a celebrarse el 31 de octubre de manera presencial en las instalaciones del Museo Descubre.', 'https://scontent-qro1-1.xx.fbcdn.net/v/t39.30808-6/380768523_795134939287447_7268097289049301256_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEveA4Js46A6iWqTVSz6xRkXpRrFXrIzuRelGsVesjO5Fq7rF0YiD4xaYXdG_pddpOCr2XRv9Lev5uIGnAITocQ&_nc_ohc=ia2xpg6_lc8', '2023-09-22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE IF NOT EXISTS `especialidad` (
  `idespecialidad` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  PRIMARY KEY (`idespecialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`idespecialidad`, `nombre`) VALUES
(1, 'PROGRAMACIÓN'),
(2, 'SOPORTE Y MANTENIMIENTO DE EQUIPO DE CÓMPUTO'),
(3, 'ADMINISTRACIÓN DE RECURSOS HUMANOS'),
(4, 'MATENIMIENTO AUTOMOTRIZ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_e`
--

DROP TABLE IF EXISTS `evaluacion_e`;
CREATE TABLE IF NOT EXISTS `evaluacion_e` (
  `idevaluacion_e` int(11) NOT NULL AUTO_INCREMENT,
  `parcial1` decimal(4,2) DEFAULT NULL,
  `parcial2` decimal(4,2) DEFAULT NULL,
  `parcial3` decimal(4,2) DEFAULT NULL,
  `asistencia1` int(11) DEFAULT NULL,
  `asistencia2` int(11) DEFAULT NULL,
  `asistencia3` int(11) DEFAULT NULL,
  `periodo` varchar(45) DEFAULT NULL,
  `acreditacion` varchar(45) DEFAULT NULL,
  `submodulos_idsubmodulos` int(11) NOT NULL,
  `alumnos_idalumnos` int(11) NOT NULL,
  PRIMARY KEY (`idevaluacion_e`,`submodulos_idsubmodulos`,`alumnos_idalumnos`),
  KEY `fk_evaluacion_e_submodulos1_idx` (`submodulos_idsubmodulos`),
  KEY `fk_evaluacion_e_alumnos1_idx` (`alumnos_idalumnos`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_tc`
--

DROP TABLE IF EXISTS `evaluacion_tc`;
CREATE TABLE IF NOT EXISTS `evaluacion_tc` (
  `idevaluacion_tc` int(11) NOT NULL AUTO_INCREMENT,
  `parcial1` decimal(4,2) DEFAULT NULL,
  `parcial2` decimal(4,2) DEFAULT NULL,
  `parcial3` decimal(4,2) DEFAULT NULL,
  `asistencia1` int(11) DEFAULT NULL,
  `asistencia2` int(11) DEFAULT NULL,
  `asistencia3` int(11) DEFAULT NULL,
  `periodo` varchar(45) DEFAULT NULL,
  `acreditacion` varchar(45) DEFAULT NULL,
  `materias_idmaterias` int(11) NOT NULL,
  `alumnos_idalumnos` int(11) NOT NULL,
  PRIMARY KEY (`idevaluacion_tc`,`materias_idmaterias`,`alumnos_idalumnos`),
  KEY `fk_evaluacion_tc_materias1_idx` (`materias_idmaterias`),
  KEY `fk_evaluacion_tc_alumnos1_idx` (`alumnos_idalumnos`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

DROP TABLE IF EXISTS `grupo`;
CREATE TABLE IF NOT EXISTS `grupo` (
  `idgrupo` int(11) NOT NULL AUTO_INCREMENT,
  `letra` varchar(1) NOT NULL,
  `turno` tinyint(4) NOT NULL,
  `especialidad_idespecialidad` int(11) NOT NULL,
  PRIMARY KEY (`idgrupo`,`especialidad_idespecialidad`),
  KEY `fk_grupo_especialidad1_idx` (`especialidad_idespecialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`idgrupo`, `letra`, `turno`, `especialidad_idespecialidad`) VALUES
(1, 'A', 0, 1),
(2, 'B', 0, 2),
(3, 'C', 0, 3),
(4, 'D', 0, 3),
(5, 'E', 0, 3),
(6, 'F', 0, 4),
(7, 'G', 1, 1),
(8, 'H', 1, 2),
(9, 'I', 1, 3),
(10, 'J', 1, 3),
(11, 'K', 1, 3),
(12, 'L', 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

DROP TABLE IF EXISTS `materias`;
CREATE TABLE IF NOT EXISTS `materias` (
  `idmaterias` int(11) NOT NULL AUTO_INCREMENT,
  `uac` varchar(20) NOT NULL,
  `nombre` varchar(400) NOT NULL,
  `horas` int(11) NOT NULL,
  `semestre` int(11) NOT NULL,
  PRIMARY KEY (`idmaterias`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`idmaterias`, `uac`, `nombre`, `horas`, `semestre`) VALUES
(1, '343101-17DB', 'ÁLGEBRA', 4, 1),
(2, '322201-17DB', 'INGLÉS I', 3, 1),
(3, '342201-17DB', 'QUÍMICA I', 4, 1),
(4, '344101-17DB', 'TECNOLOGÍAS DE LA INFORMACIÓN Y LA COMUNICACIÓN', 3, 1),
(5, '322501-17DB', 'LÓGICA', 4, 1),
(6, '322301-17DB', 'LECTURA, EXPRESIÓN ORAL Y ESCRITA I', 4, 1),
(7, '343102-17DB', 'GEOMETRÍA Y TRIGONOMETRÍA', 4, 2),
(8, '322202-17DB', 'INGLÉS II', 3, 2),
(9, '342202-17DB', 'QUÍMICA II', 4, 2),
(10, '322302-17DB', 'LECTURA, EXPRESIÓN ORAL Y ESCRITA II', 4, 2),
(11, '343103-17DB', 'GEOMETRÍA ANALÍTICA', 4, 3),
(12, '322203-17DB', 'INGLÉS III', 3, 3),
(13, '341101-17DB', 'BIOLOGÍA', 4, 3),
(14, '322502-17DB', 'ÉTICA', 4, 3),
(15, '343104-17DB', 'CÁLCULO DIFERENCIAL', 4, 4),
(16, '322204-17DB', 'INGLÉS IV', 3, 4),
(17, '342101-17DB', 'FÍSICA I', 4, 4),
(18, '341201-17DB', 'ECOLOGÍA', 4, 4),
(19, '342102-17DB', 'FISICA II', 4, 5),
(20, '322503-17DB', 'CIENCIA, TECNOLOGÍA, SOCIEDAD Y VALORES', 4, 5),
(21, '343105-17DE', 'CÁLCULO INTEGRAL', 5, 5),
(22, '322205-17FPp', 'INGLÉS V', 5, 5),
(23, '343201-17DE', 'PROBABILIDAD Y ESTADÍSTICA', 5, 6),
(24, '322504-17DE', 'TEMAS DE FILOSOFÍA', 5, 6),
(25, '321402-13-FPp', 'DIBUJO TÉCNICO', 5, 6),
(26, '371001-13-FPp', 'TEMAS DE CIENCIAS DE LA SALUD', 5, 6),
(27, '331002-13-FPp', 'TEMAS DE CIENCIAS SOCIALES', 5, 6),
(28, '322303-13-FPp', 'LITERATURA', 5, 6),
(29, '322401-13-FPp', 'HISTORIA', 5, 6),
(30, '341103-13-FPp', 'TEMAS DE BIOLOGÍA CONTEMPORÁNEA', 5, 6),
(31, '343106-13-FPp', 'MATEMÁTICAS APLICADAS', 5, 6),
(32, '333001-13-FPp', 'TEMAS DE ADMINISTRACIÓN', 5, 6),
(33, '342103-13-FPp', 'TEMAS DE FÍSICA', 5, 6),
(34, '331001-13-FPp', 'INTRODUCCIÓN A LA ECONOMÍA', 5, 6),
(35, '334101-13-FPp', 'INTRODUCCIÓN AL DERECHO', 5, 6),
(36, '341102-13-FPp', 'INTRODUCCIÓN A LA BIOQUÍMICA', 5, 6),
(37, 'P-611-2023-1-1', 'Lengua y comunicación I', 3, 1),
(38, 'P-611-2023-1-2', 'Inglés I', 3, 1),
(39, 'P-611-2023-1-3', 'Pensamiento matemático I', 4, 1),
(40, 'P-611-2023-1-4', 'Cultura digital I', 3, 1),
(41, 'P-611-2023-1-5', 'La materia y sus interacciones', 4, 1),
(42, 'P-611-2023-1-6', 'Humanidades I', 4, 1),
(43, 'P-611-2023-1-7', 'Ciencias sociales I', 2, 1),
(44, 'P-611-2023-1-8', 'Recursos socioemocionales I', 3, 1),
(45, 'P-611-2023-2-1', 'Lengua y comunicación II', 3, 2),
(46, 'P-611-2023-2-2', 'Inglés II', 3, 2),
(47, 'P-611-2023-2-3', 'Pensamiento matemático II', 4, 2),
(48, 'P-611-2023-2-4', 'Cultura digital II', 2, 2),
(49, 'P-611-2023-2-5', 'Conservación de la energía y sus interacciones con la materia', 4, 2),
(50, 'P-611-2023-2-6', 'Ciencias sociales II', 2, 2),
(51, 'P-611-2023-2-8', 'Recursos socioemocionoales II', 3, 2),
(52, 'P-611-2023-3-1', 'Lengua y comunicación III', 3, 3),
(53, 'P-611-2023-3-2', 'Inglés III', 3, 3),
(54, 'P-611-2023-3-3', 'Pensamiento matemático III', 4, 3),
(55, 'P-611-2023-3-4', 'Ecosistemas: interacciones, energía y dinámica', 4, 3),
(56, 'P-611-2023-3-5', 'Humanidades II', 4, 3),
(57, 'P-611-2023-3-7', 'Recursos socioemocionales III', 3, 3),
(58, 'P-611-2023-4-1', 'Inglés IV', 3, 4),
(59, 'P-611-2023-4-2', 'Tenas selectos de matemáticas I', 4, 4),
(60, 'P-611-2023-4-3', 'Conciencia histórica 1: Perspectivas del México antiguo en los contextos globales', 3, 4),
(61, 'P-611-2023-4-4', 'Reacciones químicas: conservación de la materia en la formación de nuevas subtancias', 4, 4),
(62, 'P-611-2023-4-5', 'Ciencias sociales III', 2, 4),
(63, 'P-611-2023-4-7', 'Recursos socioemocionales IV', 3, 4),
(64, 'P-611-2023-5-1', 'Inglés V', 5, 5),
(65, 'P-611-2023-5-10', 'Temas de administración ', 3, 5),
(66, 'P-611-2023-5-11', 'Introducción a la economía', 3, 5),
(67, 'P-611-2023-5-12', 'Introducción al Derecho', 3, 5),
(68, 'P-611-2023-5-13', 'Introducción a la bioquímica', 3, 5),
(69, 'P-611-2023-5-14', 'Temas de biología contemporánea', 3, 5),
(70, 'P-611-2023-5-15', 'Temas de Ciencias de la Salud', 3, 5),
(71, 'P-611-2023-5-16', 'Temas de Ciencias Sociales', 3, 5),
(72, 'P-611-2023-5-17', 'Literatura', 3, 5),
(73, 'P-611-2023-5-18', 'Historia', 3, 5),
(74, 'P-611-2023-5-2', 'Temas selectos de matemáticas II', 5, 5),
(75, 'P-611-2023-5-3', 'Conciencia histórica II. México durante el expansionismo capitalista.', 3, 5),
(76, 'P-611-2023-5-4', 'La energía en los procesos de la vida diaria', 4, 5),
(77, 'P-611-2023-5-6', 'Recursos socioemocionales V', 3, 5),
(78, 'P-611-2023-5-7', 'Temas de física', 3, 5),
(79, 'P-611-2023-5-8', 'Dibujo técnico', 3, 5),
(80, 'P-611-2023-5-9', 'Matemáticas', 3, 5),
(81, 'P-611-2023-6-1', 'Temas selectos de matemáticas III', 5, 6),
(82, 'P-611-2023-6-10', 'Temas de administración', 3, 6),
(83, 'P-611-2023-6-11', 'Introducción a la economía', 3, 6),
(84, 'P-611-2023-6-12', 'Introducción al Derecho', 3, 6),
(85, 'P-611-2023-6-13', 'Introducción a la bioquímica', 3, 6),
(86, 'P-611-2023-6-14', 'Temas de biología contemporánea', 3, 6),
(87, 'P-611-2023-6-15', 'Temas de Ciencias de la Salud', 3, 6),
(88, 'P-611-2023-6-16', 'Temas de Ciencias Sociales', 3, 6),
(89, 'P-611-2023-6-17', 'Literatura', 3, 6),
(90, 'P-611-2023-6-18', 'Historia', 3, 6),
(91, 'P-611-2023-6-2', 'Conciencia histórica III. La realidad actual en perspectiva histórica', 3, 6),
(92, 'P-611-2023-6-3', 'Organismos, estructuras y procesos. Herencia y evolución biológica', 4, 6),
(93, 'P-611-2023-6-4', 'Humanidades III', 5, 6),
(94, 'P-611-2023-6-6', 'Recursos socioemocionales VI', 3, 6),
(95, 'P-611-2023-6-7', 'Temas de física', 3, 6),
(96, 'P-611-2023-6-8', 'Dibujo técnico', 3, 6),
(99, 'P-611-2023-6-9', 'Matemáticas', 3, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

DROP TABLE IF EXISTS `modulos`;
CREATE TABLE IF NOT EXISTS `modulos` (
  `idmodulos` int(11) NOT NULL AUTO_INCREMENT,
  `uac` varchar(20) NOT NULL,
  `nombre` varchar(400) NOT NULL,
  `horas` int(11) NOT NULL,
  `semestre` int(11) NOT NULL,
  `especialidad_idespecialidad` int(11) NOT NULL,
  PRIMARY KEY (`idmodulos`,`uac`,`especialidad_idespecialidad`),
  KEY `fk_modulos_especialidad1_idx` (`especialidad_idespecialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`idmodulos`, `uac`, `nombre`, `horas`, `semestre`, `especialidad_idespecialidad`) VALUES
(1, '3061300001-17M1', 'MÓDULO I. DESARROLLA SOFTWARE DE APLICACION CON PROGRAMACIÓN ESTRUCTURADA', 17, 2, 1),
(2, '3061300001-17M2', 'MÓDULO II. APLICA METODOLOGÍAS DE DESARROLLO DE SOFTWARE CON HERRAMIENTAS DE PROGRAMACIÓN VISUAL', 17, 3, 1),
(3, '3061300001-17M3', 'MÓDULO III. DESARROLLA APLICACIONES WEB', 17, 4, 1),
(4, '3061300001-17M4', 'MÓDULO IV. DESARROLLA SOFTWARE DE APLICACIÓN WEB CON ALMACENAMIENTO PERSISTENTE DE DATOS', 12, 5, 1),
(5, '3061300001-17M5', 'MÓDULO V. DESARROLLA APLICACIONES PARA DISPOSITIVOS MOVILES', 12, 6, 1),
(6, '3062300001-17M1', 'MÓDULO I. ENSAMBLA, CONFIGURA E INSTALA HARDWARE Y SOFTWARE EN EL EQUIPO DE CÓMPUTO', 17, 2, 2),
(7, '3062300001-17M2', 'MÓDULO II. MANTIENE HARDWARE Y SOFTWARE EN EL EQUIPO DE CÓMPUTO', 17, 3, 2),
(8, '3062300001-17M3', 'MÓDULO III. PROPORCIONA SOPORTE TÉCNICO PRESENCIAL O A DISTANCIA EN SOFTWARE DE APLICACIÓN Y HARDWARE', 17, 4, 2),
(9, '3062300001-17M4', 'MÓDULO IV. DISEÑA REDES DE COMPUTADORAS', 12, 5, 2),
(10, '3062300001-17M5', 'MÓDULO V. INSTALA Y OPERA REDES DE COMPUTADORAS', 12, 6, 2),
(11, '333502001-16M1', 'MÓDULO I. PLANTEA ACTIVIDADES DEL ÁREA DE RECURSOS HUMANOS EN FUNCIÓN A CADA ÁREA DE LA ORGANIZACIÓN', 17, 2, 3),
(12, '333502001-16M2', 'MÓDULO II. INTEGRA EL CAPITAL HUMANO A LA ORGANIZACIÓN', 17, 3, 3),
(13, '333502001-16M3', 'MÓDULO III. ASISTE EN EL CONTROL Y EVALUACIÓN DEL DESEMPEÑO DEL CAPITAL HUMANO DE LA ORGANIZACIÓN', 17, 4, 3),
(14, '333502001-16M4', 'MÓDULO IV. CONTROLA LOS PROCESOS Y SERVICIOS DE HIGIENE Y SEGURIDAD DEL CAPITAL HUMANO EN LA ORGANIZACIÓN', 12, 5, 3),
(15, '333502001-16M5', 'MÓDULO V. DETERMINA LAS REMUNERACIONES AL CAPITAL HUMANO DE LA ORGANIZACIÓN', 12, 6, 3),
(16, '351500002-16M1', 'MÓDULO I. MANTIENE LOS SISTEMAS ELÉCTRICOS Y ELECTRÓNICOS DEL AUTOMÓVIL', 17, 2, 4),
(17, '351500002-16M2', 'MÓDULO II. MANTIENE EL MOTOR DE COMBUSTIÓN INTERNA', 17, 3, 4),
(18, '351500002-16M3', 'MÓDULO III. MANTIENE LOS SISTEMAS DE CONTROL ELECTRÓNICO DEL MOTOR DE COMBUSTIÓN INTERNA', 17, 4, 4),
(19, '351500002-16M4', 'MÓDULO IV. MANTIENE EL SISTEMA DE TRANSMISIÓN DEL AUTOMÓVIL', 12, 5, 4),
(20, '351500002-16M5', 'MÓDULO V. MANTIENE LOS SISTEMAS DE SUSPENSIÓN, DIRECCIÓN Y FRENOS DEL AUTOMÓVIL', 12, 6, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `noticias`
--

DROP TABLE IF EXISTS `noticias`;
CREATE TABLE IF NOT EXISTS `noticias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `img` longtext DEFAULT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `noticias`
--

INSERT INTO `noticias` (`id`, `titulo`, `descripcion`, `img`, `fecha`) VALUES
(1, 'A0', 'A1', 'A2', '0000-00-00'),
(2, 'PRUEBA NOTICIA 2', 'poyo', 'https://i1.sndcdn.com/artworks-H9LFl7AcqlzAMGKz-oKNKGg-t500x500.jpg', '2024-01-07'),
(3, 'prueba noticias 3', 'poyo3, mas poyo que nunca', 'data:image/jpeg;base64,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', '2024-01-07'),
(4, 'sexo 2', 'TODO ES CULPA DE LA 4 T', 'data:image/jpeg;base64,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', '2024-01-19'),
(5, 'sexo 2', 'TODO ES CULPA DE LA 4 T', 'data:image/jpeg;base64,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', '2024-01-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `submodulos`
--

DROP TABLE IF EXISTS `submodulos`;
CREATE TABLE IF NOT EXISTS `submodulos` (
  `idsubmodulos` int(11) NOT NULL AUTO_INCREMENT,
  `uac` varchar(20) NOT NULL,
  `nombre` varchar(400) NOT NULL,
  `horas` int(11) NOT NULL,
  `modulos_idmodulos` int(11) NOT NULL,
  PRIMARY KEY (`idsubmodulos`,`modulos_idmodulos`),
  KEY `fk_submodulos_modulos1_idx` (`modulos_idmodulos`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `submodulos`
--

INSERT INTO `submodulos` (`idsubmodulos`, `uac`, `nombre`, `horas`, `modulos_idmodulos`) VALUES
(1, '3061300001-17M1S1', 'CONSTRUYE ALGORITMOS PARA LA SOLUCIÓN DE PROBLEMAS', 5, 1),
(2, '3061300001-17M1S2', 'APLICA ESTRUCTURAS DE CONTROL CON UN LENGUAJE DE PROGRAMACIÓN', 7, 1),
(3, '3061300001-17M1S3', 'APLICA ESTRUCTURAS DE DATOS CON UN LENGUAJE DE PROGRAMACIÓN', 5, 1),
(4, '3061300001-17M2S1', 'APLICA LA METODOLOGÍA ESPIRAL CON PROGRAMACIÓN ORIENTADA A OBJETOS', 9, 2),
(5, '3061300001-17M2S2', 'APLICA LA METODOLOGÍA DE DESARROLLO RÁPIDO DE APLICACIONES CON PROGRAMACIÓN ORIENTADA A EVENTOS', 11, 2),
(6, '3061300001-17M3S1', 'CONSTRUYE PÁGINAS WEB', 4, 3),
(7, '3061300001-17M3S2', 'DESARROLLA APLICACIONES QUE SE EJECUTAN EN EL CLIENTE', 6, 3),
(8, '3061300001-17M3S3', 'DESARROLLA APLICACIONES QUE SE EJECUTAN EN EL SERVIDOR', 7, 3),
(9, '3061300001-17M4S1', 'CONSTRUYE BASES DE DATOS PARA APLICACIONES WEB', 6, 4),
(10, '3061300001-17M4S2', 'DESARROLLA APLICACIONES WEB CON CONEXIÓN A BASES DE DATOS', 6, 4),
(11, '3061300001-17M5S1', 'DESARROLLA APLICACIONES MÓVILES PARA ANDROID', 6, 5),
(12, '3061300001-17M5S2', 'DESARROLLA APLICACIONES MÓVILES PARA IOS', 6, 5),
(13, '3062300001-17M1S1', 'ENSAMBLA E INSTALA CONTROLADORES Y DISPOSITIVOS PERIFÉRICOS', 10, 6),
(14, '3062300001-17M1S2', 'INSTALA Y CONFIGURA SOFTWARE', 7, 6),
(15, '3062300001-17M2S1', 'REALIZA MANTENIMIENTO PREVENTIVO', 7, 7),
(16, '3062300001-17M2S2', 'REALIZA MANTENIMIENTO CORRECTIVO', 10, 7),
(17, '3062300001-17M3S1', 'BRINDA SOPORTE TÉCNICO DE MANERA PRESENCIAL', 6, 8),
(18, '3062300001-17M3S2', 'BRINDA SOPORTE TÉCNICO A DISTANCIA', 11, 8),
(19, '3062300001-17M4S1', 'CLASIFICA LOS ELEMENTOS BÁSICOS DE LA RED LAN', 5, 9),
(20, '3062300001-17M4S2', 'DISEÑA LA RED LAN', 7, 9),
(21, '3062300001-17M5S1', 'INSTALA UNA RED LAN', 6, 10),
(22, '3062300001-17M5S2', 'OPERA UNA RED LAN', 6, 10),
(23, '333502001-16M1S1', 'DISTINGUE LOS DIFERENTES TIPOS DE EMPRESA POR SU GIRO, ÁREAS FUNCIONALES, DOCUMENTACIÓN ADMINISTRATIVA Y RECURSOS', 10, 11),
(24, '333502001-16M1S2', 'ELABORA ESTRATEGIAS PARA REALIZAR LAS ACTIVIDADES DE SU ÁREA', 7, 11),
(25, '333502001-16M2S1', 'REALIZA EL PROCESO DE ADMISIÓN Y EMPLEO', 10, 12),
(26, '333502001-16M2S2', 'CONTRIBUYE A LA INTEGRACIÓN Y DESARROLLO DEL PERSONAL EN LA ORGANIZACIÓN', 7, 12),
(27, '333502001-16M3S1', 'ASISTE EN LAS ACTIVIDADES DE CAPACITACIÓN PARA EL DESARROLLO DEL CAPITAL HUMANO', 7, 13),
(28, '333502001-16M3S2', 'EVALÚA EL DESEMPEÑO DE LA ORGANIZACIÓN UTILIZANDO HERRAMIENTAS DE CALIDAD', 10, 13),
(29, '333502001-16M4S1', 'SUPERVISA EL CUMPLIMIENTO DE LAS MEDIDAS DE HIGIENE Y SEGURIDAD EN LA ORGANIZACIÓN', 6, 14),
(30, '333502001-16M4S2', 'SUPERVISA EL CUMPLIMIENTO DE TAREAS Y PROCESOS PARA EVALUAR LA PRODUCTIVIDAD EN LA ORGANIZACIÓN', 6, 14),
(31, '333502001-16M5S1', 'DETERMINA LA NÓMINA DEL PERSONAL DE LA ORGANIZACIÓN TOMANDO EN CUENTA LA NORMATIVIDAD LABORAL', 8, 15),
(32, '333502001-16M5S2', 'DETERMINA REMUNERACIONES DEL PERSONAL EN SITUACIONES EXTRAORDINARIAS', 4, 15),
(33, '351500002-16M1S1', 'MANTIENE EL SISTEMA ELÉCTRICO DEL AUTOMÓVIL', 6, 16),
(34, '351500002-16M1S2', 'MANTIENE EL SISTEMA ELECTRÓNICO DEL AUTOMÓVIL', 11, 16),
(35, '351500002-16M2S1', 'MANTIENE EL MOTOR DE GASOLINA Y DE DIÉSEL', 8, 17),
(36, '351500002-16M2S2', 'MANTIENE EL SISTEMA DE CALEFACCIÓN Y AIRE ACONDICIONADO DEL AUTOMÓVIL', 4, 17),
(37, '351500002-16M2S3', 'MANTIENE EL SISTEMA DE ENFRIAMIENTO Y LUBRICACIÓN DEL MOTOR', 5, 17),
(38, '351500002-16M3S1', 'MANTIENE EL SISTEMA DE INYECCIÓN ELECTRÓNICA DE LOS MOTORES DE GASOLINA Y DIÉSEL', 7, 18),
(39, '351500002-16M3S2', 'MANTIENE EL SISTEMA DE EMISIONES CONTAMINANTES DEL AUTOMÓVIL', 4, 18),
(40, '351500002-16M3S3', 'MANTIENE EL SISTEMAS DE ENCENDIDO ELECTRÓNICO Y COMPUTARIZADO DEL AUTOMÓVIL', 6, 18),
(41, '351500002-16M4S1', 'MANTIENE EL SISTEMA DE TRANSMISIÓN Y TRANSEJE MANUAL DEL AUTOMÓVIL', 6, 19),
(42, '351500002-16M4S2', 'MANTIENE EL SISTEMA DE TRANSMISIÓN Y TRANSEJE AUTOMÁTICO DEL AUTOMÓVIL', 6, 19),
(43, '351500002-16M5S1', 'MANTIENE LOS SISTEMAS DE SUSPENSIÓN Y DIRECCIÓN DEL AUTOMÓVIL', 5, 20),
(44, '351500002-16M5S2', 'MANTIENE EL SISTEMA DE FRENOS DEL AUTOMÓVIL', 7, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutorias`
--

DROP TABLE IF EXISTS `tutorias`;
CREATE TABLE IF NOT EXISTS `tutorias` (
  `idtutorias` int(11) NOT NULL,
  `salon` varchar(45) NOT NULL,
  `horario` varchar(100) NOT NULL,
  `maestro` varchar(100) NOT NULL,
  `materias_idmaterias` int(11) NOT NULL,
  PRIMARY KEY (`idtutorias`,`materias_idmaterias`),
  KEY `fk_tutorias_materias_idx` (`materias_idmaterias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD CONSTRAINT `fk_alumnos_grupo` FOREIGN KEY (`grupo_idgrupo`) REFERENCES `grupo` (`idgrupo`);

--
-- Filtros para la tabla `evaluacion_e`
--
ALTER TABLE `evaluacion_e`
  ADD CONSTRAINT `fk_evaluacion_e_alumnos1` FOREIGN KEY (`alumnos_idalumnos`) REFERENCES `alumnos` (`idalumnos`),
  ADD CONSTRAINT `fk_evaluacion_e_submodulos1` FOREIGN KEY (`submodulos_idsubmodulos`) REFERENCES `submodulos` (`idsubmodulos`);

--
-- Filtros para la tabla `evaluacion_tc`
--
ALTER TABLE `evaluacion_tc`
  ADD CONSTRAINT `fk_evaluacion_tc_alumnos1` FOREIGN KEY (`alumnos_idalumnos`) REFERENCES `alumnos` (`idalumnos`),
  ADD CONSTRAINT `fk_evaluacion_tc_materias1` FOREIGN KEY (`materias_idmaterias`) REFERENCES `materias` (`idmaterias`);

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `fk_grupo_especialidad1` FOREIGN KEY (`especialidad_idespecialidad`) REFERENCES `especialidad` (`idespecialidad`);

--
-- Filtros para la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD CONSTRAINT `fk_modulos_especialidad1` FOREIGN KEY (`especialidad_idespecialidad`) REFERENCES `especialidad` (`idespecialidad`);

--
-- Filtros para la tabla `submodulos`
--
ALTER TABLE `submodulos`
  ADD CONSTRAINT `fk_submodulos_modulos1` FOREIGN KEY (`modulos_idmodulos`) REFERENCES `modulos` (`idmodulos`);

--
-- Filtros para la tabla `tutorias`
--
ALTER TABLE `tutorias`
  ADD CONSTRAINT `fk_tutorias_materias` FOREIGN KEY (`materias_idmaterias`) REFERENCES `materias` (`idmaterias`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
