import 'package:flutter/material.dart';

class Faviourte extends StatefulWidget {
  const Faviourte({super.key});

  @override
  State<Faviourte> createState() => _FaviourteState();
}

class _FaviourteState extends State<Faviourte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faviourte"),
      ),
    );
  }
}