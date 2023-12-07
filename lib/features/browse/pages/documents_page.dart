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
  Key _formKey = GlobalKey();
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _lasttNameController = TextEditingController();
  final _exempController = TextEditingController();
  List<DocumentModel> documentsList = [
    DocumentModel(
      id: '1',
      title: 'The Art of War',
      author: 'Sun Tzu',
      description:
          'The Art of War is an ancient Chinese military treatise dating from the Late Spring and Autumn Period. The work, which is attributed to the ancient Chinese military strategist Sun Tzu, is composed of 13 chapters. Each one is devoted to an aspect of warfare and how it applies to military strategy and tactics.',
      url:
          'https://images-na.ssl-images-amazon.com/images/I/51Q7Q4QF7ML._SX331_BO1,204,203,200_.jpg',
      type: 'book',
      createdAt: '2021-10-01 00:00:00',
      updatedAt: '2021-10-01 00:00:00',
    ),
    DocumentModel(
      id: '2',
      title: 'The Art of War',
      author: 'Sun Tzu',
      description:
          'The Art of War is an ancient Chinese military treatise dating from the Late Spring and Autumn Period. The work, which is attributed to the ancient Chinese military strategist Sun Tzu, is composed of 13 chapters. Each one is devoted to an aspect of warfare and how it applies to military strategy and tactics.',
      url:
          'https://images-na.ssl-images-amazon.com/images/I/51Q7Q4QF7ML._SX331_BO1,204,203,200_.jpg',
      type: 'book',
      createdAt: '2021-10-01 00:00:00',
      updatedAt: '2021-10-01 00:00:00',
    ),
    DocumentModel(
      id: '3',
      title: 'The Art of War',
      author: 'Sun Tzu',
      description:
          'The Art of War is an ancient Chinese military treatise dating from the Late Spring and Autumn Period. The work, which is attributed to the ancient Chinese military strategist Sun Tzu, is composed of 13 chapters. Each one is devoted to an aspect of warfare and how it applies to military strategy and tactics.',
      url:
          'https://images-na.ssl-images-amazon.com/images/I/51Q7Q4QF7ML._SX331_BO1,204,203,200_.jpg',
      type: 'book',
      createdAt: '2021-10-01 00:00:00',
      updatedAt: '2021-10-01 00:00:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(dbProvider).value;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            const Text('Documents',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 4.h),
            //refresh button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // export to excel button
                IconButton(
                    onPressed: () {
                      // export to excel
                    },
                    icon: const Icon(Icons.download)),
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.refresh))
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('Code'), Text('Title'), Text('Exemplaires')],
            ),
            const Divider(),
            const SizedBox(height: 16),
            db == null
                ? const CircularProgressIndicator()
                : FutureBuilder(
                    future: db.query('select * from document;'),
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
                                  onTap: () {},
                                  trailing: IconButton(
                                      onPressed: () {
                                        db.delete(
                                            'delete from document where code = ${data[index]['code']}');
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
                                              child: Text(data[index]['code']
                                                  .toString()))),
                                      Expanded(
                                          child: Center(
                                              child: Text(data[index]['title']
                                                  .toString()))),
                                      Expanded(
                                          child: Center(
                                              child: Text(data[index]['exemp']
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
                                //             child: Text(data[index]['code']
                                //                 .toString()))),
                                //     Expanded(
                                //         child: Center(
                                //             child: Text(data[index]['title']
                                //                 .toString()))),
                                //     Expanded(
                                //         child: Center(
                                //             child: Text(data[index]['exemp']
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
