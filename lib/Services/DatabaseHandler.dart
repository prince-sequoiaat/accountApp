import 'package:account_app/Services/queries.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../context_class.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user_db_19.db'),
      singleInstance: true,
      onCreate: (database, version) async {
        await database.execute(DbQueries.createUserTable).whenComplete(() async{
          await database.execute(DbQueries.createLogTable).whenComplete(() {
            insertTransaction();
          });
        });

      },
      version: 1,
    );
  }

  Future<void> insertTransaction() async {
    final Database db = await initializeDB();

    var data = await db.transaction((txn) async {
      await txn.execute(
          "INSERT INTO UserData (ID,BALANCE,IS_DEBIT,FIRST_NAME,LAST_NAME,PHONE,EMAIL)VALUES (1,100,0,'prince','thakur',1234567890,'princepatyal007@gmail.com')");
      await txn.execute("INSERT INTO ${DbQueries.LOGTABLE}(ID,LOG,IS_DEBIT) VALUES (1,'0',0)");
    }).onError((error, stackTrace) {

    });

    return data;
  }

  Future<dynamic> updateTransaction(int money, int isCredit, {bool addError=false}) async {
    final Database db = await initializeDB();
    var data = await db.transaction((txn) async {
      if (isCredit == 1) {
        await txn.execute("UPDATE UserData SET BALANCE = $money WHERE ID = 1");
        await txn.execute("INSERT INTO ${DbQueries.LOGTABLE}(ID,LOG,IS_DEBIT) VALUES (1,'${money}',0)");
        if(addError==true)
          {
            await txn.execute("UPDATE UserDatad SET IS_DEBIT = 0 WHERE ID = 0");

          }
        else{
          await txn.execute("UPDATE UserData SET IS_DEBIT = 0 WHERE ID = 0");

        }



      } else {
        await txn.execute("UPDATE UserData SET BALANCE = $money WHERE ID = 1");
        await txn.execute("INSERT INTO ${DbQueries.LOGTABLE}(ID,LOG,IS_DEBIT) VALUES (1,'${money}/-',1)");

        if(addError==true)
          {
            await txn.execute("UPDATE UsesrData SET IS_DEBIT = 1 WHERE ID = 1");

          }
        else{
          await txn.execute("UPDATE UserData SET IS_DEBIT = 1 WHERE ID = 1");

        }
      }
    }).onError((error, stackTrace) {

      showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (ctx) => AlertDialog(
          title: const Text("There is an error in the transaction"),
          // content: const Text("Please check the DB queries"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Container(
                color: Color(0xffBB86FC),
                padding: const EdgeInsets.all(14),
                child: const Text("okay",style: TextStyle(color: Colors.white),),
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

    return queryResult.map((e) => UserModel.fromMap(e)).toList();
  }
  Future<List<UserLog>> retrieveLogs() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.query('${DbQueries.LOGTABLE}');

    return queryResult.map((e) => UserLog.fromMap(e)).toList();
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
