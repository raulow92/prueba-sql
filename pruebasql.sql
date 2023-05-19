-- PRIMERA PARTE

-- 1
CREATE TABLE Peliculas (
  "id" Integer,
  "nombre" Varchar(255),
  "anno" Integer,
  PRIMARY KEY ("id")
);

CREATE TABLE Tags (
  "id" Integer,
  "tag" Varchar(32),
  PRIMARY KEY ("id")
);

CREATE TABLE PeliculasTags (
	"pelicula_id" Integer,
	"tag_id" Integer,
	FOREIGN KEY ("pelicula_id") REFERENCES Peliculas("id"),
	FOREIGN KEY ("tag_id") REFERENCES Tags("id")
);

SELECT * FROM Peliculas;
SELECT * FROM Tags;
SELECT * FROM PeliculasTags;

-- 2
INSERT INTO Peliculas VALUES (1, 'Star Wars: Episodio IV', 1977);
INSERT INTO Peliculas VALUES (2, 'Back to the Future', 1985);
INSERT INTO Peliculas VALUES (3, 'La Máscara', 1994);
INSERT INTO Peliculas VALUES (4, 'La forma del agua', 2017);
INSERT INTO Peliculas VALUES (5, 'Slumdog Millionaire', 2008);

INSERT INTO Tags VALUES (1, 'comedia');
INSERT INTO Tags VALUES (2, 'ciencia ficcion');
INSERT INTO Tags VALUES (3, 'accion');
INSERT INTO Tags VALUES (4, 'guerra');
INSERT INTO Tags VALUES (5, 'drama');

INSERT INTO PeliculasTags VALUES(1, 2);
INSERT INTO PeliculasTags VALUES(1, 3);
INSERT INTO PeliculasTags VALUES(1, 4);
INSERT INTO PeliculasTags VALUES(2, 1);
INSERT INTO PeliculasTags VALUES(2, 2);
INSERT INTO PeliculasTags VALUES(3, 1);

-- 3
-- Uniendo las tablas
SELECT *
FROM Peliculas p
LEFT JOIN PeliculasTags pt ON p.id = pelicula_id
LEFT JOIN Tags t ON t.id = tag_id;

-- Contando los tags por película
SELECT p.id, nombre, COUNT(pelicula_id) AS cantidad_tags
FROM Peliculas p
LEFT JOIN PeliculasTags pt ON p.id = pelicula_id
GROUP BY p.id, nombre
ORDER BY cantidad_tags DESC;

-- SEGUNDA PARTE

-- 4
CREATE TABLE Preguntas (
  "id" Integer,
  "pregunta" Varchar(255),
  "respuesta_correcta" Varchar,
  PRIMARY KEY ("id")
);

CREATE TABLE Usuarios (
  "id" Integer,
  "nombre" Varchar(255),
  "edad" Integer,
  PRIMARY KEY ("id")
);

CREATE TABLE Respuestas (
	"id" Integer,
	"respuesta" Varchar(255),
	"usuario_id" Integer,
	"pregunta_id" Integer,
	FOREIGN KEY ("usuario_id") REFERENCES Usuarios("id"),
	FOREIGN KEY ("pregunta_id") REFERENCES Preguntas("id"),
	PRIMARY KEY ("id")
);

SELECT * FROM Preguntas;
SELECT * FROM Usuarios;
SELECT * FROM Respuestas;

-- 5
INSERT INTO Preguntas VALUES (1, '¿Cuál es la capital de Francia?', 'París');
INSERT INTO Preguntas VALUES (2, '¿Cuál es el océano más grande del mundo?', 'Océano Pacífico');
INSERT INTO Preguntas VALUES (3, '¿Cuántos días tiene una semana?', '7');
INSERT INTO Preguntas VALUES (4, '¿Cuál es el símbolo químico del agua?', 'H2O');
INSERT INTO Preguntas VALUES (5, '¿Cuántos continentes hay en el mundo?', '7');

