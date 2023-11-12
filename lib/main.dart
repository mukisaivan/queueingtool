import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queueingtool/constants/global_variables.dart';
import 'package:queueingtool/firebase_options.dart';
import 'package:queueingtool/router.dart';
import 'package:queueingtool/screens/login_screen.dart';
import 'package:queueingtool/screens/verification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QueingTool',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 82, 80, 68),
          ),
          textTheme:
              GoogleFonts.bubblegumSansTextTheme(Theme.of(context).textTheme)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const //HomePage()
                  Verification();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: GlobalVariables.primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
      onGenerateRoute: (settings) => genarateRoutes(settings),
    );
  }
}
