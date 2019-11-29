'user strict';
var sql = require('../config/db');

var Usuario = function (usuario) {
    this.usuario_nombre = usuario.nombre;
    this.usuario_cedula = usuario.cedula;
    this.usuario_telefono = usuario.telefono;
    this.usuario_ubicacion = usuario.ubicacion;
    this.usuario_movil = usuario.movil;
    this.usuario_imagen = usuario.imagen;
    this.usuario_correo = usuario.correo;
    this.usuario_password = usuario.password;
};
Usuario.Verifica_correo = function (correo, result) {
    sql.query("select usuario_nombre FROM usuarios WHERE usuario_correo = ? ", correo, function (err, res) {             
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{                
                result(null, res);
          
            }
        });   
};
Usuario.login_usuario = function (username, password, result) {
    sql.query("SET @st = 0; set @cuenta = 0; set @rol=0; CALL login(?,?,@st,@cuenta,@rol); select @st as login, @cuenta as cuenta, @rol as rol;",  
    [username, password], function (err, res) {
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{                
                result(null, res);
          
            }
        });   
};
Usuario.crearUsuario = function (nuevoUsuario, result) {
    sql.query("INSERT INTO usuarios set ?", nuevoUsuario, function (err, res) {

        if (err) {
            console.log("error: ", err);
            result(err, null);
        }
        else {
            console.log(res.insertId);
            result(null, res.insertId);
        }
    });
};

Usuario.perfil = function (cuenta, result) {
    sql.query(" call perfil(?); ", [cuenta], function (err, res) {             
            if(err) {
                console.log("error: ", err);
                result(err, null);
            }
            else{                
                result(null, res);
          
            }
        });   
};
module.exports = Usuario;