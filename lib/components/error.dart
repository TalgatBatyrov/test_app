import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ошибка сети ... ',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
