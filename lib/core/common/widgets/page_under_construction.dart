import 'package:flutter/material.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: const SafeArea(
          child: Center(
            child: Text('Page Under Construction'),
          ),
        ),
      ),
    );
  }
}
