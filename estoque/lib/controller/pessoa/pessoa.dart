import 'dart:io';
class Pessoa{
  int _iDPessoa;
  String _nome;
  String _telefone;
  String _email;
  String _documento;
  Pessoa(this._iDPessoa,this._nome,this._telefone,this._email,this._documento);
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
  set documento(String novoDocumento){
    _documento = novoDocumento;
  }
  void ToString(){
    print('Nome:$_nome, '
    'Documento:$_documento,'
    'Informações pessoais: ''telefone:$_telefone, ''Email:$_email');
  }

}