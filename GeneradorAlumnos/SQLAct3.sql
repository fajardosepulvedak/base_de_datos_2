DROP TABLE alumnos;
CREATE TABLE IF NOT EXISTS alumnos(
    expediente INTEGER NOT NULL UNIQUE CHECK(LENGTH(expediente)=9 AND expediente>0),
    app1 VARCHAR(255) NOT NULL CHECK(LENGTH(TRIM(app1))>0),
    app2 VARCHAR(255) CHECK(app2 IS NULL OR (LENGTH(TRIM(app2)))>0),
    nombres VARCHAR(255) NOT NULL CHECK(LENGTH(TRIM(nombres))>0),
    correo VARCHAR(255) NOT NULL UNIQUE CHECK(correo=CONCAT("a",expediente,"@unison.mx"))
);

--El siguiente trigger elimina elimina los espacios en blanco en la primera colimna antes de hacer el insert
DELIMITER $$

CREATE TRIGGER bi_alumnos_app1
BEFORE INSERT ON alumnos 
FOR EACH ROW
BEGIN
    SET NEW.app1=TRIM(NEW.app1);
END$$
DELIMITER ;

--PRUEBAS DE INTEGRIDAD
INSERT INTO alumnos VALUES (NULL, "Abril", "Garcia", "Jose Humberto", "jose.abril@unison.mx");
INSERT INTO alumnos VALUES (0, "Abril", "Garcia", "Jose Humberto", "jose.abril@unison.mx");
INSERT INTO alumnos VALUES (22420936, "", "Garcia", "Jose Humberto", "jose.abril@unison.mx");
INSERT INTO alumnos VALUES (224209368, "       ", "Garcia", "Jose Humberto", "jose.abril2@unison.mx");
INSERT INTO alumnos VALUES (224209369, "       a                    ", "Garcia", "Jose Humberto", "jose.abril3@unison.mx");
INSERT INTO alumnos VALUES (224209370, "b                   ", "Garcia", "Jose Humberto", "jose.abril4@unison.mx"),
(224209371, "c                 ", "Garcia", "Jose Humberto", "jose.abril5@unison.mx");
INSERT INTO alumnos VALUES (224209366, "Abril", "Garcia         ", "Jose Humberto", "jose.abril@unison.mx");
INSERT INTO alumnos VALUES (224209366, "Abril", "     ", "Jose Humberto", "jose.abril@unison.mx");  
INSERT INTO alumnos VALUES (224209366, "Abril", NULL, "Jose Humberto", "jose.abril@unison.mx");     