INSERT INTO Usuarios VALUES (1, 'Julia', 28);
INSERT INTO Usuarios VALUES (2, 'Alejandro', 42);
INSERT INTO Usuarios VALUES (3, 'Sophie', 19);
INSERT INTO Usuarios VALUES (4, 'Diego', 36);
INSERT INTO Usuarios VALUES (5, 'Isabella', 51);

INSERT INTO Respuestas VALUES (1, 'Madrid', 1, 1);
INSERT INTO Respuestas VALUES (2, 'París', 2, 1);
INSERT INTO Respuestas VALUES (3, 'París', 3, 1);
INSERT INTO Respuestas VALUES (4, 'Roma', 4, 1);
INSERT INTO Respuestas VALUES (5, 'Roma', 5, 1);
INSERT INTO Respuestas VALUES (6, 'Océano Ártico', 1, 2);
INSERT INTO Respuestas VALUES (7, 'Océano Atlántico', 2, 2);
INSERT INTO Respuestas VALUES (8, 'Océano Atlántico', 3, 2);
INSERT INTO Respuestas VALUES (9, 'Océano Atlántico', 4, 2);
INSERT INTO Respuestas VALUES (10, 'Océano Pacífico', 5, 2);
INSERT INTO Respuestas VALUES (11, '5', 1, 3);
INSERT INTO Respuestas VALUES (12, '6', 2, 3);
INSERT INTO Respuestas VALUES (13, '30', 3, 3);
INSERT INTO Respuestas VALUES (14, '24', 4, 3);
INSERT INTO Respuestas VALUES (15, '5', 5, 3);
INSERT INTO Respuestas VALUES (16, 'O2', 1, 4);
INSERT INTO Respuestas VALUES (17, 'HO2', 2, 4);
INSERT INTO Respuestas VALUES (18, 'O2H', 3, 4);
INSERT INTO Respuestas VALUES (19, 'O2', 4, 4);
INSERT INTO Respuestas VALUES (20, 'HO2', 5, 4);
INSERT INTO Respuestas VALUES (21, '5', 1, 5);
INSERT INTO Respuestas VALUES (22, '6', 2, 5);
INSERT INTO Respuestas VALUES (23, '5', 3, 5);
INSERT INTO Respuestas VALUES (24, '5', 4, 5);
INSERT INTO Respuestas VALUES (25, '6', 5, 5);

-- 6
-- Uniendo las tablas
SELECT *
FROM Preguntas p
JOIN Respuestas r ON p.id = pregunta_id
JOIN Usuarios u ON u.id = usuario_id;

-- Contando respuestas correctas por usuario
SELECT nombre, COUNT(usuario_id) AS respuestas_correctas
FROM Preguntas p
JOIN Respuestas r ON p.id = pregunta_id
JOIN Usuarios u ON u.id = usuario_id
WHERE respuesta = respuesta_correcta
GROUP BY nombre

-- 7
SELECT *
FROM Preguntas p
JOIN Respuestas r ON p.id = pregunta_id

SELECT pregunta, COUNT()
FROM preguntas p
JOIN Respuestas r ON p.id = pregunta_id
GROUP BY pregunta

SELECT pregunta, COUNT(usuario_id) AS cantidad_correctas
FROM Preguntas p
LEFT JOIN Respuestas r ON p.id = pregunta_id
WHERE respuesta = respuesta_correcta
GROUP BY pregunta

-- 8
ALTER TABLE Respuestas 
DROP CONSTRAINT respuestas_usuario_id_fkey,
ADD FOREIGN KEY("usuario_id") 
REFERENCES Usuarios("id") 
ON DELETE CASCADE

DELETE FROM Usuarios
WHERE id = 1

-- 9
ALTER TABLE Usuarios ADD CONSTRAINT edadCheck CHECK (edad >= 18);

INSERT INTO Usuarios VALUES (6, 'Pepe', 17);

