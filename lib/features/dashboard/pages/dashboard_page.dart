import 'package:curator/data/apis/mysql_api.dart';
import 'package:curator/features/dashboard/widgets/chart.dart';
import 'package:curator/features/dashboard/widgets/chart2.dart';
import 'package:curator/features/dashboard/widgets/dashboard_card.dart';
import 'package:curator/features/dashboard/widgets/search_field.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    Window.setEffect(
      effect: WindowEffect.acrylic,
      color: const Color(0xCC222222),
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider).value;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchAnchor(builder:
                      (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      //   trailing: <Widget>[
                      //     if (controller.query.isNotEmpty)
                      //       IconButton(
                      //         onPressed: () {
                      //           controller.clear();
                      //         },
                      //         icon: const Icon(Icons.clear),
                      //       ),
                      //   ],
                    );
                  }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(5, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  }),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.purple,
                  ),
                  const SizedBox(width: 8),
                  const Text('Username'),
                  const SizedBox(width: 8),
                  DropdownButton(
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem(
                          value: 'settings',
                          child: Text('Settings'),
                        ),
                        DropdownMenuItem(
                          value: 'logout',
                          child: Text('Logout'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == 'logout') {
                          // context.read(authProvider).logout();
                        }
                      }),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Collections',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all'),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        DashboardCard(
                          title: 'Summary',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 200,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            pieTouchResponse) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 40,
                                      sections: showingSections(),
                                    ),
                                  ),
                                ),
                              ),
                              // ?
                              SizedBox(height: 200, child: BarChartSample4()),
                            ],
                          ),
                        ),
                        const DashboardCard(
                            title: 'borrowed books',
                            child: SizedBox(
                              height: 400,
                              child: LineChartSample1(),
                            )),
                        const DashboardCard(
                          title: 'Your reader activity',
                          child: Placeholder(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        DashboardCard(
                          title: 'Recently added',
                          child: Center(
                            child: FutureBuilder(
                              future: db!.query('select * from document limit 10;'),
                              builder: (context, snapshot) {
                                final data = snapshot.data;
                                return data == null
                                    ? const CircularProgressIndicator()
                                    : SingleChildScrollView(
                                        child: DataTable(
                                            columns: const [
                                              DataColumn(label: Text('Code')),
                                              DataColumn(
                                                  label: Text('Title')),
                                              DataColumn(
                                                  label: Text('Exemplaires')),
                                              DataColumn(
                                                  label: Text('Delete'))
                                            ],
                                            rows: data
                                                .map((e) => DataRow(cells: [
                                                      DataCell(Text(e['code']
                                                          .toString())),
                                                      DataCell(Text(e['title']
                                                          .toString())),
                                                      DataCell(Text(e['exemp']
                                                          .toString())),
                                                      DataCell(IconButton(
                                                          tooltip: 'Delete',
                                                          onPressed: () {
                                                            db.delete(
                                                                'delete from document where code = ${e['code']}');
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete)))
                                                    ]))
                                                .toList()),
                                      );
                              },
                            ),
                          ),
                        ),
                        const DashboardCard(
                          title: 'Favorite genres',
                          child: Placeholder(),
                        ),
                        const DashboardCard(
                          title: 'Favorite authors',
                          child: Placeholder(),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  // showingSections
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25.sp : 16.sp;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
