import 'package:flutter/material.dart';
import 'package:queueingtool/methods/counter_order_methods.dart';

class PremiumRequestsScreen extends StatefulWidget {
  static const routeName = "/premium-requests-screen";
  const PremiumRequestsScreen({super.key});

  @override
  State<PremiumRequestsScreen> createState() => _PremiumRequestsScreenState();
}

class _PremiumRequestsScreenState extends State<PremiumRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Requests"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: CounterOrderMethods().fetchPremiumRequests(context),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
    ;
  }
}
