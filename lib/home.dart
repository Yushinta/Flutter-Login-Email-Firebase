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

  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selamat Datang ${user.email}",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton.icon(
                onPressed: signOut,
                icon: const Icon(Icons.login_rounded),
                label: const Text("Logout"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.red.shade700)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
