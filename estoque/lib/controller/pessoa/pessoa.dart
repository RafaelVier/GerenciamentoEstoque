/*import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:convert'; 
import 'package:flutter/material.dart';
class Pessoa{
  int _iDPessoa;
  String _nome;
  String _telefone;
  String _email;
  String _documento;
  String _senha;
  String _login;
  static List<Pessoa> listaPessoas = [];
  Pessoa(this._iDPessoa, this._nome, this._telefone, this._email, this._documento, this._senha, this._login){
    this._senha = senha;
  }
  String get login => _login;
  set login(String novoLogin){
    if(novoLogin.isNotEmpty){
      _login = novoLogin;
    }else{
      throw Exception('Login não pode ser vazio');
    }
  }
  String get senha => _senha;
  set senha(String novaSenha){
    if (novaSenha.isNotEmpty) {
      var bytes = utf8.encode(novaSenha); // data being hashed
      var digest = sha256.convert(bytes);
      _senha = digest.toString();
    } else {
      throw Exception('Senha não pode ser vazio');
    }
  }
   bool verificarSenha(String senhaFornecida) {
    var bytes = utf8.encode(senhaFornecida);
    var digest = sha256.convert(bytes);
    return _senha == digest.toString();
  }
  int get iDPessoa =>_iDPessoa;
  set iDPessoa(int novoId){
    _iDPessoa = novoId;
  }
  String get nome => _nome;
  set nome(String novoNome){
    _nome = novoNome;
  }
  String get telefone => _telefone;
  set telefone(String novoTelefone){
    _telefone = novoTelefone;
  }
  String get email =>_email;
  set email(String novoEmail){
    _email = novoEmail;
  }
  String get documento => _documento;
  set documento(String novoDocumento ){
    _documento = novoDocumento;
  }
 
  @override
  String ToString(){
    return'Nome:$_nome, '
    'Documento:$_documento,'
    'Informações pessoais: ''telefone:$_telefone, '
    'Email:$_email';
  }

  factory Pessoa.mapPessoa(Map<String, dynamic> map) {
    return Pessoa(
      map['iDPessoa'],
      map['nome'],
      map['telefone'],
      map['email'],
    );
  }
  String get nome => _nome;
  set nome(String novoNome) {
    novoNome == '' ? print('Nome não informado') : _nome = novoNome;
  }

  String get telefone => _telefone;
  set telefone(String novoTelefone) {
    _telefone = novoTelefone;
  }

  String get email => _email;
  set email(String novoEmail) {
    novoEmail == '' ? print('Email não informado') : _email = novoEmail;
  }

  @override
  String toString() {
    return 'Nome:$_nome,Informações pessoais: telefone:$_telefone, Email:$_email';
  }
}
*/