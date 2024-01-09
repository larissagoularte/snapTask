import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Crie uma conta para começar.'),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 10),
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
                  await authProvider.register(
                    context,
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text,
                  );
                  // Após o registro, redirecione para a tela de login
                  Navigator.pushReplacementNamed(context, '/login');
                } catch (e) {
                  print('Erro durante o registro: $e');
                }
              },
              child: Text('Registrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // cor de fundo do botão
                minimumSize:
                    Size(double.infinity, 50), // largura e altura mínimas
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Redirecione para a tela de login
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Já tem uma conta? Faça login.'),
            ),
          ],
        ),
      ),
    );
  }
}
