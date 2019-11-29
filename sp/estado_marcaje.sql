Drop PROCEDURE estado_marcaje
DELIMITER ;;
CREATE PROCEDURE estado_marcaje(
    in cuenta int(11) 
)
BEGIN
    declare fecha date;
    declare perfil int(11);
    declare beca int(11);
    declare entrada int(11);
    declare salida int(11);
    declare almuerzo int(11);
    declare salAlmuerzo int(11);
    set fecha =(select date(now()));
    set perfil = (select id_perfil from cuenta where cu_id=cuenta);
    set beca=(select id_beca from perfil where pe_id=perfil);

    if beca=1 then
    set entrada = (select count(*) from marcado where id_cuenta=cuenta && id_parametrizado=1 && ma_fecha=fecha);
    set salida = (select count(*) from marcado where id_cuenta=cuenta && id_parametrizado=4 && ma_fecha=fecha);
    set almuerzo= (select count(*) from marcado where id_cuenta=cuenta && id_parametrizado=2 && ma_fecha=fecha);
    set salAlmuerzo=(select count(*) from marcado where id_cuenta=cuenta && id_parametrizado=3 && ma_fecha=fecha);
    else
    set entrada = (select count(*) from marcado where id_cuenta=cuenta && id_parametrizado=1 && ma_fecha=fecha);
    set salida = (select count(*) from marcado where id_cuenta=cuenta && id_parametrizado=4 && ma_fecha=fecha);
    end if;
    
    select entrada, salida, almuerzo, salAlmuerzo;
end;;

