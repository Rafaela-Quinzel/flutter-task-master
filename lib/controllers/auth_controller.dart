import 'package:flutter/material.dart';
import 'package:flutter_task_master/helpers/auth_helper.dart';

class AuthController extends ChangeNotifier {
  // 1. Controladores para TODOS os campos possíveis
  final TextEditingController nameController =
      TextEditingController(); // Usado só no cadastro
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  // 2. Adicionamos o "isLogin" como parâmetro na função
  Future<void> submit(BuildContext context, {required bool isLogin}) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    // 3. Repassamos os dados para o Helper
    await AuthHelper.submitAuthForm(
      context: context,
      name: isLogin
          ? null
          : nameController.text.trim(), // Só envia o nome se for cadastro
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      isLogin: isLogin, // Repassa o booleano adiante!
    );

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
