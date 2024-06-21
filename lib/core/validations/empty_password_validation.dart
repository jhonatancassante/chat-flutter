String? emptyPasswordValidation(String? password) {
  final passwordTemp = (password ?? '').trim();

  if (passwordTemp.isEmpty) {
    return 'A senha não pode estar vazia.';
  }

  return null;
}
