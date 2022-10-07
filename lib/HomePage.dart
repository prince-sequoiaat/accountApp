import 'package:account_app/Services/queries.dart';
import 'package:account_app/TranscationTable.dart';
import 'package:flutter/material.dart';

import 'Services/DatabaseHandler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseHandler handler;
  int money = 1000;
  UserModel? userModel;
  List<UserLog> userLog = [];
  bool addError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().then((value2) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        handler.retrieveUsers().then((value) {
          // print("====><><><><><><><>>  ${value.elementAt(0).toMap()}");
          userModel = UserModel.fromMap(value.elementAt(0).toMap());
        });
// Here you can write your code

        setState(() {
          // Here you can write your code for open new view
        });
      });

      setState(() {});
    }).whenComplete(() async {
      // handler.initializeDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText:
                          '${userModel?.FIRST_NAME} ${userModel?.LAST_NAME}',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '${userModel?.EMAIL}',
                      prefixIcon: const Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '${userModel?.PHONE}',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: '${userModel?.BALANCE}',
                      prefixIcon: const Icon(Icons.monetization_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // userLog = [];
                          money = money + 10;

                          handler
                              .updateTransaction(money, 1, addError: addError)
                              .whenComplete(() {
                            handler.retrieveUsers().then((value) {
                              print(
                                  "====><><><><><><><>>  ${value.elementAt(0).toMap()}");
                              userModel =
                                  UserModel.fromMap(value.elementAt(0).toMap());
                              userLog.clear();

                              handler.retrieveLogs().then((value2) {
                                value2.forEach((element) {
                                  setState(() {});

                                  userLog.add(element);
                                });
                              });

                              setState(() {
                                userLog.forEach((element) {
                                  print("======>>>> ${element.toMap()}");
                                  setState(() {});
                                });
                              });
                            });
                          }).whenComplete(() {
                            setState(() {});
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: const Text(
                          'Credit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          money = money - 10;

                          handler
                              .updateTransaction(money, 0, addError: addError)
                              .whenComplete(() {
                            handler.retrieveUsers().then((value) {

                              userModel =
                                  UserModel.fromMap(value.elementAt(0).toMap());
                              userLog.clear();

                              handler.retrieveLogs().then((value2) {
                                value2.forEach((element) {
                                  setState(() {});

                                  userLog.add(element);
                                });
                              });

                              setState(() {
                                userLog.forEach((element) {
                                  setState(() {});
                                });
                              });
                            });
                          }).whenComplete(() {
                            setState(() {});
                          });
                          // money = money - 10;
                          // handler
                          //     .updateTransaction(money, 0, addError: addError)
                          //     .whenComplete(() {
                          //   handler.retrieveUsers().then((value) {
                          //     print(
                          //         "====><><><><><><><>>  ${value.elementAt(0).toMap()}");
                          //     userModel =
                          //         UserModel.fromMap(value.elementAt(0).toMap());
                          //   });
                          //   setState(() {});
                          // }).whenComplete(() {
                          //   setState(() {});
                          // });
                          // userLog.clear();
                          // handler.retrieveLogs().then((value2) {
                          //   print("------->>>>>>> ${value2.toList()}");
                          //   value2.forEach((element) {
                          //     userLog.add(element);
                          //   });
                          // });
                          // setState(() {});
                          // userLog.forEach((element) {
                          //   print("=====>${element.toMap()}");
                          //   setState(() {});
                          // });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: const Text(
                          'Debit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionTable()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'View Transactions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addError = !addError;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          addError == true ? Colors.red : Color(0xffBB86FC),
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: addError == true
                        ? const Text(
                            'Error Added',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Add Error',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
