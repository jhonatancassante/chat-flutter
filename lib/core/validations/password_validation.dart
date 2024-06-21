String? passwordValidation(String? password) {
  final passwordTemp = password ?? '';
  final passwordSize = passwordTemp.trim().length;
  String? response;
  String responseStart = 'A senha deve:\n';
  const min = 8;
  const max = 24;
  final oneUppercase = RegExp(r'^(?=.*?[A-Z]).{1,}$');
  final oneLowercase = RegExp(r'^(?=.*?[a-z]).{1,}$');
  final oneDigit = RegExp(r'^(?=.*?[0-9]).{1,}$');
  final oneSpecial = RegExp(r'^(?=.*?[!@#$&_-]).{1,}$');

  if (passwordSize < min || passwordSize > max) {
    response ??= responseStart;
    response += '- Ter entre $min e $max caracteres.\n';
  }

  if (!oneUppercase.hasMatch(passwordTemp)) {
    response ??= responseStart;
    response += '- Conter uma letra maiúscula.\n';
  }

  if (!oneLowercase.hasMatch(passwordTemp)) {
    response ??= responseStart;
    response += '- Conter uma letra minúscula.\n';
  }

  if (!oneDigit.hasMatch(passwordTemp)) {
    response ??= responseStart;
    response += '- Conter um número.\n';
  }

  if (!oneSpecial.hasMatch(passwordTemp)) {
    response ??= responseStart;
    response += '- Conter um caractere especial (!@#\$&_-).';
  }

  return response;
}
