import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/transactioncontroller.dart';
import '../../helper/database_helper.dart';
import '../../modal/transaction_modal.dart';
import '../../utility/animation/fade controller.dart';
import '../component/tran_tile.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Transactions History',
            style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
          )),
      body: Consumer<TransactionController>(
          builder: (context, transactionController, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: transactionController.transactionList.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemCount: transactionController.transactionList.length,
                    itemBuilder: (context, index) {
                      transactionController.transactionList.sort((a, b) {
                        DateTime aDateTime =
                            DateFormat("MMM d, yyyy").parse(a.date!);
                        DateTime bDateTime =
                            DateFormat("MMM d, yyyy").parse(b.date!);
                        return bDateTime.compareTo(aDateTime);
                      });

                      TransactionModal Tran =
                          transactionController.transactionList[index];

                      bool isNewDate = index == 0 ||
                          (transactionController.transactionList[index].date ??
                                  '') !=
                              (transactionController
                                      .transactionList[index - 1].date ??
                                  '');

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isNewDate)
                            FadeAnimation(
                              1 + index.toDouble() % index > 1
                                  ? 3
                                  : index.toDouble(),
                              0,
                              Text(
                                Tran.date!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          FadeAnimation(
                            1 + index.toDouble() % index > 1
                                ? 3
                                : index.toDouble(),
                            20,
                            Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  headerAnimationLoop: false,
                                  animType: AnimType.scale,
                                  title: 'Warning',
                                  desc:
                                      'Are you sure you want to delete the item ?',
                                  btnCancelOnPress: () {
                                    transactionController.init();
                                  },
                                  btnOkOnPress: () async {
                                    await DbHelper.dbHelper
                                        .deleteTransaction(id: Tran.id ?? 0);
                                    transactionController.init();
                                  },
                                ).show();
                              },
                              movementDuration: Duration(seconds: 1),
                              onDismissed: (direction) async {
                                await DbHelper.dbHelper
                                    .deleteTransaction(id: Tran.id ?? 0);
                                transactionController.init();
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    Text('Delete',
                                        style: TextStyle(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                              child: Tile(
                                tital: Tran.category ?? 'Food',
                                subtital: Tran.description ?? "",
                                image:
                                    'assets/images/${Tran.category ?? 'Food'}.png',
                                date: '',
                                amount: Text(
                                  "${Tran.type == "INCOME" ? '+' : '-'} ₹${Tran.amount ?? ''}",
                                  style: TextStyle(
                                    fontSize: Tran.amount.toString().length > 8
                                        ? 14
                                        : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Tran.type == "INCOME"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              : const Center(
                  child: Center(
                      child: Text(
                    "No Transactions Yet",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )),
                ),
        );
      }),
    );
  }
}
