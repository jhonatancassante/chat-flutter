String? nameValidation(String? name) {
  final nameTemp = name ?? '';
  const min = 5;

  if (nameTemp.trim().length < min) {
    return 'Nome deve ter no mínimo $min caracteres.';
  }

  return null;
}
