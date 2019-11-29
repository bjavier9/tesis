
use asistencia;
drop PROCEDURE `historial`;
DELIMITER ;;
CREATE PROCEDURE `historial`(
IN cuenta int(11)
  
 )
BEGIN
SELECT ma_hora, ma_fecha, ma_indicador, pa_nombre FROM `marcado` m inner join parametrizar p on 
p.pa_id=m.id_parametrizado where id_cuenta=cuenta;

   
END;;