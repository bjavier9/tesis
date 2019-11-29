
drop procedure admin_ver;
DELIMITER ;;
CREATE PROCEDURE admin_ver (

)
BEGIN
    DECLARE finished INTEGER DEFAULT 0;
        DECLARE counter INT DEFAULT 1;
    DECLARE emailAddress varchar(100) DEFAULT "";
    declare emailList varchar(4000);
    declare hora_total time;
    declare hora time;
    declare fecha date;
    declare parametro int; 
    declare total int;
    declare cuenta int(11);
    declare hora_entrada time;
    declare hora_salida time;
    declare tardanzas int(11);
    declare puntuales int(11);
    declare no_marco int(11);
    declare aucensias int(11);
    declare indicador varchar(23);
    DECLARE curMarcado CURSOR FOR 
            SELECT id_cuenta,ma_hora, ma_fecha,id_parametrizado, ma_indicador FROM marcado;
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;       
        drop temporary table if exists tempTable1;
    CREATE TEMPORARY TABLE tempTable1(
       id INT NOT NULL AUTO_INCREMENT,
       id_cuenta int(11),
       hora_entrada time null,
       hora_salida time null,
       fecha date null,
       parametro varchar(13) null,
       total_horas int(11) null,
       tardanzas int(11) null,
       puntuales int(11) null,
       no_marco int(11) null,
       aucensias int(11) null,
       PRIMARY KEY ( id )
    )engine=memory;
    OPEN curMarcado;
    getMarcado: LOOP
        FETCH curMarcado INTO cuenta,hora,fecha, parametro, indicador;
         IF finished = 1 THEN 
            LEAVE getMarcado;
        END IF; 
        CASE 
                    when (indicador='t' or indicador='ast')  then
                        INSERT tempTable1(id,id_cuenta,fecha,parametro,tardanzas,puntuales,no_marco,aucensias)
                        VALUES(null,cuenta,fecha,parametro,1,0,0,0);
                    when indicador='p' then
                        INSERT tempTable1(id,id_cuenta,fecha,parametro, tardanzas,puntuales,no_marco,aucensias)
                        VALUES(null,cuenta,fecha,parametro,0,1,0,0);
                    when indicador='nmt' then 
                           INSERT tempTable1(id,id_cuenta,fecha,parametro,tardanzas,puntuales,no_marco,aucensias)
                            VALUES(null,cuenta,fecha,parametro,0,0,1,0);
                    when (indicador='au' && parametro=4) then 
                               INSERT tempTable1(id,id_cuenta,fecha,parametro,tardanzas,puntuales,no_marco,aucensias)
                                VALUES(null,cuenta,fecha,parametro,0,0,0,1);
                                ELSE BEGIN END;
                    end case;
        if parametro=1 then 
        INSERT tempTable1(id,id_cuenta, hora_entrada, hora_salida, fecha,total_horas, tardanzas,puntuales,no_marco,aucensias)
        VALUES(null, cuenta,hora, (select ma_hora from marcado where id_parametrizado=4 and ma_fecha=fecha ), fecha,(select EXTRACT(hour from TIMEDIFF((select ma_hora from marcado where id_parametrizado=4 and ma_fecha=fecha), hora))),0,0,0,0);
        end if;
            
    END LOOP getMarcado;
    
    CLOSE curMarcado;
call helper_admin ();

END;;
DELIMITER ;


call admin_ver()





drop procedure helper_admin
DELIMITER ;;
CREATE PROCEDURE helper_admin (
)
BEGIN
select id_cuenta,sum(total_horas) as total_horas,sum(tardanzas) as tardanzas, sum(puntuales) as puntuales,
 sum(no_marco) as no_marco ,sum(aucensias) as aucencias from tempTable1 group by id_cuenta;
drop temporary table if exists tempTable1;
end;;
