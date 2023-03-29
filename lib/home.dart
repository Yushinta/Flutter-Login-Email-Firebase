import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton.icon(
          onPressed: signOut,
          icon: const Icon(Icons.login_rounded),
          label: const Text("Logout"),
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red.shade700)),
        ),
      ),
    );
  }
}
