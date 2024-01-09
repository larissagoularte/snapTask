import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Bem-vindo! Faça login para continuar.'),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authProvider.login(
                    context,
                    _emailController.text,
                    _passwordController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/home');
                } catch (e) {
                  print('Erro durante o login: $e');
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // cor de fundo do botão
                minimumSize:
                    Size(double.infinity, 50), // largura e altura mínimas
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Registar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // cor de fundo do botão
                minimumSize:
                    Size(double.infinity, 50), // largura e altura mínimas
              ),
            ),
          ],
        ),
      ),
    );
  }
}
