import 'package:supabase_flutter/supabase_flutter.dart';

class Fornecedor {
  int _ID;
  String _Nome;
  String _CNPJ;
  String _Telefone;
  String _Email;
  Fornecedor(this._ID, this._Nome, this._CNPJ, this._Telefone, this._Email);
  int get ID => _ID;
  String get nome => _Nome;
  set nome (String novoNome){
    novoNome == '' ? print('Nome não informado') : _Nome = novoNome;
  }
  String get CNPJ => _CNPJ;
  set CNPJ (String novoCNPJ){
    novoCNPJ == '' ? print('CNPJ não informado') : _CNPJ = novoCNPJ;
  }

  String get Telefone => _Telefone;
  set Telefone (String novoTelefone){
    novoTelefone == '' ? print('Telefone não informado') : _Telefone = novoTelefone;
  }

  String get email => _Email;
  set email (String novoEmail){
    novoEmail == '' ? print('Email não informado') : _Email = novoEmail;
  }

  factory Fornecedor.mapFornecedor(Map<String, dynamic> map) {
    return Fornecedor(
        map['ID'], map['Nome'], map['CNPJ'], 
        map['Telefone'], map['Email']);
  }
  @override
  String toString() {
    return "Nome: $_Nome, CNPJ: $_CNPJ, Telefone: $_Telefone, Email: $_Email";
  }
  factory Fornecedor.fromJson(Map<String, dynamic> json) {
    return Fornecedor(
        json['ID'], json['Nome'], json['CNPJ'], 
        json['Telefone'], json['Email']);
  }
}
