// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:queueingtool/common/toast_widget.dart';
import 'package:queueingtool/models/user.dart';
import 'package:queueingtool/payment/flutter_wave_keys.dart';
import 'package:queueingtool/screens/counter_screen.dart';
import 'package:queueingtool/screens/customer_screen.dart';
import 'package:uuid/uuid.dart';

class FlutterWaveScreen extends StatefulWidget {
  final User currentUser;

  static const routeName = "/flutter-wave-screen";

  const FlutterWaveScreen({
    super.key,
    required this.currentUser,
  });

  @override
  _FlutterWaveScreenState createState() => _FlutterWaveScreenState();
}

class _FlutterWaveScreenState extends State<FlutterWaveScreen> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController(text: "Shs. 10,000");
  final currencyController = TextEditingController(text: "UGX");
  final narrationController = TextEditingController();
  final publicKeyController =
      TextEditingController(text: FlutterWaveKeys.publickey);
  final encryptionKeyController =
      TextEditingController(text: FlutterWaveKeys.encryptionkey);
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();

  String selectedCurrency = "";

  bool isTestMode = true;

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill in your Details"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Amount"),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Amount is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: currencyController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: _openBottomSheet,
                  decoration: const InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Currency is required",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: publicKeyController,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Public Key",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: encryptionKeyController,
                  readOnly: true,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Encryption Key",
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Name", label: Text("Enter your name")),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      hintText: "Email", label: Text("Enter your gmail")),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  children: [
                    const Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isTestMode = value;
                        })
                      },
                      value: isTestMode,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  onPressed: _onPressed,
                  child: const Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    final currentState = formKey.currentState;
    if (currentState != null && currentState.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(
      email: emailController.text.trim(),
      name: nameController.text,
      phoneNumber: phoneNumberController.text.toString(),
    );

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: publicKeyController.text.trim().isEmpty
            ? getPublicKey()
            : publicKeyController.text.trim(),
        currency: selectedCurrency,
        redirectUrl: 'https://facebook.com',
        txRef: const Uuid().v1(),
        amount: amountController.text.toString().trim(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Test Payment"),
        isTestMode: isTestMode);
    final ChargeResponse response = await flutterwave.charge();
    showLoading(response.toString());
    print(
        " ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++Response: ${response.toJson()}");

    if (response.status == "successful" || response.success == "true") {
      turnUserCurrentNormalUserToPremium();
      Navigator.pushNamed(context, CustomerScreen.routeName);
    } else {
      toastWidget("Payment Has Been cancelled",
          const Color.fromARGB(255, 107, 74, 255));
      Navigator.pushNamed(context, CustomerScreen.routeName);
    }
  }

  String getPublicKey() {
    return "";
  }

  void turnUserCurrentNormalUserToPremium() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.currentUser.uid)
          .update({
        "accountType": AccountTypeEnum.Premium.name,
      });
      toastWidget("Your account is now Premium 😁", Colors.green);
      Navigator.pushNamed(context, CounterScreen.routeName);
    } catch (e) {
      toastWidget("Error: ${e.toString()}", Colors.red);
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _getCurrency();
      },
    );
  }

  Widget _getCurrency() {
    final currencies = ["UGX"];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {_handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
