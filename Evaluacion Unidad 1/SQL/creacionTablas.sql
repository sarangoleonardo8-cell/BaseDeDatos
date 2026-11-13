CREATE DATABASE IF NOT EXISTS streaming_db
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE streaming_db;

-- ---------------------------
-- 1. CREACION DE TABLAS (DDL)
-- ---------------------------

CREATE TABLE usuario (
    id_usuario  VARCHAR(10)  NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    correo      VARCHAR(120) NOT NULL UNIQUE,
    contrasena  VARCHAR(255) NOT NULL,          -- se guarda el hash, no la clave
    PRIMARY KEY (id_usuario)
);

CREATE TABLE perfil (
    id_perfil         VARCHAR(10) NOT NULL,
    nombre_perfil     VARCHAR(50) NOT NULL,
    idioma            VARCHAR(30) NOT NULL DEFAULT 'Español',
    control_parental  BOOLEAN     NOT NULL DEFAULT FALSE,
    id_usuario        VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_perfil),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE plan (
    id_plan        VARCHAR(10)  NOT NULL,
    nombre_plan    VARCHAR(50)  NOT NULL UNIQUE,
    precio         DECIMAL(6,2) NOT NULL,
    calidad_video  VARCHAR(10)  NOT NULL,
    PRIMARY KEY (id_plan),
    CHECK (precio >= 0),
    CHECK (calidad_video IN ('SD', 'HD', '4K'))
);

CREATE TABLE suscripcion (
    id_suscripcion  VARCHAR(10) NOT NULL,
    fecha_inicio    DATE        NOT NULL,
    fecha_fin       DATE,                         -- NULL = sin fecha de fin
    estado          VARCHAR(15) NOT NULL DEFAULT 'Activa',
    id_usuario      VARCHAR(10) NOT NULL,
    id_plan         VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_suscripcion),
    CHECK (estado IN ('Activa', 'Vencida', 'Cancelada')),
    CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_plan)    REFERENCES plan(id_plan)
);

CREATE TABLE pago (
    id_pago         VARCHAR(10)  NOT NULL,
    fecha_pago      DATE         NOT NULL,
    monto           DECIMAL(8,2) NOT NULL,
    metodo_pago     VARCHAR(30)  NOT NULL,
    id_suscripcion  VARCHAR(10)  NOT NULL,
    PRIMARY KEY (id_pago),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('Tarjeta', 'PayPal', 'Transferencia')),
    FOREIGN KEY (id_suscripcion) REFERENCES suscripcion(id_suscripcion)
);

CREATE TABLE contenido (
    id_contenido       VARCHAR(10)  NOT NULL,
    titulo             VARCHAR(150) NOT NULL,
    tipo               VARCHAR(15)  NOT NULL,
    duracion           INT          NOT NULL,     -- minutos (por episodio en series)
    anio_estreno       SMALLINT     NOT NULL,
    clasificacion_edad VARCHAR(10)  NOT NULL DEFAULT 'Todos',
    PRIMARY KEY (id_contenido),
    CHECK (tipo IN ('Película', 'Serie', 'Documental')),
    CHECK (duracion > 0),
    CHECK (anio_estreno >= 1900)
);

CREATE TABLE genero (
    id_genero      VARCHAR(10) NOT NULL,
    nombre_genero  VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id_genero)
);

-- Tabla intermedia de la relacion muchos a muchos contenido - genero
CREATE TABLE contenido_genero (
    id_contenido  VARCHAR(10) NOT NULL,
    id_genero     VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_contenido, id_genero),
    FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE,
    FOREIGN KEY (id_genero)    REFERENCES genero(id_genero)       ON DELETE CASCADE
);

CREATE TABLE reproduccion (
    id_reproduccion  VARCHAR(10) NOT NULL,
    fecha_hora       DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    progreso         TINYINT     NOT NULL DEFAULT 0,   -- porcentaje visto (0-100)
    estado           VARCHAR(15) NOT NULL DEFAULT 'En curso',
    id_perfil        VARCHAR(10) NOT NULL,
    id_contenido     VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_reproduccion),
    CHECK (progreso BETWEEN 0 AND 100),
    CHECK (estado IN ('En curso', 'Terminado')),
    FOREIGN KEY (id_perfil)    REFERENCES perfil(id_perfil),
    FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido)
);
