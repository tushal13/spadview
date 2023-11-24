import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/savings_controller.dart';
import '../../helper/database_helper.dart';
import '../../modal/saving_goal_modal.dart';
import '../../modal/saving_moddal.dart';
import '../../utility/animation/fade controller.dart';
import '../component/saving_tile2.dart';

class SavingGoalPage extends StatelessWidget {
  final int argument;
  SavingGoalPage({required this.argument});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SavingGoalModal savingGoal = SavingGoalModal.init();
  TextEditingController goalAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SavingsController save =
        Provider.of<SavingsController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(save.savingsGoal[argument].name ?? 'spandvieww'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: size.height * 0.175,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(save.savingsGoal[argument].image!),
                      fit: BoxFit
                          .cover, // You can specify how the image should fit within the container
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Gap(20),
                    Text(
                      'Saving Goal',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    Consumer<SavingsController>(
                      builder: (context, sav, child) {
                        {
                          return Text(
                              '₹ ${sav.savingsGoal[argument].currentProgress}',
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  color: Colors.white));
                        }
                      },
                    ),
                    Text(
                      '/₹ ${save.savingsGoal[argument].targetAmount}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    Consumer<SavingsController>(
                      builder: (context, sav, child) {
                        {
                          return SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 10,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 0,
                                  disabledThumbRadius: 0),
                            ),
                            child: Slider(
                              value:
                                  sav.savingsGoal[argument].currentProgress ??
                                      0.0,
                              onChanged: (val) {},
                              min: 0,
                              max:
                                  sav.savingsGoal[argument].targetAmount ?? 0.0,
                              activeColor: Colors.white,
                              inactiveColor: Colors.grey.shade300,
                              onChangeEnd: (val) {
                                log("${val}  Completed......................");
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child:Consumer<SavingsController> (
              builder: (context,sav,child) {
                return ListView.builder(
                    itemCount: sav.transactionListGoal.length,
                    itemBuilder: (context, index) {
                      return save.savingsGoal[argument].name == sav.transactionListGoal[index].name ? FadeAnimation(1+index.toDouble() % index>1?3:index.toDouble()/3 ,20, SavGoalTile(savingName: sav.transactionListGoal[index].name, savingdate: sav.transactionListGoal[index].date, amount: sav.transactionListGoal[index].amount,)):Container();

                });
              }
            )),
            GestureDetector(
              onTap: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Goal Amount',style: TextStyle(letterSpacing: 2,fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18),),
                          Gap(10),
                          TextFormField(
                          controller: goalAmountController,
                          validator:  (val) {
                            if (val!.isEmpty) {
                              return 'Please Enter Your Goal Amount';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Enter Goal Amount',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            prefixText: '₹ ',
                          ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                    ),
                          Gap(10),
                          GestureDetector(
                            onTap: () async {
                              if(formKey.currentState!.validate()){
                                savingGoal.id = save.savingsGoal[argument].id ?? 0;
                                savingGoal.name = save.savingsGoal[argument].name ?? '';
                                savingGoal.date = DateFormat.yMMMd().format(DateTime.now());
                                savingGoal.amount = double.parse(goalAmountController.text);
                                int id = await DbHelper.dbHelper.insertgoal( saving: savingGoal);
                                Provider.of<SavingsController>(context, listen: false).addAmountToSavingsGoal(save.savingsGoal[argument].id ?? 0, double.parse(goalAmountController.text));
                               }
                              goalAmountController.clear();
                              Navigator.of(context).pop();

                      }  ,

                            child: Container(
                              padding: const EdgeInsets.all(16),
                              width: size.width,
                              alignment: Alignment.center,
                              child: Text(
                                'Add Savings',
                                style: TextStyle(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-1.4, -1.0),
                                    end: Alignment(1.0, 1.0),
                                    stops: [-0.5, 1],
                                    colors: [
                                      Color(0xFF6101FF),
                                      Colors.blueAccent,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),

                    ),
                  );
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                width: size.width,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Savings',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.4, -1.0),
                      end: Alignment(1.0, 1.0),
                      stops: [-0.5, 1],
                      colors: [
                        Color(0xFF6101FF),
                        Colors.blueAccent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
