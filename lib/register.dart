import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/login.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerFirst =
      TextEditingController();
  bool _validate = false;
  bool _validateNotEmpty = false;

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      wellcomeUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        wrongEmail();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        wrongPassword();
      }
    }

    Navigator.pop(context);
  }

  void wellcomeUser() {
    var user = FirebaseAuth.instance.currentUser!;
    var snackBar = SnackBar(
      content: Text('Selamat Datang ${user.email}'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void wrongEmail() {
    var snackBar = const SnackBar(
      content: Text('Email tidak ditemukan!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void wrongPassword() {
    var snackBar = const SnackBar(
      content: Text('Password salah!'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(fontSize: 25),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Tulis Email',
                        errorText: _validateNotEmpty ? 'Email tidak boleh kosong!' : null,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Password",
                      style: TextStyle(fontSize: 25),
                    ),
                    TextField(
                      obscureText: true,
                      controller: _passwordControllerFirst,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Tulis Password',
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ulangi Password",
                      style: TextStyle(fontSize: 25),
                    ),
                    TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Ulangi Password',
                        errorText: _validate ? 'Password harus sama!' : null,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _passwordController.text ==
                                _passwordControllerFirst.text
                            ? _validate = false
                            : _validate = true;
                        _emailController.text.isEmpty ? _validateNotEmpty = true : _validateNotEmpty = false;
                      });
                      print(_passwordController.text);
                      print(_passwordControllerFirst.text);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sudah punya akun?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
