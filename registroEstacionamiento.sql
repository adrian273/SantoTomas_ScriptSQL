-- ------------------------------------------------------
-- @author: Adrian Verdugo
-- @version: 1.0
-- @description: Registro de Estacionamientos
-- ------------------------------------------------------

-- -----------------------------------------------------
-- Table @marcas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS marcas (
  idMarca INT NOT NULL,
  nombreMarca VARCHAR(45) NULL,
  PRIMARY KEY (idMarca)
);

-- -----------------------------------------------------
-- Table @vehiculos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vehiculos (
  patenteVehiculo VARCHAR(6) NOT NULL,
  marcaVehiculo VARCHAR(45) NULL,
  modeloVehiculo VARCHAR(45) NULL,
  marcas_idMarca INT NOT NULL,
  PRIMARY KEY (patenteVehiculo, marcas_idMarca),
  INDEX fk_vehiculos_marcas1_idx (marcas_idMarca ASC),
  CONSTRAINT fk_vehiculos_marcas1
    FOREIGN KEY (marcas_idMarca)
    REFERENCES marcas (idMarca)
);

-- -----------------------------------------------------
-- Table @tipoDisponibilidad
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipoDisponibilidad (
  idTipoDisponibilidad INT NOT NULL,
  nombreTipoDisponibilidad VARCHAR(45) NOT NULL,
  descripcionTipoDisponibilidad VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoDisponibilidad)
);

-- -----------------------------------------------------
-- Table @regiones
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS regiones (
  idRegion INT NOT NULL,
  nombreRegion VARCHAR(45) NOT NULL,
  PRIMARY KEY (idRegion)
);

-- -----------------------------------------------------
-- Table @provincias
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS provincias (
  idProvincia INT NOT NULL,
  nombreProvincia VARCHAR(45) NULL,
  regiones_idRegion INT NOT NULL,
  PRIMARY KEY (idProvincia, regiones_idRegion),
  INDEX fk_provincias_regiones1_idx (regiones_idRegion ASC),
  CONSTRAINT fk_provincias_regiones1
    FOREIGN KEY (regiones_idRegion)
    REFERENCES regiones (idRegion)
);

-- -----------------------------------------------------
-- Table @comunas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS comunas (
  idComuna INT NOT NULL,
  comunascol VARCHAR(45) NULL,
  provincias_idProvincia INT NOT NULL,
  PRIMARY KEY (idComuna, provincias_idProvincia),
  INDEX fk_comunas_provincias1_idx (provincias_idProvincia ASC),
  CONSTRAINT fk_comunas_provincias1
    FOREIGN KEY (provincias_idProvincia)
    REFERENCES provincias (idProvincia)
);

-- -----------------------------------------------------
-- Table @sedes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS sedes (
  idSede INT NOT NULL,
  nombreSede VARCHAR(45) NOT NULL,
  direccionSede VARCHAR(100) NOT NULL,
  tipoDisponibilidad_idTipoDisponibilidad INT NOT NULL,
  comunas_idComuna INT NOT NULL,
  PRIMARY KEY (idSede, tipoDisponibilidad_idTipoDisponibilidad, comunas_idComuna),
  INDEX fk_sedes_tipoDisponibilidad1_idx (tipoDisponibilidad_idTipoDisponibilidad ASC),
  INDEX fk_sedes_comunas1_idx (comunas_idComuna ASC),
  CONSTRAINT fk_sedes_tipoDisponibilidad1
    FOREIGN KEY (tipoDisponibilidad_idTipoDisponibilidad)
    REFERENCES tipoDisponibilidad (idTipoDisponibilidad),
  CONSTRAINT fk_sedes_comunas1
    FOREIGN KEY (comunas_idComuna)
    REFERENCES comunas (idComuna)
);

-- -----------------------------------------------------
-- Table @sectores
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS sectores (
  idSector INT NOT NULL,
  nombreSector VARCHAR(45) NOT NULL,
  PRIMARY KEY (idSector)
);

