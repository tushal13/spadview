import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/heatmapcontroller.dart';
import '../../controller/transactioncontroller.dart';
import '../../helper/database_helper.dart';
import '../../modal/transaction_modal.dart';
import '../../utility/animation/fade controller.dart';
import '../component/tran_tile.dart';

class MonthlyPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TransactionController tran = Provider.of<TransactionController>(context,listen: false);
    DateTime earliestDate = tran.transactionList.isNotEmpty?DateFormat("MMM d, yyyy").parse(Provider.of<TransactionController>(context,listen: false).transactionList.first.date!):DateTime.now().subtract(const Duration(days: 0));
    DateTime latestDate = tran.transactionList.isNotEmpty?DateFormat("MMM d, yyyy").parse(Provider.of<TransactionController>(context,listen: false).transactionList.last.date!) :DateTime.now().add(const Duration(days: 0));

    return Scaffold(
      appBar: AppBar(title:   const Text('Monthly Data'),),
      body: Consumer<HeatmapController>(
        builder: (context,pro,child){ {
          pro.updateDateColorMap(context);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:16 ),
                child: FadeAnimation(
                  1,02,HeatMap(
                    startDate: earliestDate,
                    endDate: latestDate.add(const Duration(days: 1)),
                    defaultColor: Colors.grey.withOpacity(0.2),
                    textColor: Colors.black,
                    colorMode: ColorMode.color,
                    showColorTip: false,
                    showText: true,
                    scrollable: true,
                    borderRadius: 8,colorTipCount:  10,
                    fontSize: 12,
                    size: 25,
                    margin: const EdgeInsets.all(4),
                    datasets: pro.dateColorMap,
                    colorsets: pro.colorsets,
                    onClick: (date) {
                      pro.dateColorMap.clear();
                     pro.setSelectedDate(date);
                    },
                  ),
                ),
              ),
              const Gap(10),
               pro.selectedDate != null?
                FadeAnimation(
                  1,0, Text(
                    'Transactions for ${DateFormat("MMM d, yyyy").format(pro.selectedDate!)}:',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ):FadeAnimation(
                  5,0, const Text(
        'Recent Transactions',
        style: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 16),
          ),
                ),
              Expanded(
                child: Consumer<TransactionController>(
                  builder: (context,tra,_) {
                    return tra.transactionList.isEmpty ? Center(  child: Text("No Transactions Yet",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),) ):pro.selectedDate != null ?  ListView.builder(
                      itemCount: tra.transactionList.length,
                      itemBuilder: (context, index) {
                        TransactionModal tran = tra.transactionList[index];

                        DateTime dateTime = DateFormat("MMM d, yyyy").parse(tran.date!);

                        return Provider.of<HeatmapController>(context).selectedDate == dateTime
                            ? FadeAnimation(

                          1+index.toDouble() % index>1?3:index.toDouble()/3 ,20, Dismissible(
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
                              'Are you sure you want to delete the item',
                              btnCancelOnPress: () {
                                tra.init();
                              },
                              btnOkOnPress: () async {
                                await DbHelper.dbHelper
                                    .deleteTransaction(id: tran.id ?? 0);
                                tra.init();
                              },
                            )
                                .show();
                          },
                          movementDuration: Duration(seconds: 1),
                          onDismissed: (direction) async {
                            await DbHelper.dbHelper
                                .deleteTransaction(id: tran.id ?? 0);
                            tra.init();
                            print('Item dismissed');
                          },
                          background: Container(
                            color:
                            Colors.red,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                ),
                              ],
                            ),
                          ),
                            child: Tile(
                            tital: tran.category ?? 'Food',
                            subtital: tran.description ?? "",
                            image: 'assets/images/${tran.category ?? 'Food'}.png',
                            date: tran.date ?? "",
                            amount: Text(
                                "${tran.type == "INCOME" ? '+' : '-'} ₹${tran.amount ?? ''}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: tran.type == "INCOME" ? Colors.green : Colors.red,
                                ),
                            ),
                            color:Colors.primaries[Random().nextInt(Colors.primaries.length)],
                        ),
                          ),
                            )
                            :Container(
                        );;
                      },
                    ):ListView.builder(itemCount: tra.transactionList.length,itemBuilder: (context, index){
                      TransactionModal tran = tra.transactionList[index];
                      return FadeAnimation(
                        1+index.toDouble() % index>5?7:index.toDouble()/5 ,20, Tile(tital:tran.description , subtital:tran.date , image:'assets/images/${tran.category}.png' , color: Colors.primaries[Random().nextInt(Colors.primaries.length)], amount: Text(
                        "  ${tran.type == "INCOME" ? '+' : '-'} ₹${tran.amount}",style: TextStyle(fontSize: 16,color: tran.type == 'INCOME' ?Colors.greenAccent :Colors.red ),), ),
                      );
                    });
                  }
                ),
              )
            ],
          );
        }
        },),
    );
  }
}
