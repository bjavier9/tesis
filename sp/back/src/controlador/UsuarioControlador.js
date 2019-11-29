'use strict';

var Usuario = require('../modelo/UsuarioModelo');
const CONFIG = require('../config/config'); 
const jwt = require('jsonwebtoken');

/** 
 * Lenny Kravitz - Again
 * I been searching for you
I heard a cry within my soul
I never had a yearning quite like this before
Now that you are walking right through my door
 * */
exports.login_usuario = function(req, res) {
  const {usuario,password} = req.body;
  console.log(usuario);
  Usuario.login_usuario(usuario, password, function(err, resp) {
    if (err)
      res.send(err);
    
     
      console.log(resp[3])
      
      if(resp[5][0].login == 0){
        res.status(401).send({ error: true, message: 'Usuario o password incorrectos.' });
      }else{   
      let payload = { "rol":resp[5][0].rol,"cuenta":resp[5][0].cuenta };
      let token = jwt.sign(payload, CONFIG.jwt_encryption,{ expiresIn: '1h' });
      var decoded = jwt.verify(token, CONFIG.jwt_encryption);

        console.log(decoded)
        res.json({ msg: resp[3][0].mensaje, token: token, rol:decoded.rol });
      }
    
  });
};

exports.perfil_usuario = function(req,res){
  jwt.verify(req.params.token, CONFIG.jwt_encryption, function(err, decoded) {
    if (err) {
      res.status(400).send({ error: true, message: 'Error de token' });
    }else{
Usuario.perfil(decoded.cuenta,  function(err, resp) {
    if (err)
      res.send(err);
      // verificamo el correo papu
      if(resp.length == 0)res.status(400).send({ error: true, message: 'Error de token' });
      res.json(resp[0][0]);
  })
    }
  });
  

}


exports.crear_usuario = function (req, res) {
  var Nuevo_usuario = new Usuario(req.body);
  Usuario.Verifica_correo(Nuevo_usuario.usuario_correo, function(err, resp) {
    if (err)
      res.send(err);
      // verificamo el correo papu
      if(resp.length == 0){
        if (!Nuevo_usuario.usuario_nombre || !Nuevo_usuario.usuario_cedula || !Nuevo_usuario.usuario_telefono || !Nuevo_usuario.usuario_movil || !Nuevo_usuario.usuario_imagen||!Nuevo_usuario.usuario_password||!Nuevo_usuario.usuario_correo) {

          res.status(400).send({ error: Nuevo_usuario, message: 'Faltan datos' });
      
        }
        else {
      
          Usuario.crearUsuario(Nuevo_usuario, function (err, usuario) {
      
            if (err)
              res.send(err);
            res.json(usuario);
          });
        }
      }else{
        // retornomos el mensaje de que ya existe este correo
        res.status(401).send({ error: true, message: 'Este correo ya existe.' });
      }
 
  });
  

};
exports.test = function (req, res) {
    res.status(200).send({message: 'bien perro.' });
  }
