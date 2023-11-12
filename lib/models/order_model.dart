// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:queueingtool/models/user.dart';

class Order {
  String name;
  String id;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel orderowner;
  ServiceType service;
  Order({
    required this.name,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.orderowner,
    required this.service,
  });
}

class Status {
  String waiting;
  String pending;
  String completed;
  Status({
    required this.waiting,
    required this.pending,
    required this.completed,
  });
}

class ServiceType {
  String payfees;
  String deposit;
  String withdraw;
  String personalBanking;
  ServiceType({
    required this.payfees,
    required this.deposit,
    required this.withdraw,
    required this.personalBanking,
  });
}
