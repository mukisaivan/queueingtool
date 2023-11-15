import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:queueingtool/screens/login_screen.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 252, 112, 159),
        Color.fromARGB(255, 234, 117, 255)
      ])),
      child: Stack(
        children: [
          // Image.asset(
          //   "assets/images/mario.jpg",
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          //   color: Colors.black.withOpacity(0.3),
          //   colorBlendMode: BlendMode.darken,
          //   width: double.infinity,
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage(
                    "assets/logo/goldenq.png",
                  ),
                  // height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(height: 30),
                const SpinKitWave(
                  color: Color.fromARGB(255, 191, 0, 255),
                ),
                // const MyAnimatedImageWidget()
              ],
            ),
          )
        ],
      ),
    );
  }
}
