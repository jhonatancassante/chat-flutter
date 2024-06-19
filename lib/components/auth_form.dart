import 'package:chat/models/auth_form_data.dart';
import 'package:chat/validations/email_validation.dart';
import 'package:chat/validations/name_validation.dart';
import 'package:chat/validations/password_validation.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
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
                validator: _formData.isSignup ? passwordValidation : null,
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
                  validator: (senha) {
                    if (_formData.password != senha) {
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
