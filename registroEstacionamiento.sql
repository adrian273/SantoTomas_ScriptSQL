--------------------------------------------------------
-- @author: Adrian Verdugo
-- @version: 1.0
-- @description: Registro de Estacionamientos
--------------------------------------------------------

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
  PRIMARY KEY (idSector))



-- -----------------------------------------------------
-- Table facultades
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS facultades (
  idFacultad INT NOT NULL,
  nombreFacultad VARCHAR(45) NULL,
  PRIMARY KEY (idFacultad))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table estacionamientos
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
    REFERENCES sectores (idSector)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_estacionamientos_sedes1
    FOREIGN KEY (sedes_idSede)
    REFERENCES sedes (idSede)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_estacionamientos_facultades1
    FOREIGN KEY (facultades_idFacultad)
    REFERENCES facultades (idFacultad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table estadoUno
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estadoUno (
  idEstadoUno INT NOT NULL,
  descripcionEstadoUno VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEstadoUno))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table estadoDos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estadoDos (
  idEstadoDos INT NOT NULL,
  descripcionEstadoDos VARCHAR(45) NULL,
  PRIMARY KEY (idEstadoDos))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table cupos
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
    REFERENCES estadoUno (idEstadoUno)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cupos_estadoDos1
    FOREIGN KEY (estadoDos_idEstadoDos)
    REFERENCES estadoDos (idEstadoDos)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cupos_estacionamientos1
    FOREIGN KEY (estacionamientos_idEstacionamiento)
    REFERENCES estacionamientos (idEstacionamiento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table registro
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
    REFERENCES cupos (idCupo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_registro_vehiculos1
    FOREIGN KEY (vehiculos_patenteVehiculo)
    REFERENCES vehiculos (patenteVehiculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table departamentos
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table carreras
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table alumnos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS alumnos (
  rutAlumno VARCHAR(15) NOT NULL,
  nombresAlumno VARCHAR(100) NOT NULL,
  apellidoPaternoAlumno VARCHAR(45) NOT NULL,
  apellidoMaternoAlumno VARCHAR(45) NOT NULL,
  telefonoAlumno INT NOT NULL,
  emailAlumno VARCHAR(100) NOT NULL,
  PRIMARY KEY (rutAlumno))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table registroTiempoCarreraAlumno
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS registroTiempoCarreraAlumno (
  idRegistroTiempoCarreraAlumno INT NOT NULL,
  fechaInicioRegistroTiempoCarreraAlumno DATETIME NULL,
  fechaFinalRegistroTiempoCarreraAlumno VARCHAR(45) NULL,
  carreras_idCarrera INT NOT NULL,
  alumnos_rutAlumno INT NOT NULL,
  PRIMARY KEY (idRegistroTiempoCarreraAlumno, carreras_idCarrera, alumnos_rutAlumno),
  INDEX fk_registroTiempoCarreraAlumno_carreras1_idx (carreras_idCarrera ASC),
  INDEX fk_registroTiempoCarreraAlumno_alumnos1_idx (alumnos_rutAlumno ASC),
  CONSTRAINT fk_registroTiempoCarreraAlumno_carreras1
    FOREIGN KEY (carreras_idCarrera)
    REFERENCES carreras (idCarrera)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_registroTiempoCarreraAlumno_alumnos1
    FOREIGN KEY (alumnos_rutAlumno)
    REFERENCES alumnos (rutAlumno)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table visitas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS visitas (
  rutVisita VARCHAR(15) NOT NULL,
  nombresVisita VARCHAR(45) NOT NULL,
  apellidoPaternoVisita VARCHAR(45) NOT NULL,
  apellidoMaternoVisita VARCHAR(45) NOT NULL,
  telefonoVisita INT NULL,
  emailVisita VARCHAR(100) NULL,
  propositoVisita TEXT NULL,
  PRIMARY KEY (rutVisita))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table tipoTrabajador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipoTrabajador (
  idTipoTrabajador INT NOT NULL,
  descripcionTipoTrabajador VARCHAR(45) NOT NULL,
  PRIMARY KEY (idTipoTrabajador))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table trabajadores
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table vehiculos_has_alumnos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vehiculos_has_alumnos (
  alumnos_rutAlumno VARCHAR(15) NOT NULL,
  vehiculos_patenteVehiculo VARCHAR(6) NOT NULL,
  PRIMARY KEY (alumnos_rutAlumno, vehiculos_patenteVehiculo),
  INDEX fk_vehiculos_has_alumnos_alumnos1_idx (alumnos_rutAlumno ASC),
  INDEX fk_vehiculos_has_alumnos_vehiculos1_idx (vehiculos_patenteVehiculo ASC),
  CONSTRAINT fk_vehiculos_has_alumnos_alumnos1
    FOREIGN KEY (alumnos_rutAlumno)
    REFERENCES alumnos (rutAlumno)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_vehiculos_has_alumnos_vehiculos1
    FOREIGN KEY (vehiculos_patenteVehiculo)
    REFERENCES vehiculos (patenteVehiculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table vehiculos_has_trabajadores
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vehiculos_has_trabajadores (
  trabajadores_rutTrabajador VARCHAR(15) NOT NULL,
  vehiculos_patenteVehiculo VARCHAR(6) NOT NULL,
  PRIMARY KEY (trabajadores_rutTrabajador, vehiculos_patenteVehiculo),
  INDEX fk_vehiculos_has_trabajadores_trabajadores1_idx (trabajadores_rutTrabajador ASC),
  INDEX fk_vehiculos_has_trabajadores_vehiculos1_idx (vehiculos_patenteVehiculo ASC),
  CONSTRAINT fk_vehiculos_has_trabajadores_trabajadores1
    FOREIGN KEY (trabajadores_rutTrabajador)
    REFERENCES trabajadores (rutTrabajador)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_vehiculos_has_trabajadores_vehiculos1
    FOREIGN KEY (vehiculos_patenteVehiculo)
    REFERENCES vehiculos (patenteVehiculo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table modelos
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table colores
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS colores (
  idColor INT NOT NULL,
  nombreColor VARCHAR(45) NOT NULL,
  PRIMARY KEY (idColor))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table colores_has_modelos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS colores_has_modelos (
  colores_idColor INT NOT NULL,
  modelos_idModelo INT NOT NULL,
  PRIMARY KEY (colores_idColor, modelos_idModelo),
  INDEX fk_colores_has_modelos_modelos1_idx (modelos_idModelo ASC),
  INDEX fk_colores_has_modelos_colores1_idx (colores_idColor ASC),
  CONSTRAINT fk_colores_has_modelos_colores1
    FOREIGN KEY (colores_idColor)
    REFERENCES colores (idColor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_colores_has_modelos_modelos1
    FOREIGN KEY (modelos_idModelo)
    REFERENCES modelos (idModelo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table registroVisitas
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
  )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table registroAlumnos
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
    REFERENCES alumnos (rutAlumno)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_registroAlumnos_registro1
    FOREIGN KEY (registro_idRegistro)
    REFERENCES registro (idRegistro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
