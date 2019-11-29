drop PROCEDURE `crear_horario`;
DELIMITER ;;
CREATE PROCEDURE `crear_horario`(
IN cuenta int(11),
IN turno int(11),
      OUT yes_no int 
 )
BEGIN
declare perfil int(11);
declare beca int(11);
set perfil=(select id_perfil from cuenta where cu_id=cuenta);
set beca=(SELECT be_porcentaje from perfil p inner join beca b on b.be_id=p.id_beca where pe_id=perfil);
if(beca=100) then 
if((select count(*) from horario where cuenta_id=cuenta)=0) then
	CASE 
        when turno=1 then
            INSERT INTO `horario` VALUES (null,cuenta,'Lunes ','Estandar','09:00:00','17:00:00','12:00:00','13:00:00'),
            (null,cuenta,'Martes','Estandar','09:00:00','17:00:00','12:00:00','13:00:00'),
            (null,cuenta,'Miercoles ','Estandar','09:00:00','17:00:00','12:00:00','13:00:00'),
            (null,cuenta,'Jueves','Estandar','09:00:00','17:00:00','12:00:00','13:00:00'),
            (null,cuenta,'Viernes','Estandar','09:00:00','17:00:00','12:00:00','13:00:00'),
            (null,cuenta,'Sabado ','Estandar','09:00:00','13:00:00',null,null);
            set yes_no = 1;
        when turno=2 then
             INSERT INTO `horario` VALUES (null,cuenta,'Lunes ','Estandar','12:00:00','20:00:00','16:00:00','17:00:00'),
            (null,cuenta,'Martes','Estandar','12:00:00','20:00:00','16:00:00','17:00:00'),
            (null,cuenta,'Miercoles ','Estandar','12:00:00','20:00:00','16:00:00','17:00:00'),
            (null,cuenta,'Jueves','Estandar','12:00:00','20:00:00','16:00:00','17:00:00'),
            (null,cuenta,'Viernes','Estandar','12:00:00','20:00:00','16:00:00','17:00:00'),
            (null,cuenta,'Sabado ','Estandar','12:00:00','20:00:00',n16l,null);
            set yes_no = 1;
        else
            set yes_no = 0;
        end case;


else
set yes_no=0;
end if;
else
if((select count(*) from horario where cuenta_id=cuenta)=0) then
  	CASE 
        when turno=1 then
		INSERT INTO `horario` VALUES (null,cuenta,'Lunes','Estandar','09:00:00','12:00:00',null,null),
        (null,cuenta,'Martes','Estandar','09:00:00','12:00:00',null,null),
        (null,cuenta,'Miercoles','Estandar','09:00:00','12:00:00',null,null),
        (null,cuenta,'Jueves','Estandar','09:00:00','12:00:00',null,null),
        (null,cuenta,'Viernes','Estandar','09:00:00','12:00:00',null,null);
        set yes_no = 1;
        when turno=2 then 
		INSERT INTO `horario` VALUES (null,cuenta,'Lunes','Estandar','13:00:00','16:00:00',null,null),
        (null,cuenta,'Martes','Estandar','13:00:00','16:00:00',null,null),
        (null,cuenta,'Miercoles','Estandar','13:00:00','16:00:00',null,null),
        (null,cuenta,'Jueves','Estandar','13:00:00','16:00:00',null,null),
        (null,cuenta,'Viernes','Estandar','13:00:00','16:00:00',null,null);
        set yes_no = 1;
        when turno=3 then 
		INSERT INTO `horario` VALUES (null,cuenta,'Lunes','Estandar','17:00:00','20:00:00',null,null),
        (null,cuenta,'Martes','Estandar','17:00:00','20:00:00',null,null),
        (null,cuenta,'Miercoles','Estandar','17:00:00','20:00:00',null,null),
        (null,cuenta,'Jueves','Estandar','17:00:00','20:00:00',null,null),
        (null,cuenta,'Viernes','Estandar','17:00:00','20:00:00',null,null);
        set yes_no = 1;
        else 
			set yes_no=0;
    end case;
    else
set yes_no=0;
end if;
end if;    
END;;
