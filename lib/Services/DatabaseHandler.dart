import 'package:account_app/Services/queries.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../context_class.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user_db_2.db'),
      singleInstance: true,
      onCreate: (database, version) async {
        await database.execute(DbQueries.createUserTable);
        insertTransaction();
      },
      version: 1,
    );
  }

  Future<void> insertTransaction() async {
    final Database db = await initializeDB();

    var data = await db.transaction((txn) async {
      await txn.execute(
          "INSERT INTO UserData (ID,BALANCE,IS_DEBIT,FIRST_NAME,LAST_NAME,PHONE,EMAIL)VALUES (1,100,0,'prince','thakur',1234567890,'princepatyal007@gmail.com')");
    }).onError((error, stackTrace) {
      print("===========>${error}");
      print("===========>${stackTrace}");
    });

    return data;
  }

  Future<dynamic> updateTransaction(int money, int isCredit) async {
    final Database db = await initializeDB();
    var data = await db.transaction((txn) async {
      if (isCredit == 1) {
        await txn.execute("UPDATE UserData SET BALANCE = $money WHERE ID = 1");

        await txn.execute("UPDATE UserData SET IS_DEBIT = 0 WHERE ID = 1");
      } else {
        await txn.execute("UPDATE UserData SET BALANCE = $money WHERE ID = 1");

        await txn.execute("UPDATE UserData SET IS_DEBIT = 1 WHERE ID = 1");
      }
    }).onError((error, stackTrace) {
      showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (ctx) => AlertDialog(
          title: const Text("There is an error in the transaction"),
          content: const Text("Please check the DB queries"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(14),
                child: const Text("okay"),
              ),
            ),
          ],
        ),
      );
    });
    return data;
  }

  Future<List<UserModel>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('${DbQueries.TABLENAME}');
    // final List<Map<String, Object?>> queryResult2 = await db.query('logger');
    // que
    // endUserLog=
    // print("${queryResult2.elementAt(0).entries}");
    return queryResult.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAllUser() async {
    final db = await initializeDB();
    await db.delete('users');
  }
}
