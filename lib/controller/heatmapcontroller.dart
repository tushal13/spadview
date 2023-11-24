import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controller/transactioncontroller.dart';
import '../modal/transaction_modal.dart';

class HeatmapController with ChangeNotifier {
  Map<DateTime, int> dateColorMap = {
    DateTime(2022, 1, 1): 1,
  };
  Map<int, Color> colorsets = {
    1: Color.fromARGB(20, 2, 179, 8),
    2: Color.fromARGB(40, 2, 179, 8),
    3: Color.fromARGB(60, 2, 179, 8),
    4: Color.fromARGB(80, 2, 179, 8),
    5: Color.fromARGB(100, 2, 179, 8),
    6: Color.fromARGB(120, 2, 179, 8),
    7: Color.fromARGB(150, 2, 179, 8),
    8: Color.fromARGB(180, 2, 179, 8),
    9: Color.fromARGB(220, 2, 179, 8),
    10: Color.fromARGB(255, 2, 179, 8),
  };

  DateTime? selectedDate;


  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }


  Future<void> updateDateColorMap(BuildContext context) async {
    List<TransactionModal> transactions = Provider
        .of<TransactionController>(context, listen: false)
        .transactionList;


    for (TransactionModal transaction in transactions) {
      DateTime date = DateFormat("MMM d, yyyy").parse(transaction.date!);

      dateColorMap[date] = (dateColorMap[date] ?? 0) + 1;
      log('${dateColorMap}');
      notifyListeners();
    }
  }




}