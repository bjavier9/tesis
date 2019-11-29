use asistencia;
select  now();
marcado_BEFORE_UPDATEmarcado_BEFORE_UPDATE
CREATE TABLE `historial_usuarios` (
  `pe_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sede` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_beca` int(11) NOT NULL,
  `pe_ocupacion` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `pe_area` varchar(95) COLLATE utf8_spanish_ci NOT NULL,
  `pe_estado` char(3) COLLATE utf8_spanish_ci NOT NULL,   
  `us_nombre` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `us_apellido` varchar(90) COLLATE utf8_spanish_ci NOT NULL,
  `us_cedula` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_nacimiento` date NOT NULL,
  `us_correo` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_telefono` int(12) NOT NULL,
  `us_familiar` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_telefonofamiliar` int(12) NOT NULL,
  `us_color` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `us_foto` text COLLATE utf8_spanish_ci NOT NULL,
  `us_carrera` varchar(145) COLLATE utf8_spanish_ci DEFAULT NULL,
   `us_horas` int(11) NOT NULL ,
    `us_extras` int(11) NOT NULL ,
     `us_tardansas` int(11) NOT NULL ,
      `us_aucensias` int(11) NOT NULL,
        PRIMARY KEY (`pe_id`)
      )ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla historico de usuarios.'







DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `genera_factura`(in tiempo_final varchar(255), in id_auto int, in id_usuario int)
begin 
	declare dias INT;
    declare total_autos INT;
    declare mensaje varchar(50);
    
    declare cantidad decimal(10,2); 
	set dias =(SELECT DATEDIFF(tiempo_final,now()));
	set cantidad = dias*(SELECT auto_precio FROM autos where auto_id = id_auto);
		/*
    hago un update de la cantidad disponible tomando en cuenta que no llegue a -1
    */
    /*aumentamos descuentos dependiendo de la cantidad de dias*/
	CASE 
        when dias>=20 then
			set cantidad = cantidad-cantidad*0.30;
        when dias>=15 then 
			set cantidad = cantidad-cantidad*0.15;
        else 
			set cantidad =  cantidad;
    end case;
    select disponible_cantidad into total_autos from disponibles where auto_id = id_auto;
    IF total_autos>0 then 
    
		/* insertamos los datos de la factura  */
		insert into factura (usuario_id, auto_id, tiempo_final, factura_costo)VALUES(id_usuario, id_auto, tiempo_final , cantidad);
		set total_autos=total_autos-1;
		UPDATE disponibles SET disponible_cantidad=total_autos WHERE auto_id=id_auto;
       
        select  a.auto_marca, a.auto_year, a.auto_categoria, a.auto_imagen, a.auto_precio, a.auto_modelo, cantidad, dias from autos a LIMIT 1 ;
		
    Else
		set mensaje = 'Error, ya no quedan autos';
        select mensaje;
	end if;		
END ;;
DELIMITER ;

