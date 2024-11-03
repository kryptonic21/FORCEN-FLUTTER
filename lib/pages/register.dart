import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:test/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'S\'inscrire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Retour'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Form(
          child: Column(
            children: <Widget>[
              // const Text('S\'inscrire'),
              IconButton(
                icon: const Icon(
                  Icons.lock,
                  size: 90, // Taille de l'icône agrandie
                  color: Color(0xFF6C9FEE), // Couleur de l'icône
                ),
                onPressed: () {
                  // Naviguer en arrière si besoin
                  // Navigator.pop(context); // retour en arrière
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prenom & Nom'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Nom d\'utilisateur'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Confirmer Mot de passe'),
                obscureText: true,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF6C9FEE), // Couleur de fond du bouton
                ),
                onPressed: () {
                  // Action pour le bouton S'inscrire (à définir si nécessaire)
                },
                child: const Text(
                  'Connexion',
                  style: TextStyle(
                    color: Colors.white, // Couleur du texte cliquable
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Déja Inscris? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Se Connecter',
                      style: TextStyle(
                        color: Color(0xFF6C9FEE), // Couleur du texte cliquable
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text('Ou'),
              SignInButton(
                Buttons.Google,
                text: "Connexion avec Google",
                onPressed: () {
                  // Action pour la connexion avec Google (à définir si nécessaire)
                },
              ),
              const SizedBox(height: 20),
              SignInButton(
                Buttons.Apple,
                text: "Connexion avec Apple",
                onPressed: () {
                  // Action pour la connexion avec Apple (à définir si nécessaire)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
