import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String title;
  const Error({
    Key? key,
    this.title = 'Ошибка сети ... ',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: const TextStyle(fontSize: 20.0)),
    );
  }
}
