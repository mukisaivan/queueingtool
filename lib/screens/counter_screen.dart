// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
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
              Expanded(
                child:
                    // Text("Woooooo"),
                    CustomerOrderMethods().fetchPremiumOrders(),
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
