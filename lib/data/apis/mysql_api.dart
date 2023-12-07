import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:developer' as dev;

// final databaseApiProvider = Provider<IDatabaseApi>((ref) {
//   return DatabaseApi(

//   );
// });

final dbProvider = FutureProvider((ref) async {
  MySqlConnection connection = await connectt();
  return DatabaseApi(connection: connection);
});

abstract class IDatabaseApi {
  Future<List<Map<String, dynamic>>> query(String sql);
  void insert(String sql, String columns, String values);
  Future<int> update(String sql);
  Future<int> delete(String sql);
}

Future<MySqlConnection> connectt() async {
  final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'library');

  try {
    dev.log('connecting...');
    final res = await MySqlConnection.connect(settings);
    dev.log('connected!');
    return res;
  } catch (e) {
    dev.log(e.toString());
    rethrow;
  }
}

class DatabaseApi implements IDatabaseApi {
  final MySqlConnection _connection;
  final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'library');

  DatabaseApi({required MySqlConnection connection}) : _connection = connection;

  // void _connect() async {
  //   try {
  //     dev.log('connecting...');
  //     _connection = await MySqlConnection.connect(settings);
  //   } catch (e) {
  //     dev.log(e.toString());
  //   }
  // }

  @override
  Future<List<Map<String, dynamic>>> query(String sql) async {
    try {
      dev.log('fetching data..');
      Results results = await _connection.query(sql);
      for (var row in results) {
        dev.log(row.fields.toString());
      }
      return results.map((e) => e.fields).toList();
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  @override
  void insert(String table, String columns, String values) async {
    try {
      final statement = 'insert into $table (${columns}) values(${values});';
      dev.log(statement);
      
      await _connection.query(statement);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Future<int> update(String sql) async {
    throw UnimplementedError();
  }

  @override
  Future<int> delete(String sql) async {
    _connection.query(sql);
    return 1;
    // throw UnimplementedError();
  }
}
