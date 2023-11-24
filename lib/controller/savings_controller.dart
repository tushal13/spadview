import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../helper/database_helper.dart';
import '../modal/saving_goal_modal.dart';
import '../modal/saving_moddal.dart';

class SavingsController with ChangeNotifier {
  List<SavingsGoal> savingsGoal = [];
  List<SavingGoalModal> transactionListGoal = [];

  Uint8List? imageBytes  ;


  Future<Uint8List> loadImageBytes() async {
    ByteData byteData = await rootBundle.load('assets/images/str.png');
    imageBytes = byteData.buffer.asUint8List();
    log('${imageBytes}');
    return imageBytes!;
  }

  SavingsController(){
    init();
    loadImageBytes();

  }

  init() async {
    savingsGoal = await DbHelper.dbHelper.getAllSavings() ?? [];
  transactionListGoal = await DbHelper.dbHelper.getAllGoals() ?? [];
    notifyListeners();
    return 0;
  }



  Future<void> addAmountToSavingsGoal(int savingsId, double amountToAdd) async {
    SavingsGoal? savings = await DbHelper.dbHelper.getSavingsGoalById(savingsId);
    double newProgress = savings!.currentProgress! + amountToAdd;
    await DbHelper.dbHelper.updateSavingsGoalProgress(savingsId, newProgress);
    await DbHelper.dbHelper.initDB();
    init();
  }







  String date = '${DateFormat.yMMMd().format(DateTime.now())}';

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



}