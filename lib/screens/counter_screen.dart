// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:queueingtool/common/loading.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/methods/customer_order_methods.dart';
import 'package:queueingtool/screens/premium_requests_screen.dart';

class CounterScreen extends StatefulWidget {
  static const routeName = "/counter-screen";
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter Screen'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("PremiumOrders")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Loading();
                    }

                    if (snapshot.data!.docs.isEmpty) {
                      return const SizedBox();
                    }
                    return Expanded(
                      flex: 1,
                      child: CustomerOrderMethods().fetchPremiumOrders(),
                    );
                  }),
              Expanded(
                child: CustomerOrderMethods().fetchNormalOrders(),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SignOutButton(context: context),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PremiumRequestsScreen.routeName);
                      },
                      child: const Text("Premium Requests"))
                ],
              )
            ],
          ),
        ));
  }
}
