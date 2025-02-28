import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/core/validations/email_validation.dart';
import 'package:chat/core/validations/empty_password_validation.dart';
import 'package:chat/core/validations/name_validation.dart';
import 'package:chat/core/validations/password_validation.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) => _formData.image = image;

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return showError('Imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: nameValidation,
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(
                  labelText: 'E-Mail',
                ),
                validator: emailValidation,
              ),
              TextFormField(
                key: const ValueKey('password'),
                onChanged: (password) => _formData.password = password,
                initialValue: _formData.password,
                obscureText: _formData.obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _formData.obscurePassword = !_formData.obscurePassword;
                      });
                    },
                    child: Icon(
                      _formData.obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: _formData.isSignup
                    ? passwordValidation
                    : emptyPasswordValidation,
              ),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('passwordConfirm'),
                  onChanged: (passwordC) =>
                      _formData.passwordConfirm = passwordC,
                  initialValue: _formData.passwordConfirm,
                  obscureText: _formData.obscurePasswordConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirme Senha',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _formData.obscurePasswordConfirm =
                              !_formData.obscurePasswordConfirm;
                        });
                      },
                      child: Icon(
                        _formData.obscurePasswordConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (password) {
                    final passwordTemp = password ?? '';
                    if (_formData.password != passwordTemp) {
                      return 'As senhas não coincidem.';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: _submit,
                child: Text(
                  _formData.isLogin ? 'Entrar' : 'Cadastrar',
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                    _formKey.currentState?.save();
                    _formKey.currentState?.reset();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
