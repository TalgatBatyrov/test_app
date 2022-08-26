import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
