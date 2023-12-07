import 'package:curator/core/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final appThemeState = ref.watch(themeProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _newCard(
              CupertinoIcons.moon_stars,
              "dark mode",
              Switch(
                  value: appThemeState == ThemeMode.dark ? true : false,
                  onChanged: (newValue) {
                    ref.read(themeProvider.notifier).changeTheme();
                  }),
            ),
            _newCard(
                CupertinoIcons.globe,
                "language",
                DropdownButton<String>(
                  value: "en",
                  alignment: Alignment.bottomCenter,
                  items: const [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(
                        'English',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'fr',
                      child: Text('Francais'),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text('العربية'),
                    ),
                  ],
                  onChanged: (value) {
                    // locale.changeLocale(value!);
                  },
                )),
            
          ],
        ),
      ),
    );
  }

  Card _newCard(IconData icon, String title, Widget trailing) {
    return Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 16),
              Expanded(child: Text(title)),
              trailing
            ],
          ),
        ));
  }
}
