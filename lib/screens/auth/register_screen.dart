import 'package:flutter/material.dart';
import 'package:flutter_task_master/controllers/auth_controller.dart';
import 'package:flutter_task_master/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _controller = AuthController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return Form(
                  key: _controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.task_alt,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'TaskMaster',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Campo de Nome
                      CustomTextField(
                        label: 'Nome',
                        icon: Icons.person_outline,
                        controller: _controller.nameController,
                        validator: (val) => val == null || val.trim().isEmpty
                            ? 'Insira seu nome'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Campo de E-mail
                      CustomTextField(
                        label: 'E-mail',
                        icon: Icons.email_outlined,
                        controller: _controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty)
                            return 'Insira seu e-mail';
                          if (!val.contains('@')) return 'E-mail inválido';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo de Senha
                      CustomTextField(
                        label: 'Senha',
                        icon: Icons.lock_outline,
                        controller: _controller.passwordController,
                        isPassword: true,
                        validator: (val) => val != null && val.length < 6
                            ? 'A senha deve ter pelo menos 6 caracteres'
                            : null,
                      ),
                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _controller.isLoading
                            ? null
                            : () => _controller.submit(context, isLogin: false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        child: _controller.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text(
                                'Cadastrar',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),

                      TextButton(
                        onPressed: _controller.isLoading
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                        child: const Text(
                          'Já tem uma conta? Faça login',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
