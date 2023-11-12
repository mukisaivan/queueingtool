// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

enum OrderStatus {
  Waiting,
  Pending,
  Completed,
}

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  OrderStatus _orderStatus = OrderStatus.Waiting;

  String _orderStatusToString() {
    switch (_orderStatus) {
      case OrderStatus.Waiting:
        return 'Waiting';
      case OrderStatus.Pending:
        return 'Pending';
      case OrderStatus.Completed:
        return 'Completed';
    }
  }

  void _updateOrderStatus(OrderStatus newStatus) {
    setState(() {
      _orderStatus = newStatus;
    });
  }

  Color colorchanger(OrderStatus newstatus) {
    switch (_orderStatus) {
      case OrderStatus.Waiting:
        return const Color.fromARGB(255, 9, 218, 255);
      case OrderStatus.Pending:
        return const Color.fromARGB(255, 251, 255, 0);
      case OrderStatus.Completed:
        return const Color.fromARGB(255, 0, 255, 8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorchanger(_orderStatus),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 5, left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order #100',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text('Items: Matooke, Rice, Beans'),
            const SizedBox(height: 8.0),
            Text('Status: ${_orderStatusToString()}'),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _updateOrderStatus(OrderStatus.Waiting);
                  },
                  child: const Text('Waiting'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateOrderStatus(OrderStatus.Pending);
                  },
                  child: const Text('Pending'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _updateOrderStatus(OrderStatus.Completed);
                  },
                  child: const Text('Completed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