-- -----------------------------------------------------
-- Table @facultades
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS facultades (
  idFacultad INT NOT NULL,
  nombreFacultad VARCHAR(45) NULL,
  PRIMARY KEY (idFacultad)
);

-- -----------------------------------------------------
-- Table @estacionamientos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estacionamientos (
  idEstacionamiento INT NOT NULL,
  nombreFantasiaEstacionamiento VARCHAR(45) NULL,
  direccionEstacionamiento VARCHAR(100) NULL,
  sectores_idSector INT NOT NULL,
  sedes_idSede INT NOT NULL,
  facultades_idFacultad INT NOT NULL,
  PRIMARY KEY (idEstacionamiento, sectores_idSector, sedes_idSede, facultades_idFacultad),
  INDEX fk_estacionamientos_sectores_idx (sectores_idSector ASC),
  INDEX fk_estacionamientos_sedes1_idx (sedes_idSede ASC),
  INDEX fk_estacionamientos_facultades1_idx (facultades_idFacultad ASC),
  CONSTRAINT fk_estacionamientos_sectores
    FOREIGN KEY (sectores_idSector)
    REFERENCES sectores (idSector),
  CONSTRAINT fk_estacionamientos_sedes1
    FOREIGN KEY (sedes_idSede)
    REFERENCES sedes (idSede),
  CONSTRAINT fk_estacionamientos_facultades1
    FOREIGN KEY (facultades_idFacultad)
    REFERENCES facultades (idFacultad)
);

-- -----------------------------------------------------
-- Table @estadoUno
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estadoUno (
  idEstadoUno INT NOT NULL,
  descripcionEstadoUno VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEstadoUno)
);

-- -----------------------------------------------------
-- Table @estadoDos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estadoDos (
  idEstadoDos INT NOT NULL,
  descripcionEstadoDos VARCHAR(45) NULL,
  PRIMARY KEY (idEstadoDos)
);

-- -----------------------------------------------------
-- Table @cupos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cupos (
  idCupo INT NOT NULL,
  estadoUno_idEstadoUno INT NOT NULL,
  estadoDos_idEstadoDos INT NOT NULL,
  estacionamientos_idEstacionamiento INT NOT NULL,
  PRIMARY KEY (idCupo, estadoUno_idEstadoUno, estadoDos_idEstadoDos, estacionamientos_idEstacionamiento),
  INDEX fk_cupos_estadoUno1_idx (estadoUno_idEstadoUno ASC),
  INDEX fk_cupos_estadoDos1_idx (estadoDos_idEstadoDos ASC),
  INDEX fk_cupos_estacionamientos1_idx (estacionamientos_idEstacionamiento ASC),
  CONSTRAINT fk_cupos_estadoUno1
    FOREIGN KEY (estadoUno_idEstadoUno)
    REFERENCES estadoUno (idEstadoUno),
  CONSTRAINT fk_cupos_estadoDos1
    FOREIGN KEY (estadoDos_idEstadoDos)
    REFERENCES estadoDos (idEstadoDos),
  CONSTRAINT fk_cupos_estacionamientos1
    FOREIGN KEY (estacionamientos_idEstacionamiento)
    REFERENCES estacionamientos (idEstacionamiento)
);

-- -----------------------------------------------------
-- Table @registro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS registro (
  idRegistro INT NOT NULL,
  fechaLLegada DATETIME NOT NULL,
  horaSalida DATETIME NOT NULL,
  estadoVehiculo VARCHAR(500) NULL,
  cupos_idCupo INT NOT NULL,
  vehiculos_patenteVehiculo VARCHAR(6) NOT NULL,
  PRIMARY KEY (idRegistro, cupos_idCupo, vehiculos_patenteVehiculo),
  INDEX fk_registro_cupos1_idx (cupos_idCupo ASC),
  INDEX fk_registro_vehiculos1_idx (vehiculos_patenteVehiculo ASC),
  CONSTRAINT fk_registro_cupos1
    FOREIGN KEY (cupos_idCupo)
    REFERENCES cupos (idCupo),
  CONSTRAINT fk_registro_vehiculos1
    FOREIGN KEY (vehiculos_patenteVehiculo)
    REFERENCES vehiculos (patenteVehiculo)
);

