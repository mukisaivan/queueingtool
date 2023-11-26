import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:queueingtool/firebase_options.dart';
import 'package:queueingtool/router.dart';
import 'package:queueingtool/screens/splash_screen.dart';
import 'package:queueingtool/screens/verification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QueVex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 237, 135, 255),
        ),
        textTheme:
            GoogleFonts.bubblegumSansTextTheme(Theme.of(context).textTheme),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const Verification();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitWave(
                color: Color.fromARGB(255, 191, 0, 255),
              ),
            );
          }
          return const SplashScreen();
        },
      ),
      onGenerateRoute: (settings) => genarateRoutes(settings),
    );
  }
}
