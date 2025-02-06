//import 'dart:io';
/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Pessoa {
  int _iDPessoa;
  String _nome;
  String _telefone;
  String _email;

  /*static List<Pessoa> listaPessoas = [];*/
  Pessoa(this._iDPessoa, this._nome, this._telefone, this._email);
  int get iDPessoa => _iDPessoa;
  set iDPessoa(int novoId) {
    novoId == null ? print("ID não pode ser nulo") : _iDPessoa = novoId;
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