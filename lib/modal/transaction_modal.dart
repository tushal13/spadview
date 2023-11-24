import 'dart:developer';

class TransactionModal {

  int? id;
  double? amount;
  String? description;
  String? category;
  String? type;
  String? time;
  String? date;

  TransactionModal(this.id, this.amount, this.description, this.category, this.type, this.time, this.date);


  TransactionModal.init() {
    log("Empty transaction initialized...");
  }
  factory TransactionModal.fromMap({required Map Transaction}) {
    return TransactionModal(
      Transaction['Id'],
      double.parse(Transaction['Amount']),
      Transaction['Description'],
      Transaction['Category'],
      Transaction['Type'],
      Transaction['Time'],
      Transaction['Date'],
    );
  }
}