import 'package:curator/data/models/models.dart';
import 'package:curator/data/apis/mysql_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final dashboardControllerProvider =
//     StateNotifierProvider<DashboardController, List<bool>>(
//         (ref) => DashboardController(dbApi: ref.watch(dbProvider)));

// final documentsProvider = Provider<List<DocumentModel>>((ref) {
//   final dashboardController = ref.watch(dashboardControllerProvider);
//   return dashboardController;
// });



// class DashboardController extends StateNotifier<List<bool>> {
//   final DatabaseApi _databaseApi;

//   DashboardController({required DatabaseApi dbApi}) : _databaseApi = dpApi, super(false);

//   Future<void> fetchDocuments() async {
//     final documents = await DatabaseApi().getDocuments();
//     state = documents;
//   }

//   Future<void> addDocument(DocumentModel document) async {
//     await DatabaseApi().addDocument(document);
//     state = [...state, document];
//   }

//   Future<void> updateDocument(DocumentModel document) async {
//     await DatabaseApi().updateDocument(document);
//     state = [
//       for (final doc in state)
//         if (doc.id == document.id) document else doc
//     ];
//   }

//   Future<void> deleteDocument(DocumentModel document) async {
//     await DatabaseApi().deleteDocument(document);
//     state = [
//       for (final doc in state)
//         if (doc.id != document.id) doc
//     ];
//   }
// }