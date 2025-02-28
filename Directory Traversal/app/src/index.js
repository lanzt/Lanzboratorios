const express = require("express");
const morgan = require("morgan");
const path = require("path");
const ejs = require("ejs");

const app = express();

/**
 * Definición de las configuraciones generales de la app
 */
app.set("port", 3000);
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

/**
 * Definición del middleware
 */
app.use(morgan("dev"));

/**
 * Importación de las rutas externas alojadas en routes/
 *
 * routes/users.js
 * routes/info.js
 */
const UserRoutes = require(path.join(__dirname, "routes/users"));
const InfoRoutes = require(path.join(__dirname, "routes/info"));

/**
 * Ruta con la información de inicio al visitar la app
 */
app.get("/", (req, res) => {
    res.render("index", { pageTitle: "Inicio" });
});

/**
 * Se ponen a disposición las rutas importadas
 */
app.use(UserRoutes);
app.use(InfoRoutes);

/**
 * Se crea una ruta para alojar objetos al público
 *
 * La ruta /public esta sirviendo todos los archivos que se
 * encuentren en static/
 */
app.use("/public", express.static(path.join(__dirname, "static")));

/**
 * Ruta para responder cuando un recurso no ha sido encontrado
 * en el sitio web
 */
app.get("*", function (req, res) {
    res.status(404).render("404", { pageTitle: "No se encontró la página" });
});

/**
 * Se usa la variable "port" de la configuración general
 */
app.listen(app.get("port"));
console.log(`Server on port ${app.get("port")}`);
