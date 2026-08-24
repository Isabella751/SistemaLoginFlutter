import 'package:flutter/material.dart';
import '../dados_mock.dart';
import '../services/api_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  bool esconderSenha = true;
  bool esconderConfirmacao = true;

  Future<void> cadastrar() async {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String senha = senhaController.text;
    String confirmaSenha = confirmaSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        senha.isEmpty ||
        confirmaSenha.isEmpty) {
      mostrarMensagem('Preencha todos os campos');
      return;
    }

    if (!email.contains('@')) {
      mostrarMensagem('Digite um e-mail válido');
      return;
    }

    if (senha.length < 4) {
      mostrarMensagem('A senha deve possuir pelo menos 4 caracteres.');
      return;
    }

    if (senha != confirmaSenha) {
      mostrarMensagem('As senha não são iguais.');
      return;
    }

    bool emailExiste = false;

    for (var usuario in usuarios) {
      if (usuario['email'] == email) {
        emailExiste = true;
        break;
      }
    }

    if (emailExiste) {
      mostrarMensagem('Já existe um usuário com esse e-mail');
      return;
    }

    // usuarios.add(
    //   {
    //     'nome': nome,
    //     'email': email,
    //     'senha': senha,
    //   }
    // );

    final resultado = await ApiService.cadastrar(
      nome: nome,
      email: email,
      senha: senha,
    );

    if (resultado['sucesso'] == true) {
      mostrarMensagem('Usuário cadastrado com sucesso!');
      Navigator.pop(context);
      return;
    }
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar((SnackBar(content: Text(mensagem))));
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmaSenhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar usuário'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.person_add, size: 90),

            const SizedBox(height: 15),

            const Text(
              'Criar conta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite seu nome',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.block),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  icon: Icon(
                    esconderSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmaSenhaController,
              obscureText: esconderConfirmacao,
              decoration: InputDecoration(
                labelText: 'Confirma senha',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderConfirmacao = !esconderConfirmacao;
                    });
                  },
                  icon: Icon(
                    esconderConfirmacao
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: cadastrar,
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text('Cadastrar', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar para o Login'),
            ),
          ],
        ),
      ),
    );
  }
}
