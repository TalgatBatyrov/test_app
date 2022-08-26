import 'package:flutter/material.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/components/albums/albums.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/components/posts/posts.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: const [
          Posts(),
          Albums(),
        ],
      ),
    );
  }
}
