// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queueingtool/common/loading.dart';
import 'package:queueingtool/common/toast_widget.dart';
import 'package:queueingtool/models/order_model.dart';
import 'package:queueingtool/models/premium_request_model.dart';
import 'package:queueingtool/models/user.dart';
import 'package:queueingtool/screens/counter_screen.dart';
import 'package:uuid/uuid.dart';

class CounterOrderMethods {
  final currentUser = FirebaseAuth.instance.currentUser;

  var orders = FirebaseFirestore.instance.collection("Orders");

  addOrderForPremiumUser() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    UserModel orderOwner = await UserModel.fromSnap(userSnapshot);

    String orderId = const Uuid().v4();

    var order = OrderModel.premiumAutoGenerated(
      id: orderId,
      status: StatusEnum.Pending,
      orderowner: orderOwner,
    );
    await orders.doc(orderId).set(order.toMap());
  }

  fetchPremiumRequests(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("PremiumRequests")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              'No Premium requests 🙄',
              style: TextStyle(fontSize: 23),
            ));
          }

          var requestList = snapshot.data!.docs.map((DocumentSnapshot snap) {
            Map<String, dynamic> request = snap.data() as Map<String, dynamic>;
            return PremiumRequest.fromMap(request);
          }).toList();

          return ListView.builder(
            itemCount: requestList.length,
            itemBuilder: (context, index) {
              return buildRequestCard(index, requestList[index], context);
            },
          );
        });
  }

  buildRequestCard(int index, PremiumRequest request, BuildContext context) {
    return Card(
      elevation: 30,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color.fromARGB(255, 255, 132, 0),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      "Order  ${index + 1}",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Ordered by : ${request.requestowner.username}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    deleteRequest(request, context);
                  },
                  child: const Text('Reject'),
                ),
                ElevatedButton(
                  onPressed: () {
                    turnUserCurrentNormalUserToPremium(request, context);
                    deleteRequest(request, context);
                  },
                  child: const Text('Accept'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deleteRequest(PremiumRequest request, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("PremiumRequests")
          .doc(request.requestOwnerId)
          .delete();
    } catch (e) {
      toastWidget("Error: $e", Colors.red);
      // Handle the error appropriately
    }
  }

  void turnUserCurrentNormalUserToPremium(
      PremiumRequest request, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(request.requestOwnerId)
          .update({
        "accountType": AccountTypeEnum.Premium.name,
      });
      toastWidget("Request has been Approved 😁", Colors.green);
      Navigator.pushNamed(context, CounterScreen.routeName);
    } catch (e) {
      Navigator.pop(context); // Close loading dialog on error
      toastWidget("Error: ${e.toString()}", Colors.red);
    }
  }

  // void showLoadingDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return const Loading();
  //     },
  //   );
  // }
}
