use asistencia;
drop PROCEDURE `recuperar_contra`;
DELIMITER ;;
CREATE PROCEDURE `recuperar_contra`(
IN username varchar(50),
IN password_p VARCHAR(20),
      OUT yes_no int 
 )
BEGIN
declare perfil int(11);

set perfil = (select cu_id
        from cuenta where cu_usuario=username);
        if ((select count(cu_id)
        from cuenta where cu_usuario=username)=0) then
        set yes_no=0;
else
UPDATE `cuenta` SET `cu_password` = (select SHA2(password_p, 512)) 
WHERE `cuenta`.`cu_id` = perfil;
     set yes_no = (select row_count()); 

end if;      
END;;
