use asistencia;
drop PROCEDURE `login`;
DELIMITER ;;
CREATE PROCEDURE `login`(
IN username varchar(50),
IN password_p VARCHAR(20),
      OUT yes_no int,
      out cuenta int(11),
      out rol int(11)
 )
BEGIN
declare perfil int(11);
declare mensaje varchar(245);
declare idperfil int(11);
      SELECT count(*) INTO yes_no
      FROM cuenta u
      WHERE u.cu_usuario = username && u.cu_password = (select SHA2(password_p, 512));
if(yes_no=0)then    
set perfil =(select cu_id from cuenta where cu_usuario=username);
if((select sum(conteo) from contador_login where id_cuenta=perfil)<3)then

    INSERT INTO `contador_login` (`id_cont`, `id_cuenta`, `conteo`, `fecha`)
       VALUES (NULL, perfil, 1, CURRENT_TIMESTAMP);

       set mensaje ='fallo ';
else
    if((select pe_estado from perfil WHERE `perfil`.`pe_id` = (select id_perfil 
        from cuenta where cu_usuario=username))='B')then
        set mensaje ='cuenta bloqueada';
        else
    UPDATE `perfil` SET `pe_estado` = 'B' 
        WHERE `perfil`.`pe_id` = (select id_perfil 
            from cuenta where cu_usuario=username);
end if;
         
    set mensaje ='cuenta bloqueada';
end if;
else
    set perfil=(select cu_id from cuenta where cu_usuario=username );
    set mensaje='Inicio sesion correctamente!.';
    set cuenta = perfil;
    set idperfil=(select id_perfil from cuenta where cu_usuario=username );
    set rol=(select id_rol from perfil where pe_id=idperfil );

if((select sum(id_cuenta) from contador_login where id_cuenta=perfil)=0) then
set mensaje='Inicio sesion correctamente!.';

else
delete from contador_login where id_cuenta = perfil;
end if;

end if;
select mensaje;        
END;;
