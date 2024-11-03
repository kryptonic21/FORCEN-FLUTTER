import 'package:flutter/material.dart';
import 'package:test/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // retour en arrière
          },
        ),
        title: const Text('Retour'),
      ),
      body: Center(
        // Centrer tous les éléments
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centrer verticalement
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 40),
              ),
              const SizedBox(height: 16),
              const Text(
                'FORCE N',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text('flutter.forcen@gmail.com'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Rediriger vers la page d'inscription
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    // MaterialPageRoute(
                    // builder: (context) => const RegistrationPage()),
                  );
                },
                child: const Text('Déconnexion'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Gérer la synchronisation du compte
                },
                child: const Text('Synchronisation du compte'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Gérer la notification de rappel
                },
                child: const Text('Notification de rappel'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Gérer le partage de l'application
                },
                child: const Text('Partager l’application'),
              ),
              const SizedBox(height: 16),
              const Text('version 1.0.0'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Listes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Nouvelle classe pour la page d'inscription
// class RegistrationPage extends StatelessWidget {
//   const RegistrationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Inscription'),
//       ),
//       body: const Center(
//         child: Text('Page d\'inscription ici.'),
//       ),
//     );
//   }
// }
