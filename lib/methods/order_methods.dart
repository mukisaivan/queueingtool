import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:queueingtool/models/order_model.dart';
import 'package:queueingtool/models/user.dart';

class OrderMethods {
  final currentUser = FirebaseAuth.instance.currentUser;

  // Get the user's document from Firestore

  addOrder() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    var order = OrderModel(
      name: "",
      id: "id",
      status: StatusEnum.Pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      orderowner: UserModel.fromSnap(userSnapshot),
      service: ServiceEnum.Deposit,
    );

    var orders = FirebaseFirestore.instance.collection("Orders");
    orders.add(order.toMap());
  }
}
