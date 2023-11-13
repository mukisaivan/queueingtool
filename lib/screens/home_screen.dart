import 'package:flutter/material.dart';
import 'package:queueingtool/common/signout_button.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer's Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Request for an order"),
                ),
                const SizedBox(height: 50),
                // const OrderWidget(),
                const SizedBox(height: 50),
                SignOutButton(context: context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