-- -----------------------------------------------------
-- Table @departamentos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS departamentos (
  idDepartamento INT NOT NULL,
  nombreDepartamento VARCHAR(45) NULL,
  descripcionDepartamento VARCHAR(45) NULL,
  facultades_idFacultad INT NOT NULL,
  PRIMARY KEY (idDepartamento, facultades_idFacultad),
  INDEX fk_departamentos_facultades1_idx (facultades_idFacultad ASC),
  CONSTRAINT fk_departamentos_facultades1
    FOREIGN KEY (facultades_idFacultad)
    REFERENCES facultades (idFacultad)
);

-- -----------------------------------------------------
-- Table @carreras
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS carreras (
  idCarrera INT NOT NULL,
  nombreCarrera VARCHAR(45) NOT NULL,
  descripcionCarrera VARCHAR(500) NULL,
  facultades_idFacultad INT NOT NULL,
  PRIMARY KEY (idCarrera, facultades_idFacultad),
  INDEX fk_carreras_facultades1_idx (facultades_idFacultad ASC),
  CONSTRAINT fk_carreras_facultades1
    FOREIGN KEY (facultades_idFacultad)
    REFERENCES facultades (idFacultad)
);

--  -----------------------------------------------------
--  @info: nuevas tablas agregadas
--  Tables: @sexos - @rangosEtarios
--  @since: 15-12-2017
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS sexos (
  idSexo CHAR(1) not null,
  nombreSexo VARCHAR(45),
  PRIMARY KEY(idSexo)
);

CREATE TABLE IF NOT EXISTS rangosEtarios (
  idRangoEtario INT NOT NULL,
  rangoEtario VARCHAR(45) NOT NULL,
  PRIMARY KEY(idRangoEtario)
);

-- -----------------------------------------------------
-- Table @alumnos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS alumnos (
  rutAlumno VARCHAR(15) NOT NULL,
  nombresAlumno VARCHAR(100) NOT NULL,
  apellidoPaternoAlumno VARCHAR(45) NOT NULL,
  apellidoMaternoAlumno VARCHAR(45) NOT NULL,
  telefonoAlumno INT NOT NULL,
  emailAlumno VARCHAR(100) NOT NULL,
  PRIMARY KEY (rutAlumno)
);

-- ------------------------------------------------------
-- @info nuevas columnas agregadas en la tabla alumno (sexo, rango etario)
-- ------------------------------------------------------
ALTER TABLE alumnos ADD COLUMN sexos_idSexo CHAR(1) NOT NULL;
ALTER TABLE alumnos ADD COLUMN rangosEtarios_idRangoEtario INT NOT NULL;

-- Reference table @sexos
ALTER TABLE alumnos ADD CONSTRAINT fk_sexos_idSexo FOREIGN KEY (sexos_idSexo) REFERENCES sexos(idSexo);
-- Reference table @rangosEtarios
ALTER TABLE alumnos ADD CONSTRAINT fk_rangosEtarios_idRangoEtario FOREIGN KEY (rangosEtarios_idRangoEtario) REFERENCES rangosEtarios (idRangoEtario);

-- -----------------------------------------------------
-- Table @registroTiempoCarreraAlumno
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS registroTiempoCarreraAlumno (
  idRegistroTiempoCarreraAlumno INT NOT NULL,
  fechaInicioRegistroTiempoCarreraAlumno DATETIME NULL,
  fechaFinalRegistroTiempoCarreraAlumno VARCHAR(45) NULL,
  carreras_idCarrera INT NOT NULL,
  alumnos_rutAlumno VARCHAR(15) NOT NULL,
  PRIMARY KEY (idRegistroTiempoCarreraAlumno, carreras_idCarrera, alumnos_rutAlumno),
  INDEX fk_registroTiempoCarreraAlumno_carreras1_idx (carreras_idCarrera ASC),
  INDEX fk_registroTiempoCarreraAlumno_alumnos1_idx (alumnos_rutAlumno ASC),
  CONSTRAINT fk_registroTiempoCarreraAlumno_carreras1
    FOREIGN KEY (carreras_idCarrera)
    REFERENCES carreras (idCarrera),
  CONSTRAINT fk_registroTiempoCarreraAlumno_alumnos1
    FOREIGN KEY (alumnos_rutAlumno)
    REFERENCES alumnos (rutAlumno)
);

