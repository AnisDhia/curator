import 'package:curator/features/browse/pages/documents_page.dart';
import 'package:curator/features/browse/pages/subscribers_page.dart';
import 'package:curator/features/dashboard/pages/dashboard_page.dart';
import 'package:curator/features/navigation/widgets/toolbar.dart';
import 'package:curator/features/settings/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/widgets/transparent_macos_sidebar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/octicons_icons.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';

class Navigation extends ConsumerStatefulWidget {
  const Navigation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends ConsumerState<Navigation> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 30,
          child: ToolBar(),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Row(
            children: [
              NavigationRail(
                groupAlignment: 0,
                selectedIndex: _selectedIndex,
                labelType: NavigationRailLabelType.selected,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _pageController.jumpToPage(index);
                },
                destinations: const [
                  NavigationRailDestination(
                    padding: EdgeInsets.all(16),
                    icon: Icon(Octicons.dashboard),
                    label: Text("dashboard"),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.all(16),
                    icon: Icon(Octicons.book),
                    label: Text("documents"),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.all(16),
                    icon: Icon(Octicons.person),
                    label: Text("subscribers"),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.all(16),
                    icon: Icon(Octicons.settings),
                    label: Text("settings"),
                  ),
                ],
              ),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: const [DashboardPage(), DocumentsPage(), SubscribersPage() , SettingsPage()],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
