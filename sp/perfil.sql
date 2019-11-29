use asistencia;
drop PROCEDURE `perfil`;
DELIMITER ;;
CREATE PROCEDURE `perfil`(
IN cuenta int(11)
  
 )
BEGIN
SELECT se_nombre, rol_nombre, cu_usuario,pe_ocupacion, pe_area,be_nombre, be_porcentaje, `us_nombre`, `us_apellido`, `us_cedula`, `us_nacimiento`, `us_correo`, `us_telefono`, `us_familiar`, `us_telefonofamiliar`, `us_nacionalidad`, `us_carrera`
FROM `cuenta` c 
inner join perfil p on 
p.pe_id=c.id_perfil 
inner join usuarios u on
p.id_usuario=u.us_id
inner join beca b on 
p.id_beca=b.be_id
inner join rol r on
r.rol_id=p.id_rol
inner join sede s on 
p.id_sede = s.se_id 
where c.cu_id=cuenta;

   
END;;