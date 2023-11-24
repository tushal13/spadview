import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:spadvieww/views/screens/saving_goal_page.dart';

import '../../controller/api_controller.dart';
import '../../controller/savings_controller.dart';
import '../../helper/database_helper.dart';
import '../../modal/saving_moddal.dart';
import '../../utility/animation/fade controller.dart';
import '../component/saving_tile.dart';

class SavingPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController goalNameController = TextEditingController();
  TextEditingController goalAmountController = TextEditingController();
  TextEditingController goalimageController = TextEditingController();
  SavingsGoal savingGoal = SavingsGoal.init();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Savings',
          style: TextStyle(
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(onPressed: () async {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    width: size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        )),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create a \nSaving Goal',
                            style: TextStyle(
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 38),
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Goal Name',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                const Gap(10),
                                TextFormField(
                                  controller: goalNameController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please Enter Your Goal Name';
                                    }
                                  },
                                  onChanged: (val) {
                                    Provider.of<Apicontroller>(context,
                                        listen: false)
                                        .Search(val: val);
                                    savingGoal.name = val;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Goal Name',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                const Text(
                                  'Goal Amount',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                const Gap(10),
                                TextFormField(
                                  controller: goalAmountController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please Enter Your Goal Name';
                                    }
                                  },
                                  onChanged: (val) {
                                    savingGoal.targetAmount =
                                        double.parse(val);
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText:
                                    'What Amount Would You like to Save?',
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                const Text(
                                  'Goal Images',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<SavingsController>(context,listen: false).loadImageBytes();
                                      },
                                      child: Container(
                                        height: size.height * 0.08,
                                        width: size.width * 0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                            Colors.black, // Border color
                                            width: 1, // Border width
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(16),
                                        ),
                                        child: Image.asset('assets/images/str.png',fit: BoxFit.fill,),
                                      ),
                                    ),
                                    Expanded(
                                      child: Consumer<Apicontroller>(
                                          builder: (context, pro, child) {
                                            return Container(
                                              height: size.height * 0.1,
                                              child: ListView.builder(
                                                  itemCount: pro.data.length,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            Uint8List bytes = (await NetworkAssetBundle(Uri.parse(
                                                                pro.data[index]
                                                                [
                                                                'largeImageURL']))
                                                                .load(
                                                                '${pro.data[index]['largeImageURL']}'))
                                                                .buffer
                                                                .asUint8List();
                                                            log('${bytes}');

                                                            savingGoal.image =
                                                                bytes;
                                                          },
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  20)),
                                                              child:
                                                              Image.network(
                                                                '${pro.data[index]['largeImageURL']}',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ));
                                                  }),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                const Text(
                                  'Due Date',
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 18),
                                ),
                                const Gap(10),
                                FadeAnimation(
                                  1,
                                  0,
                                  Container(
                                    width: size.width,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 5),
                                      child: Consumer<SavingsController>(
                                          builder: (context, sav, child) {
                                            return Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text("${sav.date}"),
                                                IconButton(
                                                    onPressed: () async {
                                                      sav.showMyDate(context);
                                                      savingGoal.targetDate =
                                                          sav.date;
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 16,
                                                    )),
                                              ],
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                GestureDetector(
                                  onTap: () async {
                                    savingGoal.id = 0;
                                    savingGoal.currentProgress = 0;
                                    int id = await DbHelper.dbHelper
                                        .insertSaving(saving: savingGoal);
                                    await DbHelper.dbHelper.initDB();
                                    Provider.of<SavingsController>(context,
                                        listen: false)
                                        .init();


                                    Navigator.pop(context);
                                    goalNameController.clear();
                                    goalAmountController.clear();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(-1.4, -1.0),
                                          end: Alignment(1.0, 1.0),
                                          stops: [-0.0, 1],
                                          colors: [
                                            Colors.blueAccent,
                                            Color(0xFF6101FF),
                                          ],
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Create Goal',
                                          style: TextStyle(
                                              letterSpacing: 2,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
                });
          }, icon: const Icon(Icons.add_box_outlined))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Container(
              height: size.height * 0.16,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-1.4, -1.0),
                    end: Alignment(1.0, 1.0),
                    stops: [-0.1, 0.35, 1],
                    colors: [
                      Colors.white,
                      Colors.blueAccent,
                      Color(0xFF6101FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Savings',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2),
                  ),
                  const Gap(10),
                  Consumer<SavingsController>(
                    builder: (context,sav,child) {
                      double total = sav.transactionListGoal.fold(0, (previousValue, element) => previousValue + element.amount!);
                      return Text(
                        '₹ ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      );
                    }
                  ),
                ],
              ),
            ),
            const Gap(20),
            Expanded(child:
                Consumer<SavingsController>(builder: (context, sav, child) {
              return sav.savingsGoal.isEmpty ? const Center(child: Text('No Savings Goals Yet',style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),)) :ListView.builder(
                itemCount: sav.savingsGoal.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageTransition(
                        type: PageTransitionType.fade,
                        alignment: Alignment.center, // or any other alignment
                        child: SavingGoalPage(
                          argument: index,
                        ),
                      ),);
                      DbHelper.dbHelper.getAllGoals();
                    },
                    child: SavingTile(
                      savingName: sav.savingsGoal[index].name,
                      progressAmount: sav.savingsGoal[index].currentProgress,
                      goalAmount: sav.savingsGoal[index].targetAmount,
                      image: sav.savingsGoal[index].image,
                    ),
                  );
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}
