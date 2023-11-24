import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/database_helper.dart';
import '../modal/transaction_modal.dart';

class TransactionController extends ChangeNotifier {

  List<TransactionModal> transactionList = [];
  String date = '${DateFormat.yMMMd().format(DateTime.now())}';
  String time = '${TimeOfDay.now().hour%12}:${TimeOfDay.now().minute}';
  String selecttype = 'INCOME';
  String edittype = '';
  String selectedcategory = 'Food';

  TransactionController(){
init();

  }

  init() async {
    transactionList = await DbHelper.dbHelper.getAllTransactions() ?? [];
    notifyListeners();
    return 0;
  }

  String selectType({required String type}) {
    selecttype=type;
    notifyListeners();
    return'';
  }

  String editType({required String type}) {
    selecttype=type;
    notifyListeners();
    return'';
  }




  String getSelected ({required String? category}) {
    selectedcategory = category!;
    notifyListeners();
    return'';
  }

  showMyDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate = DateFormat.yMMMd().format(pickDate);
      date =formattedDate;
    }
    notifyListeners();
  }

  showMyTime(BuildContext context) async {
    TimeOfDay? pickDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickDate != null) {
      time = pickDate.format(context);
    }

    notifyListeners();
  }


}