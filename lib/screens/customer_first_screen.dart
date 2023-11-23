import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueingtool/common/loading.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/screens/customer_screen.dart';
import 'package:queueingtool/screens/service_widgets.dart';
import 'package:queueingtool/screens/turnto_premium_screen.dart';

class CustomerFirstScreen extends StatefulWidget {
  static const routeName = "/customer-first-screen";
  const CustomerFirstScreen({super.key});

  @override
  State<CustomerFirstScreen> createState() => _CustomerFirstScreenState();
}

class _CustomerFirstScreenState extends State<CustomerFirstScreen> {
  Future<Widget> checkUserAccountStatus() async {
    var userSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    var data = userSnap.data();
    var accountType = data!['accountType'];
    if (accountType == "Premium") {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, TurnToPremiumScreen.routeName);
        },
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 255, 179, 0))),
        child: const Text("Update to Premium"),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Order Screen"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 255, 112, 160),
          Color.fromARGB(255, 234, 112, 255),
        ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ServiceSelectionWidget(),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SignOutButton(context: context),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, CustomerScreen.routeName);
                      },
                      child: const Text("Move To Orders Screen"))
                ],
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: checkUserAccountStatus(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    const SizedBox();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, TurnToPremiumScreen.routeName);
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 255, 179, 0))),
                    child: const Text("Update to Premium"),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
