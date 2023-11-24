import 'dart:developer';

import 'package:flutter/services.dart';

class SavingsGoal {
  int? id;
  String? name;
  double? targetAmount;
  String? targetDate;
  double? currentProgress;
  Uint8List? image;

  SavingsGoal(
     this.id,
     this.name,
     this.targetAmount,
     this.targetDate,
    this.currentProgress ,
    this.image ,
  );

  SavingsGoal.init() {

    log("Empty savings goal initialized...");
  }


 factory SavingsGoal.fromMap({required Map savingsGoal}) {
    return SavingsGoal(
      savingsGoal['Id'],
      savingsGoal['Name'],
      double.parse(savingsGoal['TargetAmount']),
      savingsGoal['TargetDate'],
      double.parse(savingsGoal['CurrentProgress']),
      savingsGoal['Image'],
    );
  }


}