-- -----------------------------------------------------
-- Table @visitas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS visitas (
  rutVisita VARCHAR(15) NOT NULL,
  nombresVisita VARCHAR(45) NOT NULL,
  apellidoPaternoVisita VARCHAR(45) NOT NULL,
  apellidoMaternoVisita VARCHAR(45) NOT NULL,
  telefonoVisita INT NULL,
  emailVisita VARCHAR(100) NULL,
  propositoVisita TEXT NULL,
  PRIMARY KEY (rutVisita)
);

--  -----------------------------------------------------
--  @info: nuevas tablas agregadas
--  Tables: @afps - @sistemasDeSalud
--  @since: 15-12-2017
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS afps (
  idAfp INT not null,
  nombreAfp VARCHAR(45) not null,
  PRIMARY KEY(idAfp)
);

CREATE TABLE IF NOT EXISTS sistemasDeSalud (
  idSistemaSalud INT NOT NULL,
  nombreSistemaSalud VARCHAR(45) NOT NULL,
  PRIMARY KEY(idSistemaSalud)
);

-- -----------------------------------------------------
-- Table @tipoTrabajador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipoTrabajador (
  idTipoTrabajador INT NOT NULL,
  descripcionTipoTrabajador VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoTrabajador)
);

-- -----------------------------------------------------
-- Table @trabajadores
-- @Info: Tabla de los trabajadores de la institucion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabajadores (
  rutTrabajador VARCHAR(15) NOT NULL,
  nombresTrabajador VARCHAR(45) NULL,
  apellidoPaternoTrabajador VARCHAR(45) NULL,
  apellidoMaternoTrabajador VARCHAR(45) NULL,
  telefonoTrabajador INT NULL,
  emailTrabajador VARCHAR(100) NULL,
  tipoTrabajador_idTipoTrabajador INT NOT NULL,
  PRIMARY KEY (rutTrabajador, tipoTrabajador_idTipoTrabajador),
  INDEX fk_trabajadores_tipoTrabajador1_idx (tipoTrabajador_idTipoTrabajador ASC),
  CONSTRAINT fk_trabajadores_tipoTrabajador1
    FOREIGN KEY (tipoTrabajador_idTipoTrabajador)
    REFERENCES tipoTrabajador (idTipoTrabajador)
);

-- ------------------------------------------------------
-- @info nuevas columnas agregadas en la tabla trabajadores (sexo, rango etario)
-- @since: 15-12-2017
-- ------------------------------------------------------
ALTER TABLE trabajadores ADD COLUMN sexos_idSexo CHAR(1) NOT NULL;
ALTER TABLE trabajadores ADD COLUMN rangosEtarios_idRangoEtario INT NOT NULL;

-- Reference table @sexos
ALTER TABLE trabajadores ADD CONSTRAINT fk_sexos_idSexo_trabajadores FOREIGN KEY (sexos_idSexo) REFERENCES sexos(idSexo);
-- Reference table @rangosEtarios
ALTER TABLE trabajadores ADD CONSTRAINT fk_rangosEtarios_idRangoEtario_trabajadores FOREIGN KEY (rangosEtarios_idRangoEtario) REFERENCES rangosEtarios (idRangoEtario);

-- -------------------------------------------------------------
-- @info: nuevas referencias (FK) en la tabla trabajadores Y modificacion en la tabla
-- -------------------------------------------------------------
ALTER TABLE trabajadores ADD COLUMN afps_idAfp INT NOT NULL;
ALTER TABLE trabajadores ADD COLUMN sistemasDeSalud_idSistemaDeSalud INT NOT NULL;

