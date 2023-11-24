import 'dart:developer';

class SavingGoalModal{
  int?id;
  String?name;
  String?date;
  double?amount;

  SavingGoalModal(this.id, this.name, this.date, this.amount,);

  SavingGoalModal.init() {

    log("Empty savings goal initialized...");
  }

  factory SavingGoalModal.fromMap({required Map Goal}) {
    return SavingGoalModal(Goal['Id'], Goal['Name'], Goal['Date'], double.parse(Goal['Amount']));

  }
}