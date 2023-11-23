import 'package:flutter/material.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/methods/customer_order_methods.dart';

class CustomerScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreen();
}

class _CustomerScreen extends State<CustomerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer's Orders Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: CustomerOrderMethods().fetchOrders(),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SignOutButton(context: context),
              ],
            )
          ],
        ),
      ),
    );
  }
}
