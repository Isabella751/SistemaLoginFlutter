import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Android Emulator
  // static const String baseUrl = 'http://10.0.2.2:3000';

  // Celular físico:
  // static const String baseUrl = 'http://10.106.75.47:3000';

  static const String baseUrl = 'http://localhost:3000';

  static Future<Map<String, dynamic>> login({
    required String email,
    required String senha,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/login');

      final dados = {'email': email.trim(), 'senha': senha};

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(dados),
      );

      Map<String, dynamic> resposta = {};

      if (response.body.isNotEmpty) {
        try {
          resposta =
              jsonDecode(utf8.decode(response.bodyBytes))
                  as Map<String, dynamic>;
        } catch (_) {
          return {
            'sucesso': false,
            'mensagem': 'Resposta inválida do servidor.',
          };
        }
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {'sucesso': true, 'dados': resposta};
      }

      return {
        'sucesso': false,
        'mensagem': resposta['mensagem'] ?? 'E-mail ou senha incorretos.',
      };
    } catch (erro) {
      return {
        'sucesso': false,
        'mensagem': 'Não foi possível conectar ao servidor.',
      };
    }
  }

  static Future<Map<String, dynamic>> cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final dados = {'nome': nome, 'email': email, 'senha': senha};

    try {
      final url = Uri.parse('$baseUrl/usuarios');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(dados),
      );

      Map<String, dynamic> resposta = {};

      if (response.body.isNotEmpty) {
        resposta = jsonDecode(utf8.decode(response.bodyBytes));
      }

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return {'sucesso': true, 'dados': resposta};
      }

      return {
        'sucesso':false,
        'mensagem': 'Não foi possível cadastrar o usuário.',
      };
    } catch (e) {
      return {
        'sucesso': false,
        'mensagem': 'Não foi possível conectar ao servidor.',
      };
    }
  }
}
