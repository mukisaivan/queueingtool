import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueingtool/screens/counter_screen.dart';
import 'package:queueingtool/screens/customer_first_screen.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String? userRole;

  @override
  void initState() {
    super.initState();
    userModeCheck();
  }

  userModeCheck() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

    final data = snapshot.data();

    setState(() {
      userRole = data!["role"] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return userRole == "admin" ? const AdminPage() : const HomePage();
    if (userRole == "admin") {
      return const CounterScreen();
    } else {
      return const CustomerFirstScreen();
    }
  }
}
