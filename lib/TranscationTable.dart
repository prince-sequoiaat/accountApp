import 'package:account_app/Services/queries.dart';
import 'package:flutter/material.dart';

import 'Services/DatabaseHandler.dart';

class TransactionTable extends StatefulWidget {
  const TransactionTable({Key? key}) : super(key: key);

  @override
  State<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends State<TransactionTable> {
  List<UserLog> userLog = [];
  late DatabaseHandler handler;

  @override
  void initState() {
    handler = DatabaseHandler();
    // TODO: implement initState
    super.initState();
    // handler.updateTransaction(money, 0).whenComplete(() {
    handler.retrieveLogs().then((value2) {
      print("------->>>>>>> ${value2.toList()}");
      // value2=userLog;
      value2.forEach((element) {
        userLog.add(element);
      });
    }).whenComplete(() {
      setState(() {});
    });
    userLog.forEach((element) {
      print("====> CHECK CHECK CHECK ====> ${element.toMap()}");
      setState(() {});
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Table",
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DataTable(
                        // textDirection: TextDirection.rtl,
                        // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        border: TableBorder.all(
                            width: 2.0, color: const Color(0xffBB86FC)),
                        columns: const [
                          DataColumn(label: Text('LOG')),
                          DataColumn(label: Text('ID_DEBIT')),
                        ],
                        rows: [
                          for (UserLog i in userLog)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text(i.LOG)),
                                //Extracting from Map element the value
                                DataCell(i.IS_DEBIT == 0
                                    ? const Text(
                                        "Credit",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : const Text(
                                        "Debit",
                                        style: TextStyle(color: Colors.red),
                                      )),
                              ],
                            )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
