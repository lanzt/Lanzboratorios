const { Router } = require("express");

router = Router();

/**
 * Ruta con los pasos a seguir para afiliarse al
 * centro medico
 */
router.get("/afiliacion", (req, res) => {
    res.render("afiliacion", { pageTitle: "Afiliación" });
});

module.exports = router;
