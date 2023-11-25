// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueingtool/common/custom_button.dart';
import 'package:queueingtool/common/toast_widget.dart';
import 'package:queueingtool/models/premium_request_model.dart';
import 'package:queueingtool/models/user.dart';
import 'package:queueingtool/payment/flutter_wave.dart';
import 'package:uuid/uuid.dart';

class TurnToPremiumScreen extends StatefulWidget {
  static const routeName = "/turnTo-premium-screen";
  final User currentUser;
  const TurnToPremiumScreen({
    super.key,
    required this.currentUser,
  });

  @override
  State<TurnToPremiumScreen> createState() => _TurnToPremiumScreenState();
}

class _TurnToPremiumScreenState extends State<TurnToPremiumScreen> {
  @override
  Widget build(BuildContext context) {
    requestToBecomePremium() async {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      UserModel requestOwner = await UserModel.fromSnap(userSnap);
      String requestId = const Uuid().v4();

      var premiumRequest = PremiumRequest(
          requestOwnerId: requestOwner.uid,
          requestId: requestId,
          createdAt: DateTime.now(),
          requestowner: requestOwner);

      var requests = FirebaseFirestore.instance.collection("PremiumRequests");

      await requests.doc(requestOwner.uid).set(premiumRequest.toMap());

      toastWidget(
        "Request Submitted ✅  Wait for response",
        const Color.fromARGB(255, 255, 101, 250),
      );

      Navigator.pop(context);
    }

    proceedToMakePayment() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Payment',
              style: TextStyle(color: Color.fromARGB(255, 216, 0, 254)),
            ),
            content: const Text(
              'Continue to make Ugx. 10,000 Payment ?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel',
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 216, 0, 254))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(
                      context, FlutterWaveScreen.routeName);
                },
                child: const Text('OK',
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 216, 0, 254))),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Turn To Premium User"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                CustomButton(
                  label: "Send Request to pay Physically",
                  onTap: () {
                    requestToBecomePremium();
                  },
                ),
                const SizedBox(height: 50),
                CustomButton(
                  label: "Use Mobile Money 💲💸",
                  onTap: () {
                    proceedToMakePayment();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
