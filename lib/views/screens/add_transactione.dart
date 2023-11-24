import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../controller/categorycontroller.dart';
import '../../controller/transactioncontroller.dart';
import '../../helper/database_helper.dart';
import '../../modal/transaction_modal.dart';
import '../../utility/animation/fade controller.dart';

class AddTransactionePage extends StatelessWidget {
  AddTransactionePage({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TransactionModal tran = TransactionModal.init();
  Logger l = Logger();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            amountController.clear();
            descriptionController.clear();

          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeAnimation(
                  2.5,
                  0,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 4,
                    ),
                    child: Text(
                      'Amount',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                FadeAnimation(
                  3,
                  20,
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xE7EBEBF1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: size.width * 0.35,
                            height: size.height * 0.055,
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: amountController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "000000",
                                  prefixText: '₹',
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please enter amount';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                tran.amount = double.parse(val);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  4.5,
                  0,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 4,
                    ),
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                FadeAnimation(
                  5,
                  20,
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xE7EBEBF1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: size.width * 0.855,
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      "Enter Your Transaction Description...",
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                              maxLines: 3,
                              onChanged: (val) {
                                tran.description = val;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  6,
                  0,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 4,
                    ),
                    child: Text(
                      'Category',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                FadeAnimation(
                  6.5,
                  10,
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xE7EBEBF1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Consumer<TransactionController>(
                                builder: ((context, pro, child) {
                              return DropdownButton(
                                  value: pro.selectedcategory,
                                  items: Provider.of<CategoryController>(
                                          context)
                                      .categoryList
                                      .map((e) => DropdownMenuItem(
                                            value: e.title,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 3),
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    width: size.width * 0.11,
                                                    height: size.height * 0.3,
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .primaries[Provider.of<
                                                                          CategoryController>(
                                                                      context)
                                                                  .categoryList
                                                                  .indexOf(e) %
                                                              Colors.primaries
                                                                  .length]
                                                          .withOpacity(0.75),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Image.asset(
                                                      e.image!,
                                                    ),
                                                  ),
                                                ),
                                                Text(e.title!),
                                                SizedBox(
                                                  width: size.width * 0.25,
                                                ),
                                              ],
                                            ),
                                          ))
                                      .toList(),
                                  borderRadius: BorderRadius.circular(12),
                                  dropdownColor: const Color(0xE7EBEBF1),
                                  iconEnabledColor: Colors.grey,
                                  iconSize: 28,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.6)),
                                  padding: const EdgeInsets.all(12),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle_rounded,
                                    color: Colors.white,
                                  ),
                                  menuMaxHeight: 250,
                                  underline: Container(),
                                  onChanged: (val) {
                                    l.i("${val}");
                                    pro.getSelected(category: val ?? 'Food');
                                    tran.category = val;
                                  });
                            }))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  7,
                  2,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 4,
                    ),
                    child: Text(
                      'Type',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.001,
                ),
                Consumer<TransactionController>(builder: (context, pro, child) {
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                          7.5,
                          10,
                          Container(
                            width: size.width * 0.35,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: (pro.selecttype == 'INCOME')
                                        ? Colors.blue
                                        : Colors.grey,
                                    width: 1),
                                borderRadius: BorderRadius.circular(14)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor: Colors.blue,
                                      value: 'INCOME',
                                      groupValue: pro.selecttype,
                                      onChanged: (val) {
                                        pro.selectType(type: val ?? 'INCOME');
                                        tran.type = val ?? 'INCOME';
                                      }),
                                  const Text(
                                    'INCOME',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.012,
                        ),
                        FadeAnimation(
                          8,
                          20,
                          Container(
                            width: size.width * 0.40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: (pro.selecttype == 'EXPANSE')
                                      ? Colors.blue
                                      : Colors.grey,
                                  width: 1),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                      activeColor: Colors.blue,
                                      value: 'EXPANSE',
                                      groupValue: pro.selecttype,
                                      onChanged: (val) {
                                        pro.selectType(type: val ?? 'INCOME');
                                        tran.type = val ?? 'EXPANSE';
                                      }),
                                  const Text(
                                    'EXPANSE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
                FadeAnimation(
                  8.5,
                  0,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 4,
                    ),
                    child: Text(
                      'Date & Time',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FadeAnimation(
                      9,
                      0,
                      Container(
                        width: size.width * 0.32,
                        decoration: BoxDecoration(
                            color: const Color(0xE7E0DFEC),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5),
                          child: Consumer<TransactionController>(
                              builder: (context, pro, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${pro.time}"),
                                IconButton(
                                    onPressed: () async {
                                      pro.showMyTime(context);
                                      tran.time = pro.time ??
                                          '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                                    },
                                    icon: const Icon(
                                      Icons.access_time_rounded,
                                      size: 20,
                                    )),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      9,
                      0,
                      Container(
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            color: const Color(0xE7E0DFEC),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 5),
                          child: Consumer<TransactionController>(
                              builder: (context, pro, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${pro.date}"),
                                IconButton(
                                    onPressed: () async {
                                      pro.showMyDate(context);
                                      tran.date = pro.date ;
                                    },
                                    icon: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                    )),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                FadeAnimation(
                  10,
                  0,
                  Consumer<TransactionController>(
                      builder: (context, pro, child) {
                        return GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              tran.id = 0;
                              tran.date = pro.date ;
                              tran.time = pro.time ;
                              tran.type = pro.selecttype ?? 'EXPANSE';
                              tran.category = pro.selectedcategory ?? 'Food';
                              tran.description =
                                  tran.description ?? tran.category;
                              tran.amount = tran.amount ?? 0;

                              l.f("Amount: ${tran.amount} \n date: ${tran.date} \ntime: ${tran.time} \ncategory: ${tran.category} \n description: ${tran.description} \ntype: ${tran.type}");
                              int id = await DbHelper.dbHelper
                                  .insertTransaction(transaction: tran);
                              pro.init();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          ' Transaction added successfully.')));
                              Navigator.of(context).pop();
                              amountController.clear();
                              descriptionController.clear();
                              pro.selecttype = 'INCOME';
                              pro.selectedcategory = 'Food';
                              pro.date = DateFormat.yMMMd().format(DateTime.now());
                              pro.time = '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xFFbaeaf9),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'Add',
                              style: GoogleFonts.poppins(
                                letterSpacing: 2,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