DELIMITER ;;
create function marco(indicador varchar(3),cuenta int, parametro int) returns  int
begin
declare state int;
INSERT INTO `marcado` (`ma_id`, `id_cuenta`, `ma_hora`, `ma_fecha`, `ma_indicador`, `id_parametrizado`) VALUES (NULL, cuenta,TIME(now()), DATE(now()),indicador, parametro);
if((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=parametro)!=0) then 
set state=1;
else
set state=0;
end if;
return state
end;
DELIMITER ;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `marcar`(in cuenta int(11))
begin 
	declare hora_inicio time;
    declare dia Varchar(10);
    declare mensaje varchar(50);
    declare hora_final time;
    declare hora_actual time;
    declare hora_ealmuerzo time;
    declare hora_salmuerzo time;
    declare entrada time;
    declare salida time; 
    declare beca int(10);

    declare minimo_hora time;
    declare maximo_hora time;
    
    set beca = (SELECT be_porcentaje from cuenta inner join perfil on perfil.pe_id = cuenta.id_perfil inner join beca on perfil.id_beca = beca.be_id where cu_id = cuenta);
	set dia = (SELECT (ELT(WEEKDAY(now()) + 1, 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')) );
    set hora_inicio=(select ho_inicio from horario where cuenta_id=cuenta and ho_dia=dia);
	set hora_final=(select ho_final from horario where cuenta_id=cuenta and ho_dia=dia);
    set hora_ealmuerzo = (select ho_ealmuerzo from horario where cuenta_id=cuenta and ho_dia=dia);
	set hora_salmuerzo = (select ho_salmuerzo from horario where cuenta_id=cuenta and ho_dia=dia);
    set minimo_hora =  (SUBTIME(hora_inicio, "1:00:00"));
   
      
    
    /*
    SELECT ISNULL((select ho_final from horario where cuenta_id=1 and ho_dia='Domingo'))
    
    select ho_final from horario where cuenta_id=1 and ho_dia=(SELECT (ELT(WEEKDAY(now()) + 1, 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')))
    select ho_final from horario where cuenta_id=1 and ho_dia='Martes'
     select ho_ealmuerzo from horario where cuenta_id=1 and ho_dia='Martes'
     select ho_salmuerzo from horario where cuenta_id=1 and ho_dia='jueves'
     select ho_inicio from horario where cuenta_id=1 and ho_dia='jueves'
      CALL `asistencia`.`marcar`(1);
     select  
    (
   
    CASE 
        WHEN ho_inicio <= '08:00:00' THEN 
        
     
    END case) AS total
 from horario where cuenta_id=1;
     
	 select ma_indicador, be_porcentaje from cuenta 
     inner join perfil on 
     perfil.pe_id = cuenta.id_perfil 
     inner join beca on 
     perfil.id_beca = beca.be_id 
     inner join marcado on
     perfil.id_beca = marcado.id_cuenta
     where 
		 cu_id = 1 and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t' and be_porcentaje =100
		  
    select count(ma_indicador) from marcado where id_cuenta=1 and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t' 
    */
	set hora_actual = (SELECT TIME(now()));
    set entrada = (SELECT time(ADDTIME(hora_inicio,'00:05:00')));
    set salida = (SELECT time(ADDTIME(hora_inicio,'01:00:00')));
    /*definir si el asistente es beca full o media */
if dia = 'Sabado' and beca=75 then
	set mensaje = 'Error, no puedes marcar hoy.';   
else

    if dia = 'Domingo' then
		set mensaje = 'Error, no se puede marcar hoy.';    
	else
			CASE 
				when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t')=0) then
				 if  entrada<hora_actual then
					INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 't', 1);
				 else
					INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'p', 1);
				 end if;
				when ((select count(ma_indicador) from marcado where   id_cuenta=1 and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t')=1) then
                    if ((select count(ma_indicador) from marcado where   id_cuenta=1 and ma_fecha = DATE(now()) and id_parametrizado=2 and ma_indicador='ae' )=0) and hora_final<hora_actual and beca = 100 then 
                     	INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'as', 3);
                        INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'ae', 2);
                        INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 's', 4);
                        INSERT INTO incidencia VALUES (NULL, '1', 'No esta marcando almuerzo.');
                        set mensaje = 'Se registro la salida correctamente.';
                    else 
                    case
					
						when  hora_actual>=hora_final then
							INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 's', 4);
                            set mensaje = 'Se registro la salida correctamente.';
						when hora_actual<=salida then
							INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'ex', 4);
                            set mensaje = 'Se registro la salida correctamente.';
						when beca=100 then
							case
								when ((select count(ma_indicador) from marcado where   id_cuenta=1 and ma_fecha = DATE(now()) and id_parametrizado=2 and ma_indicador='ae' )=0)  then
									INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'ae', 2);
									  set mensaje = 'Se registro la salida correctamente ae.';
								when ((select count(ma_indicador) from marcado where   id_cuenta=1 and ma_fecha = DATE(now()) and id_parametrizado=2 and ma_indicador='ae' )=1) then
									INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'as', 3);
									  set mensaje = 'Se registro la salida correctamente ae.';
								end case;
                        end case;
					end if;			
                    
				else 
				 set mensaje = 'Error no puedes marcar';	
				
			end case;
		end if;
end if;
select mensaje;
    
    /*
    Indicadores: 
		p : puntual .
		t: tardanza.
		ae: entrada almuerzo,
		as: salida almuerzo,
		s: salida, 
		n: ausencia de marcacion,
		np: ausente ese dia.  
        j:justificacion de ausencia
    */
	
END ;;
DELIMITER ;



select 
SELECT time(ADDTIME(now(),'01:00:00')),time( now()),time(SUBTIME(now(),'01:00:00'))

DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `marcar`(in cuenta int(11))
begin 
	declare hora_inicio time;
    declare dia Varchar(10);
    declare mensaje varchar(50);
    declare hora_final time;
    declare hora_actual time;
    declare hora_ealmuerzo time;
    declare hora_salmuerzo time;
    declare entrada time;
    declare salida time; 
    declare beca int(10);
    declare almuerzo_tarde time;
    declare minimo_hora time;
    declare maximo_hora time;
    
    set beca = (SELECT be_porcentaje from cuenta inner join perfil on perfil.pe_id = cuenta.id_perfil inner join beca on perfil.id_beca = beca.be_id where cu_id = cuenta);
	set dia = (SELECT (ELT(WEEKDAY(now()) + 1, 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo')) );
    set hora_inicio=(select ho_inicio from horario where cuenta_id=cuenta and ho_dia=dia);
	set hora_final=(select ho_final from horario where cuenta_id=cuenta and ho_dia=dia);
    set hora_ealmuerzo = (select ho_ealmuerzo from horario where cuenta_id=cuenta and ho_dia=dia);
	set hora_salmuerzo = (select ho_salmuerzo from horario where cuenta_id=cuenta and ho_dia=dia);
    set minimo_hora =  (SUBTIME(hora_final, "1:00:00"));
   
      
  
	set hora_actual = (SELECT TIME(now()));
    set entrada = (SELECT time(ADDTIME(hora_inicio,'00:05:00')));
    set salida = (SELECT time(ADDTIME(hora_final,'01:00:00')));
    /*set almuerzo_tarde = (SELECT  timediff(now(),TIMESTAMP((SELECT ma_fecha FROM `marcado` where id_cuenta=cuenta and id_parametrizado=3 and ma_fecha=date(now())),  (SELECT ma_hora FROM `marcado` where id_cuenta=cuenta and id_parametrizado=3 and ma_fecha=date(now()))) ));*/
    set almuerzo_tarde =(SELECT time(ADDTIME((SELECT ma_hora FROM `marcado` where id_cuenta=cuenta and id_parametrizado=3 and ma_fecha=date(now())),'00:45:00')));
    
    /*definir si el asistente es beca full o media */
if dia = 'Sabado' and beca=75 then
	set mensaje = 'Error, no puedes marcar hoy.';   
else

    if dia = 'Domingo' then
		set mensaje = 'Error, no se puede marcar hoy.';    
	else
			CASE 
				when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t')=0) then
				 if  entrada<hora_actual then
					INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 't', 1);
                    set mensaje = 'Se registro correctamente su entrada.';
				 else
					INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'p', 1);
                    set mensaje = 'Se registro correctamente su entrada.';
				 end if;
				when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t')=1) and beca=100 then
                   if  minimo_hora<hora_actual then
                   set mensaje = 'No puedes marcar almuerzo.';
					   INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'nmt', 2);
					   INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'nmt', 3);
                   else
                   case
								when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=2 and ma_indicador='ae' )=0)  then
									INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'ae', 2);
									  set mensaje = 'Se registro la salida correctamente ae.';
								when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=2 and ma_indicador='ae' )=1) then
									if hora_actual>almuerzo_tarde then 
                                    INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'ast', 3);
									set mensaje = 'Se registro la salida correctamente as.';
                                   else
                                    INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'as', 3);
									set mensaje = 'Se registro la salida correctamente as.';
                                    end if;
								when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=3 and ma_indicador='as' or ma_indicador='nmt' or ma_indicador='nt' )=1) then
								   if ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=4 and ma_indicador='s')=0) then
									INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 's', 4);
									set mensaje = 'Se registro la salida correctamente.';
								else 
                                set mensaje = 'Marcaje rechazado.';
								end if;
					end case;
                    end if;
                    
				when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t')=1) and beca=75 then
						case
                        when hora_actual>=hora_final then
							   if ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=4 and ma_indicador='s')=0) then
									INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 's', 4);
									set mensaje = 'Se registro la salida correctamente.';
								else 
                                set mensaje = 'Marcaje rechazado.';
								end if;
						else 
							set mensaje = 'Es muy temprano para marcar.';
						end case;
            end case;
		end if;
end if;
select mensaje;  

	
END ;;
DELIMITER ;   
SELECT DATEDIFF("2017-06-25", "2017-06-15");

SELECT  timediff(now(),TIMESTAMP("2017-07-23",  "13:10:11") );

UPDATE `cuenta` SET `cu_password` = SHA2('Gato bolador', 512) WHERE `cuenta`.`cu_id` = 1 AND `cuenta`.`id_perfil` = 1;
select * from cuenta where cu_password=SHA2('Gato bolador', 512) and `cuenta`.`cu_id` = 1 AND `cuenta`.`id_perfil` = 1;
SELECT SHA2('Gato bolador', 512);






DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `marcar`(
in us_nombre varchar(225), 
in us_apellido varchar(225), 
in us_cedula varchar(225),
in us_nacimiento date,
in us_correo varchar(45),
in us_telefono varchar(45),
in us_familiar varchar(45),
in us_telefonofamiliar int(12),
in us_color varchar(45),
in us_foto text,
in us_carrera varchar(512),
in us_nacionalidad varchar(4)
)
begin 
