
use asistencia;
drop PROCEDURE `recuperar_master`;
DELIMITER ;;
CREATE PROCEDURE `recuperar_master`(
IN username varchar(50),
      OUT yes_no int 
 )
BEGIN
declare perfil int(11);
declare cedula varchar(245);
declare usuario_id int(11);
set perfil = (select id_perfil
        from cuenta where cu_usuario=username);
set usuario_id =(select id_usuario from perfil where pe_id=perfil);
set cedula=(select us_cedula from usuarios where us_id=usuario_id);

        if ((select count(cu_id)
        from cuenta where cu_usuario=username)=0) then
        set yes_no=0;
else
UPDATE `cuenta` SET `cu_password` = (select SHA2(cedula, 512)) 
WHERE `cuenta`.`cu_id` = perfil;
     set yes_no = (select row_count()); 
select cedula;
end if;      
END;;