// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers pour chaque champ
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Action pour revenir en arrière
          },
        ),
        title: const Text("Retour", style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              // Action pour créer un compte
            },
            child: const Text(
              "Créer un compte",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.lock, size: 80, color: Colors.blue),
            const SizedBox(height: 30),

            // Champ Prénom
            _buildTextField("Prénom", Icons.person, firstNameController),

            // Champ Nom
            _buildTextField("Nom", Icons.person, lastNameController),

            // Champ Email
            _buildTextField("Email", Icons.email, emailController),

            // Champ Mot de passe
            _buildTextField("Mot de passe", Icons.lock, passwordController,
                obscureText: true),

            // Champ Confirmation mot de passe
            _buildTextField(
                "Confirmer mot de passe", Icons.lock, confirmPasswordController,
                obscureText: true),

            const SizedBox(height: 20),

            // Bouton S'inscrire
            ElevatedButton(
              onPressed: () {
                // Action pour s'inscrire
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("S'inscrire"),
            ),

            const SizedBox(height: 20),
            const Text("Ou"),

            const SizedBox(height: 20),

            // Bouton Se connecter avec Google
            _buildSocialButton(
              "Se connecter avec Google",
              "assets/google_logo.png",
              Colors.white,
              Colors.black,
              () {
                // Action pour se connecter avec Google
              },
            ),

            const SizedBox(height: 10),

            // Bouton Se connecter avec Apple
            _buildSocialButton(
              "Se connecter avec Apple",
              "assets/apple_logo.png",
              Colors.white,
              Colors.black,
              () {
                // Action pour se connecter avec Apple
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour construire un champ de texte
  Widget _buildTextField(
    String hintText,
    IconData icon,
    TextEditingController controller, {
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Fonction pour construire un bouton de connexion sociale
  Widget _buildSocialButton(
    String text,
    String logoPath,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(logoPath, height: 24),
      label: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
