import 'package:flutter/material.dart';
import 'package:sistema_loginn/pages/login_page.dart';

class HomePage extends StatelessWidget{
    
    final String nomeUsuario;
    final String emailUsuario;
    
    const HomePage({
      super.key,
      required this.nomeUsuario,
      required this.emailUsuario
      
      });

    void sair(BuildContext context) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const LoginPage(),
        ),
      );
    }   

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Sistema'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.home, size: 100,),

                const SizedBox(height: 20,),

                const Text(
                  'Bem-vindo ao sistema!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  nomeUsuario,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),

                Text(
                  emailUsuario
                ),

                const SizedBox(height: 30,),

                

                  ElevatedButton.icon(
                    onPressed: () {
                      sair(context);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair'),
                  ),

              ],
            ),
          ),
        ),
      );
    }

}