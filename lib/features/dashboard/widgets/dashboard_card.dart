import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardCard extends ConsumerWidget {
  final String title;
  final Widget child;
  const DashboardCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            child
          ],
        ),
      ),
    );
  }
}
