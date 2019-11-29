use asistencia;
drop PROCEDURE `eliminar`;
DELIMITER ;;
CREATE PROCEDURE `eliminar`(
IN cuenta int(11),
      OUT yes_no int 
 )
BEGIN
declare perfil int(11);
declare usuario int(11);
delete from mercado where id_cuenta=cuenta;
delete from ausencia where cuenta_id=cuenta;
delete from horario where cuenta_id=cuenta;
delete from extras where id_cuenta=cuenta;
delete from incidencia where cuenta_id=cuenta;
set perfil=(select id_perfil from cuenta where cu_id=cuenta);
set usuario=(select id_usuario from usuarios where pe_id=perfil);
delete from cuenta where cu_id=cuenta;
delete from usuarios where us_id=usuario;
delete from perfil where pe_id=perfil;
set yes_no =(select row_count());
end if;      
END;;