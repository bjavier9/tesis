use asistencia;
drop PROCEDURE `nuevo_usuario`
DELIMITER ;;
CREATE definer = `root` @`localhost` 
PROCEDURE `nuevo_usuario`(    IN nombre     VARCHAR(90), 
                          IN apellido   VARCHAR(45), 
                          IN cedula     VARCHAR(45), 
                          IN nacimiento date, 
                          IN correo     VARCHAR(145), 
                          IN telefono   INT(12), 
                          IN familiar   VARCHAR(45), 
                          IN telefono_f INT(12),                           
                          IN carrera      VARCHAR(145), 
                          IN nacionalidad VARCHAR(45), 
                          OUT st          INT(9) 
                          ) 
begin 
  DECLARE mensaje VARCHAR(50);
 
  if((SELECT count(us_correo) from usuarios WHERE us_correo=correo)=0)then
    if ((select correo REGEXP '(.*)@(.*)\.(.*)')=1) then 
        if((select count(us_cedula) from usuarios WHERE us_cedula=cedula)=0)then
          INSERT INTO `usuarios` 

  

              ( 
                          `us_id`, 
                          `us_nombre`, 
                          `us_apellido`, 
                          `us_cedula`, 
                          `us_nacimiento`, 
                          `us_correo`, 
                          `us_telefono`, 
                          `us_familiar`, 
                          `us_telefonofamiliar`, 
                          `us_carrera`, 
                          `us_nacionalidad`,
                          `us_preregistro`
              ) 
              VALUES 
              ( 
                          NULL, 
                          nombre, 
                          apellido, 
                          cedula, 
                          nacimiento, 
                          correo, 
                          telefono, 
                          familiar, 
                          telefono_f, 
                          carrera, 
                          nacionalidad,
                          '1'
              );
                set mensaje='Se agrego correctamente.';
        ELSE
              set mensaje='Ya existe este usuario.';
        end if;

  ELSE
    set mensaje='Correo no valido.';
  end if;
ELSE
  set mensaje ='Este correo existe.';
end if;



if (row_count() = 0)THEN 
    SET st = row_count();
ELSE 
  SET  st = row_count();
END IF;
select mensaje;
end;;
DELIMITER ;;