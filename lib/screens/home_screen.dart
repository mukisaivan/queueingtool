import 'package:flutter/material.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/screens/counter_screen.dart';

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
        title: const Text("User's Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Request for an order"),
              ),
              const SizedBox(height: 50),
              const OrderWidget(),
              const SizedBox(height: 50),
              SignOutButton(context: context)
            ],
          ),
        ),
      ),
    );
  }
}
