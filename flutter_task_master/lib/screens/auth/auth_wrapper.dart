import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Enquanto o Firebase verifica o status (Carregando)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Se houver um erro técnico ou falha de conexão
        if (snapshot.hasError) {
          // Aqui você pode logar o erro no console para saber o que houve
          debugPrint("Erro no Firebase Auth: ${snapshot.error}");
          //return LoginScreen();
        }

        // 3. Se o usuário estiver logado com sucesso
        if (snapshot.hasData && snapshot.data != null) {
          //return const TaskListPage();
        }

        // 4. DESTINO PADRÃO: Se não cair em nenhum dos itens acima,
        // ou se o usuário não estiver logado, vai para o Login.
        //return LoginScreen();
        return const Scaffold(
          body: Center(child: Text("Tela de Login ou Home")),
        );
      },
    );
  }
}
