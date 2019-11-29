Drop PROCEDURE ver_horario
DELIMITER ;;
CREATE PROCEDURE ver_horario(
    in cuenta int(11) 
)
BEGIN

select * from horario where cuenta_id=cuenta;
end;;