-- Reference table @afps
ALTER TABLE trabajadores ADD CONSTRAINT fk_afps_idAfp FOREIGN KEY (afps_idAfp) REFERENCES afps(idAfp);
-- Reference table @sistemasDeSalud
ALTER TABLE trabajadores ADD CONSTRAINT fk_sistemasDeSalud_idSistemaDeSalud FOREIGN KEY (sistemasDeSalud_idSistemaDeSalud) REFERENCES sistemasDeSalud(idSistemaSalud);

-- -----------------------------------------------------
-- Table @vehiculos_has_alumnos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vehiculos_has_alumnos (
  alumnos_rutAlumno VARCHAR(15) NOT NULL,
  vehiculos_patenteVehiculo VARCHAR(6) NOT NULL,
  PRIMARY KEY (alumnos_rutAlumno, vehiculos_patenteVehiculo),
  INDEX fk_vehiculos_has_alumnos_alumnos1_idx (alumnos_rutAlumno ASC),
  INDEX fk_vehiculos_has_alumnos_vehiculos1_idx (vehiculos_patenteVehiculo ASC),
  CONSTRAINT fk_vehiculos_has_alumnos_alumnos1
    FOREIGN KEY (alumnos_rutAlumno)
    REFERENCES alumnos (rutAlumno),
  CONSTRAINT fk_vehiculos_has_alumnos_vehiculos1
    FOREIGN KEY (vehiculos_patenteVehiculo)
    REFERENCES vehiculos (patenteVehiculo)
);

-- -----------------------------------------------------
-- Table @vehiculos_has_trabajadores
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vehiculos_has_trabajadores (
  trabajadores_rutTrabajador VARCHAR(15) NOT NULL,
  vehiculos_patenteVehiculo VARCHAR(6) NOT NULL,
  PRIMARY KEY (trabajadores_rutTrabajador, vehiculos_patenteVehiculo),
  INDEX fk_vehiculos_has_trabajadores_trabajadores1_idx (trabajadores_rutTrabajador ASC),
  INDEX fk_vehiculos_has_trabajadores_vehiculos1_idx (vehiculos_patenteVehiculo ASC),
  CONSTRAINT fk_vehiculos_has_trabajadores_trabajadores1
    FOREIGN KEY (trabajadores_rutTrabajador)
    REFERENCES trabajadores (rutTrabajador),
  CONSTRAINT fk_vehiculos_has_trabajadores_vehiculos1
    FOREIGN KEY (vehiculos_patenteVehiculo)
    REFERENCES vehiculos (patenteVehiculo)
);

-- -----------------------------------------------------
-- Table @modelos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS modelos (
  idModelo INT NOT NULL,
  nombreModelo VARCHAR(45) NULL,
  marcas_idMarca INT NOT NULL,
  PRIMARY KEY (idModelo, marcas_idMarca),
  INDEX fk_modelos_marcas1_idx (marcas_idMarca ASC),
  CONSTRAINT fk_modelos_marcas1
    FOREIGN KEY (marcas_idMarca)
    REFERENCES marcas (idMarca)
);

-- -----------------------------------------------------
-- Table @colores
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS colores (
  idColor INT NOT NULL,
  nombreColor VARCHAR(45) NOT NULL,
  PRIMARY KEY (idColor)
);

-- -----------------------------------------------------
-- Table @colores_has_modelos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS colores_has_modelos (
  colores_idColor INT NOT NULL,
  modelos_idModelo INT NOT NULL,
  PRIMARY KEY (colores_idColor, modelos_idModelo),
  INDEX fk_colores_has_modelos_modelos1_idx (modelos_idModelo ASC),
  INDEX fk_colores_has_modelos_colores1_idx (colores_idColor ASC),
  CONSTRAINT fk_colores_has_modelos_colores1
    FOREIGN KEY (colores_idColor)
    REFERENCES colores (idColor),
  CONSTRAINT fk_colores_has_modelos_modelos1
    FOREIGN KEY (modelos_idModelo)
    REFERENCES modelos (idModelo)
);

