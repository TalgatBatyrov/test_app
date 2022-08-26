import 'package:flutter/material.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/additional_info.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/personal_info.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PersonalInfo(user: user),
        const SizedBox(height: 20),
        const AdditionalInfo(),
      ],
    );
  }
}
