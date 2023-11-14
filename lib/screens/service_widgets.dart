// ignore_for_file: library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:queueingtool/common/toast_widget.dart';
import 'package:queueingtool/methods/customer_order_methods.dart';
import 'package:queueingtool/models/order_model.dart';

class ServiceSelectionWidget extends StatefulWidget {
  const ServiceSelectionWidget({super.key});

  @override
  _ServiceSelectionWidgetState createState() => _ServiceSelectionWidgetState();
}

class _ServiceSelectionWidgetState extends State<ServiceSelectionWidget> {
  ServiceEnum? selectedService;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
      alignment: Alignment.center,
      height: 300,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose a Service:',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          DropdownButton<ServiceEnum>(
            icon: const Icon(Icons.arrow_drop_down_circle_sharp, size: 50),
            iconEnabledColor: const Color.fromARGB(255, 249, 123, 165),
            dropdownColor: const Color.fromARGB(255, 204, 127, 255),
            value: selectedService,
            items: ServiceEnum.values.map((service) {
              return DropdownMenuItem<ServiceEnum>(
                value: service,
                child: Text(service.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedService = value;
              });
            },
          ),
          const SizedBox(height: 36),
          ElevatedButton(
            onPressed: () {
              if (selectedService != null) {
                CustomerOrderMethods().addOrder(context, selectedService);
              } else {
                toastWidget("Please select a service 🥺",
                    const Color.fromARGB(255, 255, 118, 163));
              }
            },
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 211, 100, 255)),
                elevation: MaterialStatePropertyAll(20),
                minimumSize: MaterialStatePropertyAll(Size(100, 50)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))))),
            child: const Text('Submit Order 🚀'),
          ),
        ],
      ),
    );
  }
}
