Drop PROCEDURE ver_incidencia
DELIMITER ;;
CREATE PROCEDURE ver_incidencia(
)
BEGIN
SELECT * FROM `incidencia`;
end;;