-- -----------------------------------------------------
-- Table @registroVisitas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS registroVisitas (
  idRegistroVisitas INT NOT NULL,
  visitas_rutVisita VARCHAR(15) NOT NULL,
  registro_idRegistro INT NOT NULL,
  PRIMARY KEY (idRegistroVisitas, visitas_rutVisita, registro_idRegistro),
  INDEX fk_registroVisitas_visitas1_idx (visitas_rutVisita ASC),
  INDEX fk_registroVisitas_registro1_idx (registro_idRegistro ASC),
  CONSTRAINT fk_registroVisitas_visitas1
    FOREIGN KEY (visitas_rutVisita)
    REFERENCES visitas (rutVisita),
  CONSTRAINT fk_registroVisitas_registro1
    FOREIGN KEY (registro_idRegistro)
    REFERENCES registro (idRegistro)
);

-- -----------------------------------------------------
-- Table @registroAlumnos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS registroAlumnos (
  idRegistroAlumno INT NOT NULL,
  alumnos_rutAlumno VARCHAR(15) NOT NULL,
  registro_idRegistro INT NOT NULL,
  PRIMARY KEY (idRegistroAlumno, alumnos_rutAlumno, registro_idRegistro),
  INDEX fk_registroAlumnos_alumnos1_idx (alumnos_rutAlumno ASC),
  INDEX fk_registroAlumnos_registro1_idx (registro_idRegistro ASC),
  CONSTRAINT fk_registroAlumnos_alumnos1
    FOREIGN KEY (alumnos_rutAlumno)
    REFERENCES alumnos (rutAlumno),
  CONSTRAINT fk_registroAlumnos_registro1
    FOREIGN KEY (registro_idRegistro)
    REFERENCES registro (idRegistro)
);

-- -----------------------------------------------------
-- Table @trabajadorRegistros
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS trabajadorRegistros (
  idRegistroTrabajador INT NOT NULL,
  trabajadores_rutTrabajador VARCHAR(15) NOT NULL,
  registro_idRegistro INT NOT NULL,
  PRIMARY KEY (idRegistroTrabajador, trabajadores_rutTrabajador, registro_idRegistro),
  INDEX fk_trabajadorRegistros_registro1_idx (registro_idRegistro ASC),
  CONSTRAINT fk_trabajadorRegistros_trabajadores1
    FOREIGN KEY (trabajadores_rutTrabajador)
    REFERENCES trabajadores (rutTrabajador),
  CONSTRAINT fk_trabajadorRegistros_registro1
    FOREIGN KEY (registro_idRegistro)
    REFERENCES registro (idRegistro)
);

-- ---------------------------------------------------------
-- @insert
-- Table @sexos
-- ---------------------------------------------------------
INSERT INTO sexos (idSexo, nombreSexo) VALUES ('f', 'femenino');
INSERT INTO sexos (idSexo, nombreSexo) VALUES ('m', 'masculino');

-- ---------------------------------------------------------
-- @insert
-- Table @rangosEtarios
-- ---------------------------------------------------------
INSERT INTO rangosEtarios (idRangoEtario, rangoEtario) VALUES ('1', '1-10');
INSERT INTO rangosEtarios (idRangoEtario, rangoEtario) VALUES ('2', '11-20');
INSERT INTO rangosEtarios (idRangoEtario, rangoEtario) VALUES ('3', '21-30');

-- ---------------------------------------------------------
-- @insert
-- Table @alumnos
-- ---------------------------------------------------------
INSERT INTO alumnos (rutAlumno, nombresAlumno, apellidoPaternoAlumno, apellidoMaternoAlumno, telefonoAlumno, emailAlumno, sexos_idSexo, rangosEtarios_idRangoEtario) VALUES ('191111112', 'catalina', 'n', 'p', '55555555', 'cata@gmail.com', 'f', 2
);

