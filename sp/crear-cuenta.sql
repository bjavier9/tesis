use asistencia;
drop PROCEDURE `crear_cuenta`;
DELIMITER ;;
CREATE definer = `root` @`localhost` 
PROCEDURE `crear_cuenta`(    IN sede     int(11), 
                          IN rol   int(11), 
                          IN beca   int(11), 
                          IN usuario int(11), 
                          IN ocupacion    VARCHAR(145), 
                          IN area   varchar(90),  
                          OUT st1          INT(9) 
                          ) 
begin 
  DECLARE mensaje VARCHAR(50);
  declare w_perfil int(11);
  declare w_primer varchar(90);
  declare w_segundo varchar(90);
  declare w_nombre varchar(245);
  declare w_apellido varchar(245);
  declare w_idperfil varchar(245);
  declare w_cedula varchar(245);
  declare w_password varchar(1024);
  declare w_preregistro int(12);
set w_preregistro = (select us_preregistro from usuarios where us_id=usuario);

if(w_preregistro=1)then 
    INSERT INTO `perfil` (`pe_id`, `id_sede`, `id_rol`, `id_beca`, `id_usuario`, `pe_ocupacion`, `pe_area`, `pe_estado`) 
    VALUES (NULL, sede, rol, beca, usuario, ocupacion, area, 'C');

    set st1 =(SELECT ROW_COUNT());
        if (st1 = 0)THEN
            set mensaje = 'Error al agregar el perfil nuevo.';
        else
        set st1=0;
        set w_perfil = (select pe_id from perfil where id_usuario=usuario);

        set w_nombre=(select us_nombre from usuarios where us_id=usuario);
        set w_apellido=(select us_apellido from usuarios where us_id=usuario);
        set w_primer= (SELECT SUBSTRING(w_nombre,-1));
        set w_segundo=(SELECT SUBSTRING_INDEX(w_apellido, ' ', 1) );
        set w_idperfil=(Select CONCAT(w_primer, w_segundo, usuario));
        set w_cedula=(select us_cedula from usuarios where us_id=usuario);
        set w_password=SHA2(TRIM(w_cedula), 512);
        INSERT INTO `cuenta` (`cu_id`, `id_perfil`, `cu_usuario`, `cu_password`, `cu_cambio`, `cu_creado`) 
        VALUES (NULL, w_perfil, w_idperfil, w_password, 0, CURRENT_TIMESTAMP);
        set mensaje = 'Se agrego la nueva cuenta correctamente.';
    
        set st1=(select row_count());
            if(st1=0)then
                set mensaje='Error a pasado algo al quitar el preregistro agregue el valor 0 al usuario.';
            else 
                UPDATE `usuarios` SET `us_preregistro` = '0' WHERE `usuarios`.`us_id` = usuario;

            end if;
        end if;
else 
  set mensaje = 'No puedes registrar este usuario. Verifique preregistro.';
  set st1=row_count();
end if;

  select mensaje;
end;;
DELIMITER ;;