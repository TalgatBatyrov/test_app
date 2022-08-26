import 'package:flutter/material.dart';
import 'package:test_app/models/user.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            user.name,
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(user.email),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.web),
          title: Text(
            '${user.website}',
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(user.phone),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.work),
          title: Text(
            '${user.company?.name}',
            style: const TextStyle(fontSize: 20),
          ),
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
