import 'package:flutter/foundation.dart';

import 'pessoa.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class Funcionario {
  int _IDFuncionario;
  String _nome;
  String _telefone;
  String _email;
  String _senha;
  String _login;

  Funcionario(this._IDFuncionario, this._nome, this._telefone, this._email,
      this._login, this._senha);

  factory Funcionario.mapFuncionario(Map<String, dynamic> map) {
    return Funcionario(map['IDFuncionario'], map['nome'], map['telefone'],
        map['email'], map['login'], map['senha']);
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

  String get login => _login;
  set login(String novoLogin) {
    novoLogin == '' ? print('Login não informado') : _login = novoLogin;
  }

  String get senha => _senha;
  set senha(String novaSenha) {
    novaSenha == '' ? print('Senha não informada') : _senha = novaSenha;
  }

  bool verificarSenha(String senhaFornecida) {
    var bytes = utf8.encode(senhaFornecida);
    var digest = sha256.convert(bytes);
    return _senha == digest.toString();
  }

  @override
  String toString() {
    return 'Nome:$_nome,Informações pessoais: telefone:$_telefone, Email:$_email';
  }
}
