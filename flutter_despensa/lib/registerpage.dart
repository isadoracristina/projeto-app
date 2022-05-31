import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'userpage.dart';
import 'api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  var api_service = ApiServices();

  var rememberValue = false;

  var inputname = TextEditingController();
  var inputlastname = TextEditingController();
  var inputmail = TextEditingController();
  var inputpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Criar uma conta',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Color.fromARGB(255, 241, 147, 58),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: inputname,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Nome',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: inputlastname,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Sobrenome',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: inputmail,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Endereço de email inválido",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: inputpassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, informe sua senha';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                          if (_formKey.currentState!.validate()) {
                            api_service.register(inputname.text,
                              inputmail.text, inputpassword.text);
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage(title: "titulo")));
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      shadowColor: const Color.fromARGB(255, 241, 147, 58),
                    ),
                    child: const Text(
                      'Registrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Já possui uma conta?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage(title: 'Login UI'),
                            ),
                          );
                        },
                        child: const Text(
                          'Faça Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 241, 147, 58),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
