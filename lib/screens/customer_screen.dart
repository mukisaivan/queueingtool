import 'package:flutter/material.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/methods/customer_order_methods.dart';
import 'package:queueingtool/screens/turnto_premium_screen.dart';

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
            // Expanded(
            //   child: CustomerOrderMethods().fetchPremiumOrders(user),
            // ),
            Expanded(
              child: CustomerOrderMethods().fetchOrders(),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SignOutButton(context: context),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, TurnToPremiumScreen.routeName);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 255, 179, 0))),
                  child: const Text("Update to Premium"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
