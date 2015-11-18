-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema dbtec
-- -----------------------------------------------------
-- Base de datos para simular los reportes de tutorias.

-- -----------------------------------------------------
-- Schema dbtec
--
-- Base de datos para simular los reportes de tutorias.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbtec` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `dbtec` ;

-- -----------------------------------------------------
-- Table `dbtec`.`Horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Horario` (
  `idhorario` INT NULL COMMENT 'clave para el horario',
  `hora` TIME NULL COMMENT 'hora de clase',
  `dias` INT NULL COMMENT 'dia',
  PRIMARY KEY (`idhorario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbtec`.`Citas_tutoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Citas_tutoria` (
  `idCitas_tutoria` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria',
  `fecha` DATE NOT NULL COMMENT 'Fecha de la visita',
  `hora` VARCHAR(10) NOT NULL COMMENT 'Hora en que se realiza la visita',
  PRIMARY KEY (`idCitas_tutoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbtec`.`Tutoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Tutoria` (
  `idTutoria` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la tutoria',
  `Citas_tutoria_idCitas_tutoria` INT NOT NULL COMMENT 'Fecha y hora de la tutoria',
  PRIMARY KEY (`idTutoria`),
  INDEX `fk_Tutoria_Citas_tutoria1_idx` (`Citas_tutoria_idCitas_tutoria` ASC),
  CONSTRAINT `fk_Tutoria_Citas_tutoria1`
    FOREIGN KEY (`Citas_tutoria_idCitas_tutoria`)
    REFERENCES `dbtec`.`Citas_tutoria` (`idCitas_tutoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbtec`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Materia` (
  `tutoria_materia` VARCHAR(20) NOT NULL COMMENT 'nombre de la materia',
  `clave_Materia` VARCHAR(8) NOT NULL COMMENT 'clave materia seit',
  `semestre_imparte` INT NOT NULL COMMENT 'semestre desde que se imparte',
  `creditos` INT NULL COMMENT 'Valor en creditos de la materia',
  `Horario_idhorario` INT NOT NULL,
  PRIMARY KEY (`clave_Materia`),
  UNIQUE INDEX `clave_asignatura_UNIQUE` (`clave_Materia` ASC),
  INDEX `fk_Materia_Horario1_idx` (`Horario_idhorario` ASC),
  CONSTRAINT `fk_Materia_Horario1`
    FOREIGN KEY (`Horario_idhorario`)
    REFERENCES `dbtec`.`Horario` (`idhorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbtec`.`Tutor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Tutor` (
  `periodo` DATE NOT NULL COMMENT 'Fecha de inicio de labores como docente',
  `rfc` CHAR(13) NOT NULL COMMENT 'RFC Foreing Key',
  `no_control` CHAR(15) NOT NULL COMMENT 'Matricula del docente',
  `horario_idhorario` INT NOT NULL COMMENT 'Horarios del tutor',
  `Tutoria_idTutoria` INT UNSIGNED NOT NULL COMMENT 'Clave foranea para la tutoria',
  `Materia_clave_Materia` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`rfc`),
  INDEX `fk_tutores_horario1_idx` (`horario_idhorario` ASC),
  INDEX `fk_Tutor_Tutoria1_idx` (`Tutoria_idTutoria` ASC),
  INDEX `fk_Tutor_Materia1_idx` (`Materia_clave_Materia` ASC),
  CONSTRAINT `fk_tutores_horario1`
    FOREIGN KEY (`horario_idhorario`)
    REFERENCES `dbtec`.`Horario` (`idhorario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tutor_Tutoria1`
    FOREIGN KEY (`Tutoria_idTutoria`)
    REFERENCES `dbtec`.`Tutoria` (`idTutoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tutor_Materia1`
    FOREIGN KEY (`Materia_clave_Materia`)
    REFERENCES `dbtec`.`Materia` (`clave_Materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbtec`.`Respuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Respuesta` (
  `idRespuesta` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la encuesta',
  `respuesta` CHAR(1) NOT NULL COMMENT 'Uso un caracter para conocer la respuesta\nEs el contenido',
  PRIMARY KEY (`idRespuesta`))
ENGINE = InnoDB
COMMENT = 'Tabla para almacenar las respuestas';


-- -----------------------------------------------------
-- Table `dbtec`.`Pregunta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Pregunta` (
  `idPregunta` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave primara',
  `contenido_pregunta` VARCHAR(100) NULL COMMENT 'Contenido de la pregunta',
  `Respuesta_idRespuesta` INT NOT NULL COMMENT 'Clave foranea de las posibles respuestas',
  PRIMARY KEY (`idPregunta`),
  INDEX `fk_Pregunta_Respuesta1_idx` (`Respuesta_idRespuesta` ASC),
  CONSTRAINT `fk_Pregunta_Respuesta1`
    FOREIGN KEY (`Respuesta_idRespuesta`)
    REFERENCES `dbtec`.`Respuesta` (`idRespuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbtec`.`Tipo_encuesta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Tipo_encuesta` (
  `idTipo_encuesta` INT NOT NULL AUTO_INCREMENT COMMENT 'Clave primaria de la encuesta',
  `calificacion_encuesta` INT NOT NULL COMMENT 'Calificacion final de la encuesta',
  `nombre_encuesta` VARCHAR(45) NOT NULL COMMENT 'Titulo de la encuesta',
  `Pregunta_idPregunta` INT NOT NULL COMMENT 'Clave foranea de la pregunta ',
  PRIMARY KEY (`idTipo_encuesta`),
  INDEX `fk_Tipo_encuesta_Pregunta1_idx` (`Pregunta_idPregunta` ASC),
  CONSTRAINT `fk_Tipo_encuesta_Pregunta1`
    FOREIGN KEY (`Pregunta_idPregunta`)
    REFERENCES `dbtec`.`Pregunta` (`idPregunta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabla para guardar el tipo de encuesta';


-- -----------------------------------------------------
-- Table `dbtec`.`Alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Alumno` (
  `no_de_control` INT NOT NULL COMMENT 'Matricula del estudiante\nprimero dos digitos = año de ingreso\n resto = numero de registro',
  `carrera` INT(10) NULL COMMENT 'Carrera a la que pertenece',
  `reticula` INT(10) NULL COMMENT 'Materias que cursa',
  `especialidad` INT(10) NULL COMMENT 'Especialidad segun carrera y plan de estudios',
  `nivel_escolar` CHAR(1) NULL COMMENT 'Nivel de estudios actual',
  `semestre` INT NULL COMMENT 'semestre actual de estudio',
  `clave_interna` CHAR(10) NULL COMMENT 'clave redundate ',
  `estatus_alumno` CHAR(3) NULL DEFAULT 'ACT' COMMENT 'El estado actual del alumno \nACT = activo\nBT = baja temporal\nBD = baja definitiva',
  `plan_de_estudios` CHAR(1) NOT NULL COMMENT 'plan de estudios al que pertenece',
  `apellido_paterno` VARCHAR(15) NOT NULL COMMENT 'apellidos del tutor padre',
  `apellido_materno` VARCHAR(15) NOT NULL COMMENT 'apellido del tutor madre',
  `nombre_alumno` VARCHAR(15) NOT NULL COMMENT 'nombre o nombres del alumno',
  `curp_alumno` VARCHAR(10) NULL COMMENT 'clave unica de registro de poblacion ',
  `fecha_nac` DATE NULL COMMENT 'fecha de nacimiento del alumno',
  `sexo` CHAR(1) NULL COMMENT 'sexo de alumno \'  f  \' o \' m \'  ',
  `estado_civil` CHAR(1) NULL COMMENT 's = soltero\nc = casado\nv = viudo\nd = divorciado',
  `periodo_ingreso_it` DATE NOT NULL COMMENT 'fecha de ingreso a la intitucion',
  `tipo_ingreso` DECIMAL(1,0) NOT NULL,
  `ultimo_periodo_inscrito` DATE NULL COMMENT 'ultimo semestre que curso',
  `promedio_periodo_anterior` FLOAT NULL COMMENT 'promedio del curso anterior cursado',
  `promedio_aritmetico_acumulado` FLOAT NULL COMMENT 'promedio de los semestres cursados',
  `creditos_aprobados` INT NULL COMMENT 'cantidad de creditos que aprobo el alumno',
  `creditos_cursados` INT NULL COMMENT 'cantidad de creditos que ha cursado en todos sus cursos',
  `promedio_final_alcanzado` FLOAT NULL COMMENT 'promedio final de titulacion',
  `tipo_servicio_medico` CHAR(1) NULL COMMENT 'p = privado\nf = facultativo\nl = labolal',
  `clave_servicio_medico` CHAR(20) NULL COMMENT 'numero de seguridad medica o social',
  `escuela_procedencia` VARCHAR(50) NULL COMMENT 'nombre de la escuela que procede nivel bachillerato',
  `tipo_escuela` INT NULL COMMENT '0 = publica \n1 = privada\n',
  `domicilio_escuela` VARCHAR(60) NULL COMMENT 'direccion de escuela de procedencia',
  `entidad_procedencia` VARCHAR(30) NULL COMMENT 'estado de que proviene el alumno',
  `ciudad_procedencia` VARCHAR(30) NULL COMMENT 'ciudad de la que proviene',
  `correo_electronico` VARCHAR(60) NULL COMMENT 'direccion de correo electronico',
  `foto` VARCHAR(60) NULL COMMENT 'ruta de la imagen de alumno',
  `firma` VARCHAR(60) NULL COMMENT 'firma electronica',
  `periodos_revalidacion` INT NULL,
  `indice_reprobacion_acumulado` DECIMAL(8,6) NULL COMMENT 'promedio de reprobacion de materias total',
  `becado_por` VARCHAR(100) NULL COMMENT 'entidad que beca al alumno ',
  `nip` INT NULL COMMENT 'clave para sii',
  `tipo_alumno` CHAR(2) NULL COMMENT 'r = regular\ni = irregular',
  `nacionalidad` CHAR(3) NULL COMMENT 'siglas del pais de procedencia',
  `usuario` CHAR(30) NULL COMMENT 'nombre de usuario para sii',
  `fecha_actualizacion` DATETIME NULL COMMENT 'fecha que actualizo sus datos',
  `indice_reprobacion` INT NULL COMMENT 'indice de reprobacion por semestre',
  `tutores_rfc` CHAR(13) NOT NULL,
  `Tipo_encuesta_idTipo_encuesta` INT NOT NULL,
  `Materia_clave_Materia` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`no_de_control`),
  INDEX `fk_alumno_tutores1_idx` (`tutores_rfc` ASC),
  INDEX `fk_Alumno_Tipo_encuesta1_idx` (`Tipo_encuesta_idTipo_encuesta` ASC),
  INDEX `fk_Alumno_Materia1_idx` (`Materia_clave_Materia` ASC),
  CONSTRAINT `fk_alumno_tutores1`
    FOREIGN KEY (`tutores_rfc`)
    REFERENCES `dbtec`.`Tutor` (`rfc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumno_Tipo_encuesta1`
    FOREIGN KEY (`Tipo_encuesta_idTipo_encuesta`)
    REFERENCES `dbtec`.`Tipo_encuesta` (`idTipo_encuesta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alumno_Materia1`
    FOREIGN KEY (`Materia_clave_Materia`)
    REFERENCES `dbtec`.`Materia` (`clave_Materia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Datos generales de alumnos';


-- -----------------------------------------------------
-- Table `dbtec`.`Personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbtec`.`Personal` (
  `rfc` CHAR(13) NOT NULL COMMENT 'clave registro federal contribuyente',
  `clave_centro_seit` CHAR(10) NULL COMMENT 'clave secretaria de educacion de institutos tecnologicos',
  `clave_area` CHAR(6) NULL COMMENT 'area en la que se desempeña el empleado',
  `curp_empleado` CHAR(18) NULL COMMENT 'clave unica de registro de poblacion',
  `no_targeta` INT NULL COMMENT 'no de targeta',
  `apellidos_empleado` VARCHAR(25) NULL COMMENT 'apellidos paterno y materno',
  `nombre_empleado` VARCHAR(20) NULL COMMENT 'nombre del empleadp',
  `horas_nombramiento` INT NULL COMMENT 'horas que ejerce',
  `nombramiento` CHAR(1) NOT NULL COMMENT 'tipo de nombramiento',
  `clases` CHAR(1) NULL,
  `ingreso rama` CHAR(6) NULL COMMENT 'rama en la que ingreso',
  `inicio_gobierno` CHAR(6) NULL COMMENT 'fecha que inicio labores',
  `inicio_sep` CHAR(6) NULL COMMENT 'fecha en que labora en sep',
  `inicio_plantel` CHAR(6) NULL COMMENT 'fecha de inicio de labores en el plantel',
  `domicilio_empleado` VARCHAR(60) NULL COMMENT 'domicilio fiscal',
  `colonia_empleado` VARCHAR(40) NULL COMMENT 'colonia ',
  `codigo_postal` INT NULL COMMENT 'codigo postal',
  `localidad` VARCHAR(30) NULL COMMENT 'Localidad',
  `telefono_empleado` VARCHAR(30) NULL COMMENT 'Numero telefonico ',
  `sexo_empleado` CHAR(1) NULL COMMENT 'Sexo \'M\' o \'F\'',
  `estado_civil` CHAR(1) NULL COMMENT 'S oltero\nC asado\nV iudo\nD ivorciado',
  `fecha_nac` DATE NULL COMMENT 'dia de nacimiento',
  `lugar_nacimiento` INT NULL COMMENT 'lugar de nacimiento',
  `institucion_egreso` VARCHAR(50) NULL COMMENT 'institucion de la cual fue titulado',
  `nivel_estudio` CHAR(1) NULL COMMENT 'I = ingenieria \nL = licenciatura',
  `grado_maximo_estudios` CHAR(1) NULL COMMENT 'Nivel de estudios\nL  icenciatura\nM aestria\nD octorado',
  `estudios` VARCHAR(250) NULL COMMENT 'Nombre de la carrera de titulacion',
  `fecha_terminacion_estudios` DATE NULL COMMENT 'Fecha de terminacion de carrera',
  `fecha_titulacion` DATE NULL COMMENT 'Fecha de recepcion de titulo',
  `cedula_profesional` CHAR(15) NULL COMMENT 'Clave de la cedula profesional',
  `especialidad` VARCHAR(50) NULL COMMENT 'especialidad de la carrera',
  `estatus_empleado` CHAR(2) NULL COMMENT 'estatus\nin = incapaticado\nel = en labores\n',
  `idiomas_domina` VARCHAR(60) NULL COMMENT 'Lenguajes que domina el empleado',
  `foto` VARCHAR(45) NULL COMMENT 'Ruta de la fotografia',
  `firma_img` VARCHAR(45) NULL COMMENT 'ruta de la imagen firma',
  `email` VARCHAR(50) NULL COMMENT 'direccion de correo electronico',
  `padre` VARCHAR(45) NULL COMMENT 'Nombre Padre',
  `madre` VARCHAR(45) NULL COMMENT 'Nombre Madre',
  `conyuge` VARCHAR(45) NULL COMMENT 'Nombre del conyuge, si es que tiene',
  `hijos` VARCHAR(45) NULL COMMENT 'Nombre de hijo(s), en caso de tenerlos',
  `num_acta` INT NULL,
  `num_libro` INT NULL,
  `num_foja` INT NULL,
  `num_smn` INT NULL,
  `ano_clase` INT NULL,
  `pais` VARCHAR(30) NULL COMMENT 'Pais de procedencia',
  `pasaporte` VARCHAR(40) NULL COMMENT 'No de pasaporte',
  `inicio_vigencia` DATE NULL,
  `termino_vigencia` DATE NULL,
  `entrada_salida` CHAR(1) NULL,
  `observaciones` VARCHAR(250) NULL COMMENT 'Anotaciones sombre el empleado',
  `area_academica` CHAR(6) NULL COMMENT 'Area academica en la que desempeña',
  `tipo_personal` CHAR(1) NULL COMMENT 'tipo de personal que es\nC = completo\nP = parcial\nT = temporal',
  `tipo_control` CHAR(1) NULL,
  `rfc2` CHAR(13) NULL COMMENT 'rfc de facturacion empresa',
  `siglas` CHAR(5) NULL COMMENT 'Siglas de los nombres',
  `estudios_l` VARCHAR(100) NULL,
  `estudios_m` VARCHAR(100) NULL,
  `estudios_d` VARCHAR(100) NULL,
  `titulado_lic` CHAR(1) NULL COMMENT 's = si \nn = no\n',
  `titulado_mae` CHAR(1) NULL COMMENT 's = si \nn = no',
  `titulado_doc` CHAR(1) NULL COMMENT 's = si \nn = no',
  `tutores_rfc` CHAR(13) NOT NULL,
  PRIMARY KEY (`rfc`),
  INDEX `fk_Personal_tutores1_idx` (`tutores_rfc` ASC),
  CONSTRAINT `fk_Personal_tutores1`
    FOREIGN KEY (`tutores_rfc`)
    REFERENCES `dbtec`.`Tutor` (`rfc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Contiene todos los datos de un empleado';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
