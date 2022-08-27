import 'package:flutter/cupertino.dart';
import 'package:test_app/blocs/theme_cubit/theme_cubit.dart';
import 'package:test_app/styles/styles.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    Key? key,
    required this.themeCubit,
  }) : super(key: key);

  final ThemeCubit themeCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CupertinoSwitch(
          activeColor: !themeCubit.isLight ? Styles.bgColor : null,
          value: !themeCubit.isLight,
          onChanged: (_) => themeCubit.toggleTheme(),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
