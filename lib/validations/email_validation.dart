String? emailValidation(String? email) {
  final emailTemp = email ?? '';
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

  if (!emailRegex.hasMatch(emailTemp)) {
    return 'O e-mail deve ser válido.';
  }

  return null;
}
