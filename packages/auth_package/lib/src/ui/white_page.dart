import 'package:flutter/material.dart';

class WhitePage extends StatelessWidget {
  const WhitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('White Page (AUTH)'),
      ),
      body: const Placeholder(),
    );
  }
}