INSERT INTO alumnos (rutAlumno, nombresAlumno, apellidoPaternoAlumno, apellidoMaternoAlumno, telefonoAlumno, emailAlumno, sexos_idSexo, rangosEtarios_idRangoEtario) VALUES ('188915051', 'adrian', 'v', 'p', '1888961', 'adrian@gmail.com', 'm', 3
);
-- ------------------------------------------------------------
-- @insert
-- Table @facultad
-- ------------------------------------------------------------
INSERT INTO facultades (idFacultad, nombreFacultad) VALUES ('1', 'informatica');

-- ------------------------------------------------------------
-- @insert
-- Table @carreras
-- ------------------------------------------------------------
INSERT INTO carreras (idCarrera, nombreCarrera, descripcionCarrera, facultades_idFacultad) VALUES ('1', 'programacion computacional', 'desarrollo de software', '1');

-- ------------------------------------------------------------
-- @insert
-- Table @registroTiempoCarreraAlumno
-- ------------------------------------------------------------
INSERT INTO registroTiempoCarreraAlumno (idRegistroTiempoCarreraAlumno, fechaInicioRegistroTiempoCarreraAlumno, fechaFinalRegistroTiempoCarreraAlumno, carreras_idCarrera, alumnos_rutAlumno) VALUES ('1', '2017-12-14 16:31:36', '2018-12-14 16:31:36', '1', '188915051');

-- --------------------------------------------------------------
-- @insert
-- Table @regiones
-- --------------------------------------------------------------
INSERT INTO regiones (idRegion, nombreRegion) VALUES ('7', 'Maule');

-- --------------------------------------------------------------
-- @insert
-- Table @provincias
-- --------------------------------------------------------------
INSERT INTO provincias (idProvincia, nombreProvincia, regiones_idRegion) VALUES ('1', 'Talca', '7');

-- --------------------------------------------------------------
-- @insert
-- Table @comunas
-- --------------------------------------------------------------
INSERT INTO comunas (idComuna, comunascol, provincias_idProvincia) VALUES ('1', 'Maule', '1');

-- @insert trabajador
INSERT INTO tipoTrabajador (idTipoTrabajador, descripcionTipoTrabajador) VALUES ('1', 'docente');
INSERT INTO tipoTrabajador (idTipoTrabajador, descripcionTipoTrabajador) VALUES ('2', 'funcionario');

INSERT INTO afps (idAfp, nombreAfp) VALUES ('1', 'MODELO');
INSERT INTO sistemasDeSalud (idSistemaSalud, nombreSistemaSalud) VALUES ('1', 'a');

INSERT INTO trabajadores (rutTrabajador, nombresTrabajador, apellidoPaternoTrabajador, apellidoMaternoTrabajador, telefonoTrabajador, emailTrabajador, tipoTrabajador_idTipoTrabajador, afps_idAfp, sistemasDeSalud_idSistemaDeSalud, sexos_idSexo, rangosEtarios_idRangoEtario) VALUES ('12', 'juanito', 'peres', 'ROJAS', '121', 'jua@tets.cl', '1', '1', '1', 'M', '2');

INSERT INTO trabajadores (rutTrabajador, nombresTrabajador, apellidoPaternoTrabajador, apellidoMaternoTrabajador, telefonoTrabajador, emailTrabajador, tipoTrabajador_idTipoTrabajador, afps_idAfp, sistemasDeSalud_idSistemaDeSalud, sexos_idSexo, rangosEtarios_idRangoEtario) VALUES ('13', 'andes', 'klaa', 'aaaa', '12', 'asd@aaa.cl', '2', '1', '1', 'M', '2');

INSERT INTO redesSocialesTrabajadores (redSocialFacebook, redSocialTwiter, trabajadores_rutTrabajador) VALUES ('ggds', 'twe', '12');

INSERT INTO redesSocialesTrabajadores (redSocialFacebook, redSocialTwiter, trabajadores_rutTrabajador) VALUES ('etsew', 'ete', '13');
