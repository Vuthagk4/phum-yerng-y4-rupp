import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/data_controller.dart';

class DataView extends GetView<DataController> {
  const DataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
