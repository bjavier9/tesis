use asistencia;
drop procedure if exists marcar 
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
				if salida<hora_actual then
                 set mensaje = 'Se registro un incidente.';
                 INSERT INTO `incidencia` (`idincidencia`, `cuenta_id`, `descripcion`, `fecha`) VALUES (NULL,cuenta, 'Intentando marcar despues del horario.', CURRENT_TIMESTAMP);
                else
                    if  entrada<hora_actual then
                        INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 't', 1);
                        set mensaje = 'Se registro correctamente su entrada.';
                    else
                        INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'p', 1);
                        set mensaje = 'Se registro correctamente su entrada.';
                    end if;    
                 end if;
				when ((select count(ma_indicador) from marcado where   id_cuenta=cuenta and ma_fecha = DATE(now()) and id_parametrizado=1 and ma_indicador='p' or ma_indicador='t')=1) and beca=100 then
                   if  minimo_hora<hora_actual then
                   set mensaje = 'No puedes marcar almuerzo. Se registro su salida. Se registro un incidente.';
					   INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'nmt', 2);
					   INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 'nmt', 3);
                       INSERT INTO marcado VALUES (NULL, cuenta,TIME(now()), DATE(now()), 's', 4);
                       INSERT INTO `incidencia` (`idincidencia`, `cuenta_id`, `descripcion`, `fecha`) VALUES (NULL,cuenta, 'Este usuario no esta marcando almuerzo.', CURRENT_TIMESTAMP);
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