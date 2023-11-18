import 'package:flutter/material.dart';
import 'package:queueingtool/common/signout_button.dart';
import 'package:queueingtool/screens/customer_screen.dart';
import 'package:queueingtool/screens/service_widgets.dart';

class CustomerFirstScreen extends StatefulWidget {
  static const routeName = "/customer-first-screen";
  const CustomerFirstScreen({super.key});

  @override
  State<CustomerFirstScreen> createState() => _CustomerFirstScreenState();
}

class _CustomerFirstScreenState extends State<CustomerFirstScreen> {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
