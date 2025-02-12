enum Tipomovimentacao{
  ENTRADA,
  SAIDA,
  AJUSTE
}
Map<Tipomovimentacao, String> TipoMovimentacao = {
  Tipomovimentacao.values[0]: 'Entrada',
  Tipomovimentacao.values[1]: 'Saida',
  Tipomovimentacao.values[2]: 'Ajuste'
};