import 'package:curator/data/apis/mysql_api.dart';
import 'package:curator/data/models/document_model.dart';
import 'package:curator/features/browse/widgets/subscriber_details_sheet.dart';
import 'package:curator/features/dashboard/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;

import 'package:responsive_sizer/responsive_sizer.dart';

class SubscribersPage extends ConsumerStatefulWidget {
  const SubscribersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubscribersPageState();
}

class _SubscribersPageState extends ConsumerState<SubscribersPage> {
  final _formKey = GlobalKey<FormState>();
  final _uidController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider).value;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Subscribers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Uid'),
                Text('First name'),
                Text('Last name'),
                Text('Department'),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            db == null
                ? const CircularProgressIndicator()
                : FutureBuilder(
                    future: db.query('select * from subscriber;'),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return data == null
                          ? const CircularProgressIndicator()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) {
                                          // final subscriber = SubscriberModel.fromMap(data[index]);
                                          return SubscriberSheet(
                                              uid: data[index]['uid'],
                                              firstName: data[index]
                                                  ['first_name'],
                                              lastName: data[index]
                                                  ['last_name'],
                                              department: data[index]
                                                  ['department']);
                                        });
                                  },
                                  trailing: IconButton(
                                      onPressed: () {
                                        db.delete(
                                            'delete from subscriber where uid = ${data[index]['uid']}');
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.delete)),
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: Text(data[index]['uid']
                                                  .toString()))),
                                      Expanded(
                                          child: Center(
                                              child: Text(data[index]
                                                      ['first_name']
                                                  .toString()))),
                                      Expanded(
                                          child: Center(
                                              child: Text(data[index]
                                                      ['last_name']
                                                  .toString()))),
                                      Expanded(
                                          child: Center(
                                              child: Text(data[index]
                                                      ['department']
                                                  .toString()))),
                                    ],
                                  ),
                                );
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceEvenly,
                                //   children: [
                                //     Expanded(
                                //         child: Center(
                                //             child: Text(data[index]['uid']
                                //                 .toString()))),
                                //     Expanded(
                                //         child: Center(
                                //             child: Text(data[index]
                                //                     ['first_name']
                                //                 .toString()))),
                                //     Expanded(
                                //         child: Center(
                                //             child: Text(data[index]['last_name']
                                //                 .toString()))),
                                //     Expanded(
                                //         child: Center(
                                //             child: Text(data[index]
                                //                     ['department']
                                //                 .toString()))),
                                //   ],
                                // );
                              },
                            );
                    }),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // showCupertinoModalPopup(context: context, builder: builder)
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Material(
                    child: SizedBox(
                      width: 60.w,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text('uid'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _uidController,
                                    hintText: 'UID'),
                                const Text('first name'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _firstNameController,
                                    hintText: 'first name'),
                                const Text('last name'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _lastNameController,
                                    hintText: 'last name'),
                                const Text('department'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _departmentController,
                                    hintText: 'department'),
                                SizedBox(height: 4.h),
                                ElevatedButton(
                                    onPressed: () {
                                      // String statement =
                                      //     'insert into subscriber (uid, first_name, last_name, department) values(${_uidController.text}, ${_firstNameController.text}, ${_lastNameController.text}, ${_departmentController.text});';
                                      db!.insert(
                                          'subscriber',
                                          "uid, first_name, last_name, department",
                                          "${_uidController.text}, \"${_firstNameController.text}\", \"${_lastNameController.text}\", \"${_departmentController.text}\"");
                                      setState(() {});
                                      _uidController.clear();
                                      _firstNameController.clear();
                                      _lastNameController.clear();
                                      _departmentController.clear();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Add'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
