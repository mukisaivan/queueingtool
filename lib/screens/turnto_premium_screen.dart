// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:queueingtool/common/custom_button.dart';
import 'package:queueingtool/common/loading.dart';
import 'package:queueingtool/common/toast_widget.dart';
import 'package:queueingtool/models/premium_request_model.dart';
import 'package:queueingtool/models/user.dart';
import 'package:queueingtool/screens/customer_screen.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Turn To Premium User"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomButton(
                label: "Request To Turn Premium",
                onTap: () {
                  // turnUserCurrentNormalUserToPremium();
                  requestToBecomePremium();
                }),
          )
        ],
      ),
    );
  }
}
