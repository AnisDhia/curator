import 'package:curator/core/common/search.widget.dart';
import 'package:curator/core/utility/extensions/color_extensions.dart';
import 'package:curator/data/apis/mysql_api.dart';
import 'package:curator/data/models/document_model.dart';
import 'package:curator/features/dashboard/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;

import 'package:responsive_sizer/responsive_sizer.dart';

class DocumentsPage extends ConsumerStatefulWidget {
  const DocumentsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends ConsumerState<DocumentsPage> {
  final Key _formKey = GlobalKey();
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _exempController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider).value;

    return Scaffold(
      backgroundColor: Colors.white.darken(3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32, left: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Documents',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.h),
                    SearchAnchor.bar(
                      barHintText: 'Search documents',
                      suggestionsBuilder: (context, controller) {
                        return [
                          // no search history
                          if (controller.text.isEmpty)
                            const Center(
                              child: Text('No search history.',
                                  style: TextStyle(color: Colors.grey)),
                            )
                          else
                            // search history
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {},
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Center(
                                                child:
                                                    Text('code'.toString()))),
                                        Expanded(
                                            child: Center(
                                                child:
                                                    Text('title'.toString()))),
                                        Expanded(
                                            child: Center(
                                                child:
                                                    Text('exemp'.toString()))),
                                      ],
                                    ),
                                  );
                                })
                        ];
                      },
                    ),
                  ],
                ),
              ),

              //refresh button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // export to excel button
                  IconButton(
                      tooltip: 'Export to excel',
                      onPressed: () {
                        // export to excel
                      },
                      icon: const Icon(Icons.download)),
                  IconButton(
                      tooltip: 'Refresh',
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
              const Divider(),
              Expanded(
                child: Center(
                  child: FutureBuilder(
                    future: db!.query('select * from document;'),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return data == null
                          ? const CircularProgressIndicator()
                          : SingleChildScrollView(
                              child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Code')),
                                    DataColumn(label: Text('Title')),
                                    DataColumn(label: Text('Exemplaires')),
                                    DataColumn(label: Text('Delete'))
                                  ],
                                  rows: data
                                      .map((e) => DataRow(
                                        cells: [
                                            DataCell(
                                                Text(e['code'].toString())),
                                            DataCell(
                                                Text(e['title'].toString())),
                                            DataCell(
                                                Text(e['exemp'].toString())),
                                            DataCell(IconButton(
                                                tooltip: 'Delete',
                                                onPressed: () {
                                                  db.delete(
                                                      'delete from document where code = ${e['code']}');
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.delete)))
                                          ]))
                                      .toList()),
                            );
                    },
                  ),
                ),
              ),

              const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            // showCupertinoModalPopup(context: context, builder: builder)
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Card(
                    child: SizedBox(
                      width: 60.w,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text('code'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _codeController,
                                    hintText: 'code'),
                                const Text('Title'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _titleController,
                                    hintText: 'Title'),
                                const Text('Exemplaires'),
                                SizedBox(height: 2.h),
                                SearchField(
                                    controller: _exempController,
                                    hintText: 'Exemplaires'),
                                SizedBox(height: 4.h),
                                ElevatedButton(
                                    onPressed: () {
                                      // String statement =
                                      //     'insert into subscriber (uid, first_name, last_name, department) values(${_codeController.text}, ${_titleController.text}, ${_lastNameController.text}, ${_exempController.text});';
                                      db!.insert(
                                          'document',
                                          "code, title, exemp",
                                          "${_codeController.text}, \"${_titleController.text}\", ${_exempController.text}");
                                      setState(() {});
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
