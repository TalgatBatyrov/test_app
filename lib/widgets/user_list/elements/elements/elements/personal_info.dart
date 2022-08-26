import 'package:flutter/material.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/styles/styles.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 20, color: Styles.titleColor);
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(user.name, style: style),
          subtitle: Text(user.email),
        ),
        ListTile(
          leading: const Icon(Icons.web),
          title: Text('${user.website}', style: style),
          subtitle: Text(user.phone),
        ),
        ListTile(
          leading: const Icon(Icons.work),
          title: Text('${user.company?.name}', style: style),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${user.company?.catchPhrase}'),
              Text('${user.company?.bs}'),
            ],
          ),
        ),
      ],
    );
  }
}
