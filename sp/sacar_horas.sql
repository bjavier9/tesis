DELIMITER ;;
CREATE PROCEDURE createHoraTotales (
    in cuenta int(11) 
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
    declare hora_entrada time;
    declare hora_salida time;
    DECLARE curMarcado CURSOR FOR 
            SELECT ma_hora, ma_fecha,id_parametrizado FROM marcado where id_cuenta=cuenta; 
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;       
        drop temporary table if exists tempTable1;
    CREATE TEMPORARY TABLE tempTable1(
       id INT NOT NULL AUTO_INCREMENT,
       hora_entrada time null,
       hora_salida time null,
       fecha date null,
       total_horas int(11) null,
       PRIMARY KEY ( id )
    )engine=memory;
    OPEN curMarcado;
    getMarcado: LOOP
        FETCH curMarcado INTO hora,fecha, parametro;
         IF finished = 1 THEN 
            LEAVE getMarcado;
        END IF;
         
        if parametro=1 then 
        
        INSERT tempTable1(id, hora_entrada, hora_salida, fecha,total_horas)
        VALUES(null, hora, (select ma_hora from marcado where id_parametrizado=4 and ma_fecha=fecha ), fecha,(select EXTRACT(hour from TIMEDIFF((select ma_hora from marcado where id_parametrizado=4 and ma_fecha=fecha), hora))));
        end if;
            
    END LOOP getMarcado;
    
    CLOSE curMarcado;

select sum(total_horas) as total from tempTable1;


END;;
DELIMITER ;