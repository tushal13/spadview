import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/category_modal.dart';
import '../modal/saving_goal_modal.dart';
import '../modal/saving_moddal.dart';
import '../modal/transaction_modal.dart';
import '../modal/user_modal.dart';

Future<String?> getStoredUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}


class DbHelper  {

  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();

   Logger l = Logger();

  late Database dbase;

  String userTable = 'usertable';
  String cetegoryTable = 'categorytable';
  String transactionTable = 'transactiontable';
  String savingTable = 'savingtable';
  String savingGoalTable = 'savinggoaltable';

  String sgId = 'Id';
  String sgName = 'Name';
  String sgDate = 'Date';
  String sgAmount = 'Amount';

  String sId = 'Id';
  String sName = 'Name';
  String sTamount = 'TargetAmount';
  String sTdate = 'TargetDate';
  String sCurrentProgress = 'CurrentProgress';
  String sImage = 'Image';

  String coluId = 'Id';
  String coluName = 'Name';
  String coluEmail = 'Email';
  String coluPassword = 'Password';
  String coluBalance = 'Balance';
  String coluImage = 'Image';

  String categoryColuId = 'Id';
  String categoryColuTitle = 'Title';
  String categoryColuImage = 'Image';

  String tableColuId = 'Id';
  String tableColuAmount = 'Amount';
  String tableColuDescription = 'Description';
  String tableColuCategory = 'Category';
  String tableColuType = 'Type';
  String tableColuTime = 'Time';
  String tableColuDate = 'Date';


