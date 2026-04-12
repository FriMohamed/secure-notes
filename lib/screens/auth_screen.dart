import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'home_screen.dart';
class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    try {
      bool result = await auth.authenticate(
        localizedReason: 'Scan your fingerprint',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (result){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Test'),
      ),
      body: Center(
        child: IconButton(
          onPressed: _authenticate,
          icon: const Icon(Icons.fingerprint),
          iconSize: 150,
        ),
      ),
    );
  }
}