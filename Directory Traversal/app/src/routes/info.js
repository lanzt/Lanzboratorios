const { Router } = require("express");
const path = require("path");
const fs = require("fs");

router = Router();

/**
 * Ruta con información del centro medico
 */
router.get("/sobre-nosotros", (req, res) => {
    res.render("sobre-nosotros", { pageTitle: "Sobre nosotros" });
});

/**
 * Ruta con información de los puntos de atención
 */
router.get("/red-atencion", (req, res) => {
    res.render("red-atencion", { pageTitle: "Puntos de atención" });
});

/**
 * Ruta con la regulación a lo largo del tiempo
 *
 * Está leyendo la ruta static/regulaciones y mostrando
 * todos los archivos que allí se encuentren
 */
router.get("/regulacion", (req, res) => {
    let directoryFiles = path.join(__dirname, "../static/regulaciones");

    fs.readdir(directoryFiles, (err, files) => {
        if (err) {
            console.error(err);
            return;
        }
        res.render("regulacion", { pageTitle: "Regulación", files });
    });
});

/**
 * Ruta para ver el contenido de alguna regulación (archivo)
 *
 * Está tomando en el parametro nombreArchivo el nombre del
 * archivo con la regulación y mostrando su contenido
 */
router.get("/regulacion/archivos/descargar", (req, res) => {
    if (req.query.nombreArchivo) {
        let paramFileName = req.query.nombreArchivo;

        // Evitar que los usuarios se muevan entre directorios (../)
        let fileName = paramFileName.replace(/\.\.\//g, "");

        // Evitar errores
        try {
            const filePath = path.join(
                __dirname,
                "../static/regulaciones/",
                fileName
            );

            fs.readFile(filePath, "utf8", (err, data) => {
                if (err) {
                    // Evitar problemas al leer el archivo o directorio
                    if (err.code === "ENOENT" || err.code === "EISDIR") {
                        res.status(404).render("404", {
                            pageTitle: "No se encontró la página",
                        });
                    } else {
                        res.status(500).send("Oops, ocurrió un error");
                    }
                    return;
                }
                res.sendFile(filePath);
            });
        } catch (error) {
            res.status(404).render("404", {
                pageTitle: "No se encontró la página",
            });
        }
    } else {
        res.status(400).send(
            "Petición incorrecta: No se encontró el parametró: nombreArchivo "
        );
    }
});

/**
 * Ruta con la normatividad a regir
 *
 * Está leyendo la ruta static/acuerdos y mostrando el
 * titulo y contenido de todos los acuerdos (archivos)
 * que allí se encuentren
 */
router.get("/normatividad", (req, res) => {
    const directoryFiles = path.join(__dirname, "../static/acuerdos");
    const paramSearchFile = req.query.search || "";

    // Leer todos los archivos en la carpeta base
    fs.readdir(directoryFiles, (err, files) => {
        if (err) {
            console.error(err);
            return res.status(500).send("Oops, ocurrió un error");
        }

        let filteredFiles;

        if (paramSearchFile) {
            // Si hay un parámetro de búsqueda, filtrar los archivos
            filteredFiles = files.filter((file) =>
                file.toLowerCase().includes(paramSearchFile.toLowerCase())
            );
        } else {
            // Si no hay parámetro de búsqueda, mostrar todos los archivos
            filteredFiles = files;
        }

        // Mapear los archivos filtrados y leer su contenido
        const acuerdos = filteredFiles.map((file) => {
            const filePath = path.join(directoryFiles, file);
            let fileContent = "";

            try {
                fileContent = fs.readFileSync(filePath, "utf8");
            } catch (err) {
                if (err.code === "ENOENT" || err.code === "EISDIR") {
                    fileContent = "Ha sucedido un error";
                }
            }

            // Si el archivo tiene +150 caracteres, se envian esos 150
            // caracteres concatenado a ...
            const CHAR_LIMIT = 150;
            if (fileContent.length > CHAR_LIMIT) {
                fileContent = fileContent.slice(0, CHAR_LIMIT).concat("...");
            }

            return {
                fileTitle: path.basename(file, path.extname(file)),
                fileContent,
            };
        });

        // Renderizar la vista con los archivos filtrados o todos los archivos
        res.render("normatividad", {
            pageTitle: "Normatividad",
            acuerdos,
            visualizar: true,
        });
    });
});

/**
 * Ruta para ver el contenido de alguna normativa (archivo)
 *
 * Está tomando en el parametro nombreArchivo el nombre del
 * archivo con la normativa y mostrando su contenido
 */
router.get("/normatividad/archivos/visualizar", (req, res) => {
    if (req.query.acuerdo) {
        let paramFileName = req.query.acuerdo;

        // Evitar que los usuarios se muevan entre directorios (../)
        let fileName = paramFileName.replace(/\.\.\//g, "");

        // Evitar errores
        try {
            const filePath = path.join(
                __dirname,
                "../static/acuerdos/",
                fileName
            );

            fs.readFile(filePath, "utf8", (err, data) => {
                if (err) {
                    // Evitar problemas al leer el archivo o directorio
                    if (err.code === "ENOENT" || err.code === "EISDIR") {
                        res.status(404).render("404", {
                            pageTitle: "No se encontró la página",
                        });
                    } else {
                        res.status(500).send("Oops, ocurrió un error");
                    }
                }
                const acuerdos = [
                    {
                        fileTitle: paramFileName,
                        fileContent: data,
                    },
                ];

                res.render("normatividad", {
                    pageTitle: "Normatividad",
                    acuerdos,
                    visualizar: false,
                });
            });
        } catch (error) {
            res.status(404).render("404", {
                pageTitle: "No se encontró la página",
            });
        }
    } else {
        res.status(400).send(
            "Petición incorrecta: No se encontró el parametró: acuerdo"
        );
    }
});

module.exports = router;
