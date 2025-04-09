import 'package:flutter/material.dart';

class ViewInformation extends StatelessWidget {
  const ViewInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text("Welcome to Home!"),
      ),
    );
  }
}
