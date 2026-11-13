INSERT INTO usuario (id_usuario, nombre, correo, contrasena)
VALUES
    ('USR01', 'Valeria Ortiz', 'valeria.ortiz@correo.com', 'hash_a91c02'),
    ('USR02', 'Marco Salazar', 'marco.salazar@correo.com', 'hash_b37d15'),
    ('USR03', 'Lucía Herrera', 'lucia.herrera@correo.com', 'hash_c46e88'),
    ('USR04', 'Andrés Cevallos', 'andres.cevallos@correo.com', 'hash_d52f31'),
    ('USR05', 'Paola Jaramillo', 'paola.jaramillo@correo.com', 'hash_e68a47');

INSERT INTO plan (id_plan, nombre_plan, precio, calidad_video)
VALUES
    ('PLN01', 'Básico', 4.99, 'SD'),
    ('PLN02', 'Estándar', 8.99, 'HD'),
    ('PLN03', 'Premium', 12.99, '4K');

INSERT INTO genero (id_genero, nombre_genero)
VALUES
    ('GEN01', 'Drama'),
    ('GEN02', 'Comedia'),
    ('GEN03', 'Misterio'),
    ('GEN04', 'Documental'),
    ('GEN05', 'Acción'),
    ('GEN06', 'Familiar');

INSERT INTO contenido (id_contenido, titulo, tipo, duracion, anio_estreno, clasificacion_edad)
VALUES
    ('CON01', 'La Ruta del Cóndor', 'Película', 112, 2024, '+12'),
    ('CON02', 'Noches en Quito', 'Serie', 45, 2023, '+16'),
    ('CON03', 'Misterio en la Mitad del Mundo', 'Serie', 50, 2025, '+12'),
    ('CON04', 'Planeta Andino', 'Documental', 90, 2022, 'Todos'),
    ('CON05', 'Risas en Familia', 'Serie', 25, 2021, 'Todos'),
    ('CON06', 'Código Rojo', 'Película', 128, 2025, '+16'),
    ('CON07', 'Cocina de Mi Tierra', 'Documental', 60, 2024, 'Todos'),
    ('CON08', 'El Último Verano', 'Película', 101, 2023, '+12');

INSERT INTO contenido_genero (id_contenido, id_genero)
VALUES
    ('CON01', 'GEN01'),
    ('CON01', 'GEN05'),
    ('CON02', 'GEN01'),
    ('CON02', 'GEN03'),
    ('CON03', 'GEN03'),
    ('CON04', 'GEN04'),
    ('CON05', 'GEN02'),
    ('CON05', 'GEN06'),
    ('CON06', 'GEN05'),
    ('CON06', 'GEN03'),
    ('CON07', 'GEN04'),
    ('CON07', 'GEN06'),
    ('CON08', 'GEN01');

INSERT INTO perfil (id_perfil, nombre_perfil, idioma, control_parental, id_usuario)
VALUES
    ('PRF01', 'Valeria', 'Español', FALSE, 'USR01'),
    ('PRF02', 'Niños', 'Español', TRUE, 'USR01'),
    ('PRF03', 'Marco', 'Español', FALSE, 'USR02'),
    ('PRF04', 'Lucía', 'Inglés', FALSE, 'USR03'),
    ('PRF05', 'Familia', 'Español', TRUE, 'USR03'),
    ('PRF06', 'Andrés', 'Español', FALSE, 'USR04'),
    ('PRF07', 'Paola', 'Español', FALSE, 'USR05'),
    ('PRF08', 'Invitado', 'Inglés', FALSE, 'USR05');

INSERT INTO suscripcion (id_suscripcion, fecha_inicio, fecha_fin, estado, id_usuario, id_plan)
VALUES
    ('SUS01', '2026-01-10', NULL, 'Activa', 'USR01', 'PLN02'),
    ('SUS02', '2025-11-05', '2026-02-05', 'Vencida', 'USR02', 'PLN01'),
    ('SUS03', '2026-02-01', NULL, 'Activa', 'USR03', 'PLN03'),
    ('SUS04', '2026-03-15', '2026-06-15', 'Cancelada', 'USR04', 'PLN02'),
    ('SUS05', '2026-04-20', NULL, 'Activa', 'USR05', 'PLN01');

-- El monto de cada pago coincide con el precio del plan
INSERT INTO pago (id_pago, fecha_pago, monto, metodo_pago, id_suscripcion)
VALUES
    ('PAG01', '2026-01-10', 8.99, 'Tarjeta', 'SUS01'),
    ('PAG02', '2026-02-10', 8.99, 'Tarjeta', 'SUS01'),
    ('PAG03', '2025-11-05', 4.99, 'PayPal', 'SUS02'),
    ('PAG04', '2025-12-05', 4.99, 'PayPal', 'SUS02'),
    ('PAG05', '2026-02-01', 12.99, 'Tarjeta', 'SUS03'),
    ('PAG06', '2026-03-15', 8.99, 'Transferencia', 'SUS04'),
    ('PAG07', '2026-04-15', 8.99, 'Transferencia', 'SUS04'),
    ('PAG08', '2026-04-20', 4.99, 'Tarjeta', 'SUS05');

INSERT INTO reproduccion (id_reproduccion, fecha_hora, progreso, estado, id_perfil, id_contenido)
VALUES
    ('REP01', '2026-01-11 20:30:00', 100, 'Terminado', 'PRF01', 'CON01'),
    ('REP02', '2026-01-12 21:00:00', 45, 'En curso', 'PRF01', 'CON02'),
    ('REP03', '2026-01-15 16:10:00', 100, 'Terminado', 'PRF02', 'CON05'),
    ('REP04', '2025-11-06 19:45:00', 100, 'Terminado', 'PRF03', 'CON06'),
    ('REP05', '2025-12-10 22:00:00', 70, 'En curso', 'PRF03', 'CON03'),
    ('REP06', '2026-02-03 20:15:00', 100, 'Terminado', 'PRF04', 'CON06'),
    ('REP07', '2026-02-10 18:30:00', 100, 'Terminado', 'PRF05', 'CON04'),
    ('REP08', '2026-03-20 21:40:00', 30, 'En curso', 'PRF06', 'CON08'),
    ('REP09', '2026-04-22 20:00:00', 100, 'Terminado', 'PRF07', 'CON07'),
    ('REP10', '2026-05-01 19:20:00', 60, 'En curso', 'PRF07', 'CON01'),
    ('REP11', '2026-05-05 23:05:00', 100, 'Terminado', 'PRF08', 'CON08'),
    ('REP12', '2026-05-06 17:00:00', 100, 'Terminado', 'PRF05', 'CON05');

-- Verificacion rapida de cantidades
SELECT 'usuario' AS tabla, COUNT(*) AS filas FROM usuario
UNION ALL SELECT 'perfil', COUNT(*) FROM perfil
UNION ALL SELECT 'plan', COUNT(*) FROM plan
UNION ALL SELECT 'suscripcion', COUNT(*) FROM suscripcion
UNION ALL SELECT 'pago', COUNT(*) FROM pago
UNION ALL SELECT 'contenido', COUNT(*) FROM contenido
UNION ALL SELECT 'genero', COUNT(*) FROM genero
UNION ALL SELECT 'contenido_genero', COUNT(*) FROM contenido_genero
UNION ALL SELECT 'reproduccion', COUNT(*) FROM reproduccion;
