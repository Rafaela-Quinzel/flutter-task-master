import 'package:flutter/material.dart';
import '../services/auth.service.dart';

class AuthHelper {
  static Future<void> submitAuthForm({
    required BuildContext context,
    required String email,
    required String password,
    String? name,
    required bool isLogin,
  }) async {
    // 1. Validação básica de campos vazios
    if (email.isEmpty ||
        password.isEmpty ||
        (!isLogin && (name == null || name.isEmpty))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    try {
      final authService = AuthService();

      // 2. Decide qual rota tomar baseado no booleano
      if (isLogin) {
        print("Email: $email, Password: $password");
        await authService.loginUser(email: email, password: password);
      } else {
        print("Nome: $name, Email: $email, Password: $password");
        await authService.registerUser(
          email: email,
          password: password,
          name: name,
        );

        if (context.mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    } catch (e) {
      // 3. Trata os erros e mostra na tela
      String errorMessage = 'Ocorreu um erro inesperado.';

      // Personalizando mensagens do Firebase para algo mais amigável
      if (e.toString().contains('user-not-found') ||
          e.toString().contains('invalid-credential')) {
        errorMessage = 'E-mail ou senha incorretos.';
      } else if (e.toString().contains('email-already-in-use')) {
        errorMessage = 'Este e-mail já está cadastrado.';
      } else if (e.toString().contains('weak-password')) {
        errorMessage = 'A senha deve ter pelo menos 6 caracteres.';
      }

      // Mostra o erro visualmente usando o context
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
