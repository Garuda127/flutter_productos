import 'package:flutter/material.dart';
import 'package:flutter_productos/screens/screens.dart';
import 'package:flutter_productos/services/authservice.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);
  static String routerScreen = '/checkAuth';
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == '') {
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
              );
            } else {
              Future.microtask(
                () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
              );
            }
            return const Text('Espere');
          },
        ),
      ),
    );
  }
}
