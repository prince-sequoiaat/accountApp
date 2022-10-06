class DbQueries {
  static const String TABLENAME="UserData";
  static const String createUserTable =
      "CREATE TABLE $TABLENAME(ID INT NOT NULL,FIRST_NAME TEXT NOT NULL,LAST_NAME TEXT NOT NULL,EMAIL TEXT NOT NULL,PHONE INT NOT NULL, BALANCE DOUBLE NOT NULL,IS_DEBIT INT NOT NULL,PRIMARY KEY (ID));";
}

class UserModel {
  final int? ID;
  final String FIRST_NAME;
  final String LAST_NAME;
  final String EMAIL;
  final int PHONE;
  final double BALANCE;
  final int IS_DEBIT;

  UserModel(
      {this.ID,
      required this.FIRST_NAME,
      required this.LAST_NAME,
      required this.EMAIL,
      required this.BALANCE,
      required this.IS_DEBIT,
      required this.PHONE});

  UserModel.fromMap(Map<String, dynamic> res)
      : ID = res["ID"],
        FIRST_NAME = res["FIRST_NAME"],
        EMAIL = res["EMAIL"],
        LAST_NAME = res["LAST_NAME"],
        BALANCE = res["BALANCE"],
        IS_DEBIT = res["IS_DEBIT"],
        PHONE = res["PHONE"];

  Map<String, Object?> toMap() {
    return {
      'ID': ID,
      'FIRST_NAME': FIRST_NAME,
      'EMAIL': EMAIL,
      'LAST_NAME': LAST_NAME,
      'BALANCE': BALANCE,
      'IS_DEBIT': IS_DEBIT,
      'PHONE': PHONE,
    };
  }
}

class UserLog {
  final int? ID;
  final String LOG;
  final String IS_DEBIT;

  UserLog({
    this.ID,
    required this.LOG,
    required this.IS_DEBIT,
  });

  UserLog.fromMap(Map<String, dynamic> res)
      : ID = res["ID"],
        LOG = res["LOG"],
        IS_DEBIT = res["IS_DEBIT"];

  Map<String, Object?> toMap() {
    return {
      'ID': ID,
      'LOG': LOG,
      'IS_DEBIT': IS_DEBIT,
    };
  }
}
