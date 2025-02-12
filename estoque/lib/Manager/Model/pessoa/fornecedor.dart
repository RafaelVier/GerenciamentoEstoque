class Fornecedor {
  int ID;
  String Nome;
  String CNPJ;
  String Telefone;
  String Email;
  Fornecedor({
    required this.ID,
    required this.Nome,
    required this.CNPJ,
    required this.Telefone,
    required this.Email,
  });
  set nome (String novoNome){
    novoNome == '' ? print('Nome não informado') : Nome = novoNome;
  }

  set cnpj (String novoCNPJ){
    novoCNPJ == '' ? print('CNPJ não informado') : CNPJ = novoCNPJ;
  }

  set telefone (String novoTelefone){
    novoTelefone == '' ? print('Telefone não informado') : _Telefone = novoTelefone;
  }

  set email (String novoEmail){
    novoEmail == '' ? print('Email não informado') : _Email = novoEmail;
  }

  factory Fornecedor.fromMap(Map<String, dynamic> map) {
    return Fornecedor(
      ID: map['ID']?? 0,
      Nome: map['Nome']??'',
      CNPJ: map['CNPJ']??'',
      Telefone: map['Telefone']??'',
      Email: map['Email']??'',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'Nome': Nome,
      'CNPJ': CNPJ,
      'Telefone': Telefone,
      'Email': Email,
    };
  }
 
  @override
  String toString() {
    return "Nome: $Nome, CNPJ: $CNPJ\nTelefone: $Telefone, Email: $Email";
  }
}
