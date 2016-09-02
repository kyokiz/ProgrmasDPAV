CREATE DATABASE ProgramasDPAV; -- drop database ProgramasDPAV;
USE ProgramasDPAV;

CREATE TABLE PERFILES( -- Tabla de perfiles
	PerfilId INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de Perfil
    vchPerfil VARCHAR(100) NOT NULL, -- Nombre o descripción del perfil
	bitUsuarios BIT, -- Permite habilitar o deshabilitar el módulo de usuarios
    bitUnidadAcademica BIT, -- Permite habilitar o deshabilitar el módulo de Unidad Acádemica
    bitCoordinador BIT, -- Permite habilitar o deshabilitar el módulo de Coordinador
    bitDiplomado BIT, -- Permite habilitar o deshabilitar el módulo de Diplomado
	bitEspecialidad BIT -- Permite habilitar o deshabilitar el módulo de Especialidad
);
INSERT INTO PERFILES (vchPerfil, bitUsuarios, bitEquipos, bitEmpleados, bitReportes, bitBajas) 
VALUES('ADMINISTRADOR DE SISTEMA',1,1,1,1,1);
INSERT INTO PERFILES (vchPerfil, bitUsuarios, bitEquipos, bitEmpleados, bitReportes, bitBajas)
VALUES('ADMINISTRADOR DE REGISTROS',0,1,1,1,1); 
CREATE TABLE USUARIOS( -- Tabla de usuarios
	UsuarioId INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de usuario
    vchUsuario VARCHAR(100) NOT NULL, -- Usuario
    vchPassword VARCHAR(100) NOT NULL, -- Contraseña 
    vchNombreCompleto VARCHAR(100) NOT NULL, -- Nombre del usuario
    vchCorreoElectronico VARCHAR(100) NOT NULL, -- Correo electrónico
    PerfilId INT NOT NULL, -- Perfil del usuario
    bitActivo BIT NOT NULL, -- Permite activar o desactivar un usuario
    FOREIGN KEY (PerfilId) REFERENCES PERFILES(PerfilId) -- Referencia a la tabla de perfiles para el perfil de usuario
);
INSERT INTO USUARIOS(vchUsuario, vchPassword, vchNombreCompleto, vchCorreoElectronico, PerfilId, bitActivo) VALUES ('ixchel', 'guac870219', 'CLAUDIA IXCHEL GUERRERO ANGELES', 'cguerreroa@ipn.mx', 1,1);
CREATE TABLE UNIDAD_ACADEMICA( -- Catálogo de unidades académicas
	UnidadAcademicaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de unidad académica
    vchNombre VARCHAR(100) NOT NULL, -- Nombre de la unidad académica
    bitTipoUnidad BIT NOT NULL, -- Tipo de unidad acádemica (centro, escuela)
	vchNombreDirector VARCHAR(100) NOT NULL, -- Nombre del director de centro o jefe de sepi
	intExtension INT NOT NULL -- Extensión de director de centro o jefe de sepi
);
CREATE TABLE COORDINADORES( -- Tabla para almacenar a los coordinadores
	CoordinadorID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de coordinador
    vchNombreCompleto VARCHAR(100) NOT NULL, -- Nombre completo del coordinador
	UnidadAcademicaID INT NOT NULL, -- Identificador de unidad académica
    FOREIGN KEY (UnidadAcademicaID) REFERENCES UNIDAD_ACADEMICA(UnidadAcademicaID), -- Referencia a la unidad académica con respecto a la tabla de unidades académicas
    intExtension INT NOT NULL, -- Extension del coordinador de programa
    datFechaRegistroS DATETIME NOT NULL, -- Permite auditar la fecha de la última modificación
    UsuarioID INT NOT NULL, -- Permite auditar el usuario que hizo la última modificación
    FOREIGN KEY (UsuarioID) REFERENCES USUARIOS(UsuarioID) -- Referencia del usuario auditado con respecto a la tabla de usuarios
);
CREATE TABLE DIPLOMADO( -- Tabla para almacenar e inventariar diplomados
	DiplomadoID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de diplomado
    vchDiplomado VARCHAR(100) NOT NULL, -- Nombre del diplomado
    UnidadAcademicaID INT NOT NULL, -- Identificador de unidad académica
    FOREIGN KEY (UnidadAcademicaID) REFERENCES UNIDAD_ACADEMICA(UnidadAcademicaID), -- Referencia a la unidad académica con respecto a la tabla de unidades académicas
    CoordinadorID INT NOT NULL, -- Identificador de coordinador
    FOREIGN KEY (CoordinadorID) REFERENCES COORDINADORES(CoordinadorID), -- Referencia al coordinador con respecto a la tabla de coordinadores
	intHoras INT NOT NULL, -- Horas que dura el diplomado
	vchModalidad VARCHAR (15) NOT NULL, -- Modalidad no presencial o mixta
    bitActivo BIT NOT NULL, -- Permite saber si el diplomado esta en activo o no
	datFechaRegistroP DATE NOT NULL -- Fecha de registro oficial del diplomado
    datFechaRegistroS DATETIME NOT NULL, -- Permite auditar la fecha de la última modificación
    UsuarioID INT NOT NULL, -- Permite auditar el usuario que hizo la última modificación
    FOREIGN KEY (UsuarioID) REFERENCES USUARIOS(UsuarioID) -- Referencia del usuario auditado con respecto a la tabla de usuarios
);
CREATE TABLE VIGENCIA (
	VigenciaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de vigencia
	DiplomadoID INT NOT NULL, -- Identificador diplomado
	FOREIGN KEY (DiplomadoID) REFERENCES DIPLOMADO(DiplomadoID), -- Referencia al diplomado con respecto a la tabla de diplomado
	vchPerido VARCHAR (9), -- Periodo de actividad del diplomado
	datFechaRegistroS DATETIME NOT NULL, -- Permite auditar la fecha de la última modificación
	UsuarioID INT NOT NULL, -- Permite auditar el usuario que hizo la última modificación
    FOREIGN KEY (UsuarioID) REFERENCES USUARIOS(UsuarioID) -- Referencia del usuario auditado con respecto a la tabla de usuarios
	
);
CREATE TABLE CURSO_PROPOSITO_ESPECIFICO( -- Tabla para almacenar los cursos de proposito especifico
	CursoPropositoEspecificoID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador del curso
    vchNombre VARCHAR(50), -- Nombre del curso
	DiplomadoID INT NOT NULL, -- Identificador de diplomado
    FOREIGN KEY (DiplomadoID) REFERENCES DIPLOMADO(DiplomadoID), -- Referencia al diplomado con respecto a la tabla de diplomado
	intHoras INT NOT NULL, -- Horas que dura el diplomado
	vchCursoTeoricoPractico VARCHAR (16), -- Tipo de curso (teórico, práctico, teórico-práctico)
	vchModalidad VARCHAR (15) NOT NULL, -- Modalidad no presencial o mixta
	bitActivo BIT NOT NULL, -- Permite saber si el curso esta en activo o no
	datFechaRegistroS DATETIME NOT NULL, -- Permite auditar la fecha de la última modificación
	UsuarioID INT NOT NULL, -- Permite auditar el usuario que hizo la última modificación
    FOREIGN KEY (UsuarioID) REFERENCES USUARIOS(UsuarioID) -- Referencia del usuario auditado con respecto a la tabla de usuarios
);
CREATE TABLE ESPECIALIDAD( -- Tabla para almacenar e inventariar especialidad
	EspecialidadID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de especialidad
    vchEspecialidad VARCHAR(100) NOT NULL, -- Nombre de la especialidad
    UnidadAcademicaID INT NOT NULL, -- Identificador de unidad académica
    FOREIGN KEY (UnidadAcademicaID) REFERENCES UNIDAD_ACADEMICA(UnidadAcademicaID), -- Referencia a la unidad académica con respecto a la tabla de unidades académicas
    CoordinadorID INT NOT NULL, -- Identificador de coordinador
    FOREIGN KEY (CoordinadorID) REFERENCES COORDINADORES(CoordinadorID), -- Referencia al coordinador con respecto a la tabla de coordinadores
	intHoras INT NOT NULL, -- Horas que dura el diplomado
	vchModalidad VARCHAR (15) NOT NULL, -- Modalidad no presencial o mixta
	datFechaRegistroE DATE NOT NULL -- Fecha de registro oficial de la especialidad
    datFechaRegistroS DATETIME NOT NULL, -- Permite auditar la fecha de la última modificación
    UsuarioID INT NOT NULL, -- Permite auditar el usuario que hizo la última modificación
    FOREIGN KEY (UsuarioID) REFERENCES USUARIOS(UsuarioID) -- Referencia del usuario auditado con respecto a la tabla de usuarios
);
CREATE TABLE ASIGNATURA( -- Tabla para almacenar las asignaturas de las especialidades
	AsignaturaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador de la asignatura
    vchNombre VARCHAR(50), -- Nombre de la asignatura
	EspecialidadID INT NOT NULL, -- Identificador de especialidad
    FOREIGN KEY (EspecialidadID) REFERENCES ESPECIALIDAD(EspecialidadID), -- Referencia a la especialidad con respecto a la tabla de especialidad
	intCreditos INT NOT NULL, -- Créditos de la asignatura
	intHoras INT NOT NULL, -- Horas a la semana de dureción de la asignatura
	vchCursoTeoricoPractico VARCHAR (16), -- Tipo de curso (teórico, práctico, teórico-práctico)
	vchModalidad VARCHAR (15) NOT NULL, -- Modalidad no presencial o mixta
	vchObligatoria VARCHAR(11) NOT NULL, -- Asignarura obligatoria u optativa
	bitActivo BIT NOT NULL, -- Permite saber si el curso esta en activo o no
	datFechaRegistroS DATETIME NOT NULL, -- Permite auditar la fecha de la última modificación
	UsuarioID INT NOT NULL, -- Permite auditar el usuario que hizo la última modificación
    FOREIGN KEY (UsuarioID) REFERENCES USUARIOS(UsuarioID) -- Referencia del usuario auditado con respecto a la tabla de usuarios
);
