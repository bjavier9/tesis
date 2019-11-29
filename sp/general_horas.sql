Drop PROCEDURE horas_generales
DELIMITER ;;
CREATE PROCEDURE horas_generales(
    in cuenta int(11) 
)
BEGIN
declare tardanzas int(11);
declare puntuales int(11);
declare no_marco int(11);
declare aucensias int(11);
set tardanzas =(select count(*) from marcado where id_cuenta=cuenta && ma_indicador='t'or ma_indicador='ast');
set puntuales =(select count(*) from marcado where id_cuenta=cuenta && ma_indicador='p');
set no_marco = (select count(*) from marcado where id_cuenta=cuenta && ma_indicador='nmt' );
set aucensias=(select count(*) from marcado where id_cuenta=cuenta && ma_indicador='au' && id_parametrizado=1); 
select tardanzas, puntuales, no_marco, aucensias;
END;;
DELIMITER ;