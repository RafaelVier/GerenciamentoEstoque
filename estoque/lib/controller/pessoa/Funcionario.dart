import 'package:flutter/foundation.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class Funcionario {
  String _iDFuncionario;
  String _nome;
  String _email;
  String _senha;

  Funcionario(this._iDFuncionario, this._nome, this._email, this._senha);

  factory Funcionario.mapFuncionario(Map<String, dynamic> map) {
    return Funcionario(
      map['IDFuncionario'], 
      map['nome'],
      map['email'],
      map['senha']
    );
  }

  String get iDFuncionario => _iDFuncionario;

  String get nome => _nome;
  set nome(String novoNome) {
    if (novoNome == '') {
      print('Nome não informado');
    } else {
      _nome = novoNome;
    }
  }

  String get email => _email;
  set email(String novoEmail) {
    if (novoEmail == '') {
      print('Email não informado');
    } else {
      _email = novoEmail;
    }
  }

  String get senha => _senha;
  set senha(String novaSenha) {
    if (novaSenha == '') {
      print('Senha não informada');
    } else {
      _senha = _hashSenha(novaSenha);
    }
  }

  String _hashSenha(String senha) {
    final bytes = utf8.encode(senha);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  String toString() {
    return 'ID: $_iDFuncionario\nNome: $_nome, Informações pessoais: Email: $_email';
  }
}