  initDB() async {
    String user = await getStoredUsername() ?? 'User';
    l.d('${user}');
    String currentUser = user ;
    String Dbpath = await getDatabasesPath();

    String Dbname = '$currentUser.db';

    String path = join(Dbpath, Dbname);

    dbase = await openDatabase(path, version: 1 , onCreate: (db, version) async{


      await db.execute('CREATE TABLE $userTable($coluId INTEGER PRIMARY KEY AUTOINCREMENT, $coluName  TEXT, $coluEmail TEXT, $coluPassword TEXT, $coluBalance TEXT, $coluImage BLOB)').then((value) => l.w("User table created..."));

      await db
          .execute(
          "CREATE TABLE IF NOT EXISTS $cetegoryTable($categoryColuId INTEGER PRIMARY KEY AUTOINCREMENT,$categoryColuTitle TEXT,$categoryColuImage TEXT)")
          .then((value) => l.i("Category table created..."));

      await db.execute("CREATE TABLE IF NOT EXISTS $transactionTable($tableColuId INTEGER PRIMARY KEY AUTOINCREMENT,$tableColuAmount TEXT,$tableColuDescription TEXT,$tableColuCategory TEXT,$tableColuType TEXT,$tableColuDate TEXT,$tableColuTime TEXT)")
          .then((value) => l.i("Transaction table created..."));

      await db.execute("CREATE TABLE IF NOT EXISTS $savingTable($sId INTEGER PRIMARY KEY AUTOINCREMENT,$sName TEXT,$sTamount TEXT,$sTdate TEXT,$sCurrentProgress TEXT,$sImage BLOB)")
          .then((value) => l.i("Saving table created..."));

      await db.execute("CREATE TABLE IF NOT EXISTS $savingGoalTable($sgId INTEGER PRIMARY KEY AUTOINCREMENT,$sgName TEXT,$sgDate TEXT,$sgAmount TEXT)")
          .then((value) => l.i("Saving Goal table created..."));

      db.rawInsert("INSERT INTO $cetegoryTable VALUES (1,'Food','assets/images/Food.png')").then((value) => l.w("Category 1 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (2,'Entertainment','assets/images/Entertainment.png')").then((value) => l.w("Category 2 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (3,'Education','assets/images/Education.png')").then((value) => l.w("Category 3 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (4,'Healthcare','assets/images/Healthcare.png')").then((value) => l.w("Category 4 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (5,'Bill','assets/images/Bill.png')").then((value) => l.w("Category 5 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (6,'Freelance','assets/images/Freelance.png')").then((value) => l.w("Category 6 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (7,'Fuel','assets/images/Fuel.png')").then((value) => l.w("Category 7 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (8,'Gifts','assets/images/Gifts.png')").then((value) => l.w("Category 8 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (9,'Housing','assets/images/Housing.png')").then((value) => l.w("Category 9 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (10,'Investments','assets/images/Investments.png')").then((value) => l.w("Category 10 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (11,'Online-shopping','assets/images/Online-shopping.png')").then((value) => l.w("Category 11 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (12,'Pet','assets/images/Pet.png')").then((value) => l.w("Category 12 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (13,'Rent','assets/images/Rent.png')").then((value) => l.w("Category 13 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (14,'Salary','assets/images/Salary.png')").then((value) => l.w("Category 14 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (15,'Savings','assets/images/Savings.png')").then((value) => l.w("Category 15 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (16,'Shopping','assets/images/Shopping.png')").then((value) => l.w("Category 16 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (17,'Taxes','assets/images/Taxes.png')").then((value) => l.w("Category 17 created..."));
      db.rawInsert("INSERT INTO $cetegoryTable VALUES (18,'Transportation','assets/images/Transportation.png')").then((value) => l.w("Category 18 created..."));
    db.rawInsert("Insert INTO $cetegoryTable VALUES (19,'Utilities','assets/images/Utilities.png')").then((value) => l.w("Category 19 created..."));
    db.rawInsert("Insert INTO $cetegoryTable VALUES (20,'Other','assets/images/Other.png')").then((value) => l.w("Category 20 created..."));

    });

  }

  Future<void> registerUser({required UserModal user}) async {
    String query = 'INSERT INTO $userTable($coluName, $coluEmail, $coluPassword, $coluBalance,$coluImage) VALUES(?,?,?,?,?)';
    List args =[user.username, user.email, user.password, user.balance,user.image];
    return await dbase.rawInsert(query, args).then((value) => l.i("${userTable}"));
  }

  Future<bool> loginUser({required String username, required String password}) async {
    String query = 'SELECT * FROM $userTable WHERE $coluName = ? AND $coluPassword = ?';
    List args =[username, password,];
    List result = await dbase.rawQuery(query, args);

    if (result.isNotEmpty) {

      final user = UserModal.fromMap(User: result.first);
      if (user.password == password) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', user.username ?? 'user');
        await prefs.setDouble('balance', user.balance ?? 00.0);
        await prefs.setString('email', user.email ?? 'email');
        String encodedImage = base64.encode(user.image!);
        await prefs.setString('image', encodedImage);

        return true;
      }
    }
    return false;
  }

  Future<List<UserModal>>getUserByUsername({required String username}) async {
    String query = 'SELECT * FROM $userTable WHERE $coluName = ?';
    List args = [username];
    List allData = (await dbase.rawQuery(query, args)) ;
    l.w('${allData}');
    List<UserModal> allUser = allData.map((e) => UserModal.fromMap(User: e)).toList();
    l.i('${allData}');

    return allUser;
  }

  Future<List<CategoryModal>> getAllCategorys() async {
    String query = "SELECT * FROM $cetegoryTable";

    List allData = await dbase.rawQuery(query);

    List<CategoryModal> allCategorys =
    allData.map((e) => CategoryModal.fromMap(Category: e)).toList();
    l.i('${allData}');

    return allCategorys;
  }



  Future<void> updateSavingsGoalProgress(int savingsId, double currentProgress) async {
    String query = "UPDATE $savingTable SET $sCurrentProgress = ? WHERE $sId = ?";

    List args = [currentProgress, savingsId];

    await dbase.rawUpdate(query, args);
  }

  Future<SavingsGoal?> getSavingsGoalById( int savingsId) async {
    String query = "SELECT * FROM $savingTable WHERE $sId = ?";
    List args = [savingsId];

    List<Map<String, dynamic>> result = await dbase.rawQuery(query, args);

    if (result.isNotEmpty) {
      return SavingsGoal.fromMap(savingsGoal: result.first);
    } else {
      return null; // Return null if no matching savings goal is found
    }
  }


  Future<int> insertTransaction(
      {required TransactionModal transaction}) async {
    String query =" INSERT INTO $transactionTable( $tableColuAmount, $tableColuDescription, $tableColuCategory, $tableColuType, $tableColuDate, $tableColuTime) VALUES(?,?,?,?,?,?)";
    List args = [
      transaction.amount,
      transaction.description,
      transaction.category,
      transaction.type,
      transaction.date,
      transaction.time
    ];
    return await dbase.rawInsert(query, args);
  }

  Future<int> insertSaving(
      {required SavingsGoal saving}) async {
    String query =" INSERT INTO $savingTable( $sName, $sTamount, $sTdate, $sCurrentProgress, $sImage) VALUES(?,?,?,?,?)";
    List args = [
      saving.name,
      saving.targetAmount,
      saving.targetDate,
      saving.currentProgress,
      saving.image
    ];
    return await dbase.rawInsert(query, args);
  }


  Future<int> insertgoal(
      {required SavingGoalModal saving}) async {
    String query =" INSERT INTO $savingGoalTable( $sgName, $sgDate, $sgAmount) VALUES(?,?,?)";
    List args = [
      saving.name,
      saving.date,
      saving.amount
    ];
    return await dbase.rawInsert(query, args);
  }

  Future<List<SavingsGoal>>getAllSavings() async {
    String query = "SELECT * FROM $savingTable";
    List allData = await dbase.rawQuery(query);
l.f("${allData}");
    List<SavingsGoal> allSavings = allData.map((e) => SavingsGoal.fromMap(savingsGoal: e)).toList();
l.f("${allSavings}");
    return allSavings;
  }

  Future<List<TransactionModal>>getAllTransactions() async {
    String query = "SELECT * FROM $transactionTable";
    List allData = await dbase.rawQuery(query);
    l.f("${allData}");
    List<TransactionModal> allTransaction = allData.map((e) => TransactionModal.fromMap(Transaction: e)).toList();
    // l.f("${allTransaction[0].category}");
    return allTransaction;
}

  Future<List<SavingGoalModal>> getAllGoals() async {
    String query = "SELECT * FROM $savingGoalTable";

    List allData = await dbase.rawQuery(query);
    l.f("Date : ${allData}");
List<SavingGoalModal> allGoals = allData.map((e) => SavingGoalModal.fromMap( Goal: e)).toList();
    return allGoals;
  }

  getTransctionsbydate({required String date}) async {
    String query = 'SELECT * FROM $transactionTable WHERE $tableColuDate = ? ORDER BY $tableColuDate';
    List args = [date];
    List allData = await dbase.rawQuery(query, args);
    l.f("Date : ${allData}");
    return allData;

  }

  deleteTransaction({required int id}) async {
    String query = 'DELETE FROM $transactionTable WHERE $tableColuId = ?';
    List args = [id];
    await dbase.rawDelete(query, args);
  }

}
