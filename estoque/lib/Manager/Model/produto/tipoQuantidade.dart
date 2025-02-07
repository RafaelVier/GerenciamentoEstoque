enum  TipoQuantidade {
 KG,
 pacote,
 Litros,
 fardo;
}
Map<TipoQuantidade, String> TipoQuantidadeMap = {
  TipoQuantidade.values[0]: 'KG',
  TipoQuantidade.values[1]: 'pacote',
  TipoQuantidade.values[2]: 'Litros',
  TipoQuantidade.values[3]: 'fardo'
};
