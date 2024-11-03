// // ignore_for_file: avoid_print, unused_field

// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Inscription',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const InscriptionPage(),
//     );
//   }
// }

// class InscriptionPage extends StatefulWidget {
//   const InscriptionPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _InscriptionPageState createState() => _InscriptionPageState();
// }

// class _InscriptionPageState extends State<InscriptionPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? _username;
//   String? _password;

//   Future<User?> _signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser!.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
//   }

//   Future<User?> _signInWithApple() async {
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//     );
//     final oauthCredential = OAuthProvider("apple.com").credential(
//       idToken: credential.identityToken,
//       accessToken: credential.authorizationCode,
//     );
//     return (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
//         .user;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Formulaire d\'inscription'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 decoration:
//                     const InputDecoration(labelText: 'Nom d\'utilisateur'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Veuillez entrer votre nom d\'utilisateur';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _username = value,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Mot de passe'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Veuillez entrer votre mot de passe';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _password = value,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     _formKey.currentState?.save();
//                     // Traite les données
//                   }
//                 },
//                 child: const Text('S\'inscrire'),
//               ),
//               const SizedBox(height: 20),
//               SignInButton(
//                 Buttons.Google,
//                 text: "Connexion avec Google",
//                 onPressed: () async {
//                   User? user = await _signInWithGoogle();
//                   if (user != null) {
//                     print("Connecté avec Google: ${user.email}");
//                   }
//                 },
//               ),
//               SignInButton(
//                 Buttons.Apple,
//                 text: "Connexion avec Apple",
//                 onPressed: () async {
//                   User? user = await _signInWithApple();
//                   if (user != null) {
//                     print("Connecté avec Apple: ${user.email}");
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
