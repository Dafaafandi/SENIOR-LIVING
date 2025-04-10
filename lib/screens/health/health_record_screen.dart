import 'package:flutter/material.dart';

class HealthRecordScreen extends StatelessWidget {
  const HealthRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Kesehatan')),
      body: const Center(child: Text('Halaman Catatan Kesehatan')),
    );
  }
}
