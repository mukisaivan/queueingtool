// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queueingtool/models/user.dart';

enum StatusEnum {
  Waiting,
  Pending,
  Completed,
  Canceled,
}

enum ServiceEnum {
  Payfees,
  Deposit,
  Withdraw,
}

class OrderModel {
  final String name;
  final String id;
  final StatusEnum status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel orderowner;
  final ServiceEnum service;
  OrderModel({
    required this.name,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderowner,
    required this.service,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'status': status.toString(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'orderowner': orderowner.toJson(),
      'service': service.toString(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      name: map['name'] as String,
      id: map['id'] as String,
      status: convertStatusStringToStatusEnum(map["status"] as String),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      orderowner: UserModel.fromSnap(map['orderowner'] as DocumentSnapshot),
      service: convertServiceStringToServiceEnum(map["service"] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static StatusEnum convertStatusStringToStatusEnum(String status) {
    switch (status) {
      case "Waiting":
        return StatusEnum.Waiting;
      case "Pending":
        return StatusEnum.Pending;
      case "Completed":
        return StatusEnum.Completed;
      case "Canceled":
        return StatusEnum.Canceled;
      default:
    }
    return StatusEnum.Pending;
  }

  static ServiceEnum convertServiceStringToServiceEnum(String service) {
    switch (service) {
      case "Withdraw":
        return ServiceEnum.Withdraw;
      case "Deposit":
        return ServiceEnum.Deposit;
      case "Payfees":
        return ServiceEnum.Payfees;

      default:
    }
    return ServiceEnum.Deposit;
  }
}
