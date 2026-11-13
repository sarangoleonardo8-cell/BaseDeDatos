# Aprendizaje Autónomo: Modelos Entidad-Relación, Relacional y SQL

---

## Ejemplo 1: Sistema de Biblioteca
**Concepto:** Una biblioteca registra libros y autores. Un libro puede tener varios autores y un autor varios libros. Los socios toman libros prestados; de cada préstamo interesan la fecha de retiro y la de devolución.

### Diagrama Entidad-Relación
![Diagrama ER Sistema de Biblioteca](./imagenes/er_ejercicio1.png)

### Modelo Relacional
![Modelo Relacional Sistema de Biblioteca](./imagenes/mr_ejercicio1.png)

### Código SQL
```sql
CREATE TABLE socio (
   id_socio VARCHAR(15) PRIMARY KEY,
   nombre VARCHAR(100) NOT NULL
);
CREATE TABLE libro (
   isbn VARCHAR(20) PRIMARY KEY,
   titulo VARCHAR(150) NOT NULL
);
CREATE TABLE prestamo (
   id_prestamo VARCHAR(15) PRIMARY KEY,
   id_socio VARCHAR(15) NOT NULL,
   isbn VARCHAR(20) NOT NULL,
   fecha_retiro DATE NOT NULL,
   fecha_devolucion DATE,
   FOREIGN KEY (id_socio) REFERENCES socio(id_socio),
   FOREIGN KEY (isbn) REFERENCES libro(isbn)
);
CREATE TABLE autor (
   id_autor VARCHAR(15) PRIMARY KEY,
   nombre VARCHAR(100) NOT NULL,
   isbn VARCHAR(20) NOT NULL,
   FOREIGN KEY (isbn) REFERENCES libro(isbn)
);
