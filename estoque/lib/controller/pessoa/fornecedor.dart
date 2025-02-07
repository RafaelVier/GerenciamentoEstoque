class Fornecedor {
  int ID;
  String Nome;
  String CNPJ;
  String Telefone;
  String email;
  Fornecedor(this.ID, this.Nome, this.CNPJ, this.Telefone, this.email);
  factory Fornecedor.mapFornecedor(Map<String, dynamic> map) {
    return Fornecedor(
        map['ID'], map['Nome'], map['CNPJ'], 
        map['Telefone'], map['email']);
  }
  @override
  String toString() {
    return "Nome: $Nome, CNPJ: $CNPJ, Telefone: $Telefone, Email: $email";
  }
}
