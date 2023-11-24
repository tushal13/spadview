import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:spadvieww/views/screens/saving_page.dart';
import 'package:spadvieww/views/screens/week_page.dart';
import '../../controller/loginscreen_controller.dart';
import '../../controller/savings_controller.dart';
import '../../controller/transactioncontroller.dart';
import '../../controller/usercontroller.dart';
import '../../helper/database_helper.dart';
import '../../modal/transaction_modal.dart';
import '../../utility/animation/fade controller.dart';
import '../component/setting_tile.dart';
import '../component/tran_tile.dart';
import 'package:pdf/widgets.dart' as pw;
import 'add_transactione.dart';
import 'history_page.dart';
import 'login_page.dart';
import 'monthly_page.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionController transactionController =
        Provider.of<TransactionController>(context);
    UserController user = Provider.of<UserController>(context, listen: false);
    Logger l = Logger();
    transactionController.transactionList.sort((a, b) {
      DateTime aDateTime = DateFormat("MMM d, yyyy").parse(a.date!);
      DateTime bDateTime = DateFormat("MMM d, yyyy").parse(b.date!);
      return bDateTime.compareTo(aDateTime);
    });
    Size size = MediaQuery.of(context).size;

    SavingsController sav =
        Provider.of<SavingsController>(context, listen: false);

    double expanse = transactionController.transactionList
        .where((expense) => expense.type == "EXPANSE")
        .fold(0.0, (sum, expense) => sum + (expense.amount ?? 0.0));

    double income = transactionController.transactionList
        .where((income) => income.type == "INCOME")
        .fold(0.0, (sum, income) => sum + (income.amount ?? 0.0));

    double savings = sav.transactionListGoal
        .fold(0, (previousValue, element) => previousValue + element.amount!);

    final pw.Document pdf = pw.Document();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Hi,',
              style: TextStyle(fontSize: 24, letterSpacing: 1),
            ),
            Text(
              '${user.username ?? ''}',
              style: const TextStyle(
                  fontSize: 24, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(FluentIcons.list_24_regular),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  type: PageTransitionType.size,
                  duration: const Duration(seconds: 1),
                  alignment: Alignment.bottomCenter, // or any other alignment
                  child: ProfilePage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 20,
                child: CircleAvatar(
                  radius: 19,
                  backgroundImage: MemoryImage(user.image ?? Uint8List(0)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: size.height * 0.26,
                decoration: BoxDecoration(
                    color: const Color(0xE7E0DFEC),
                    borderRadius: BorderRadius.circular(12)),
                child: Consumer<TransactionController>(
                    builder: (context, transactionController, child) {
                  double etotal = transactionController.transactionList
                      .where((expense) => expense.type == "EXPANSE")
                      .fold(0.0, (sum, income) => sum + (income.amount ?? 0.0));

                  double itotal = transactionController.transactionList
                      .where((expense) => expense.type == "INCOME")
                      .fold(0.0, (sum, income) => sum + (income.amount ?? 0.0));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 24.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffB6DAAE),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                    const Text('\t\t\tIncome',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Consumer<UserController>(
                                    builder: (context, value, child) {
                                  return Text(
                                    '₹ ${(value.total ?? 25000) - etotal + itotal}',
                                    style: const TextStyle(fontSize: 26),
                                  );
                                }),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 24.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFEB9AA),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    const Text('Spant',
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  '₹ ${etotal}',
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.04,
                      ),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: PieChart(
                          swapAnimationCurve: Curves.easeInOut,
                          swapAnimationDuration:
                              const Duration(milliseconds: 3000),
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: const Color(0xffB6DAAE),
                                title: '',
                                value:
                                    Provider.of<UserController>(context).total,
                                radius: 40,
                              ),
                              PieChartSectionData(
                                color: const Color(0xffFEB9AA),
                                value: etotal,
                                title: '',
                                radius: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                    ],
                  );
                }),
              ),
            ),
            FadeAnimation(
              2.5,
              0,
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 24,
                ),
                child: Text(
                  'Recent Transactions',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            Consumer<TransactionController>(builder: (context, pro, child) {
              return Expanded(
                child: pro.transactionList.isEmpty ? Center(  child: Text("No Transactions Yet",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),) ): ListView.builder(
                    itemCount: pro.transactionList.length,
                    itemBuilder: (context, index) {
                      TransactionModal tran = pro.transactionList[index];
                      return FadeAnimation(
                          1 + index.toDouble() % index > 3
                              ? 5
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
                                'Are you sure you want to delete the item',
                                btnCancelOnPress: () {
                                  pro.init();
                                },
                                btnOkOnPress: () async {
                                  await DbHelper.dbHelper
                                      .deleteTransaction(id: tran.id ?? 0);
                                  pro.init();
                                },
                              )
                                  .show();
                            },
                            movementDuration: Duration(seconds: 1),
                            onDismissed: (direction) async {
                              await DbHelper.dbHelper
                                  .deleteTransaction(id: tran.id ?? 0);
                              pro.init();
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
                              tital: tran.description,
                              subtital: tran.date,
                              image: 'assets/images/${tran.category}.png',
                              color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                              amount: Text(
                                "  ${tran.type == "INCOME" ? '+' : '-'} ₹${tran.amount}",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: tran.type == 'INCOME'
                                      ? Colors.greenAccent
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ));
                    }),
              );
            }),
          ]),

      drawer: Drawer(
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 52,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: MemoryImage(user.image ?? Uint8List(0)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.username ?? 'User',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                'Current Balance:  ${user.total}' ?? '25000',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.6)),
              ),
              Text(
                user.email ?? 'user123@gmail.com',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Colors.black,
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 10),
            child: SettingTile(
              titel: 'Profile',
              icon: FluentIcons.person_24_regular,
              onButtonPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: ProfilePage(),
                  ),
                );
              },
              onTilePressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: ProfilePage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SettingTile(
              titel: 'Savings',
              icon: FluentIcons.wallet_24_regular,
              onButtonPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: SavingPage(),
                  ),
                );
              },
              onTilePressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: SavingPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SettingTile(
              titel: 'Monthly Report',
              icon: FluentIcons.calendar_28_regular,
              onButtonPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: MonthlyPage(),
                  ),
                );
              },
              onTilePressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: MonthlyPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SettingTile(
              titel: 'Add Transaction',
              icon: FluentIcons.add_square_multiple_24_regular,
              onButtonPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: AddTransactionePage(),
                  ),
                );
              },
              onTilePressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: AddTransactionePage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SettingTile(
              titel: 'Transaction History',
              icon: FluentIcons.apps_list_detail_24_regular,
              onButtonPressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: HistoryPage(),
                  ),
                );
              },
              onTilePressed: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.bottomCenter, // or any other alignment
                    child: HistoryPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SettingTile(
              titel: 'Export Data',
              icon: FluentIcons.document_pdf_24_regular,
              onButtonPressed: () async {
                UserController user =
                    Provider.of<UserController>(context, listen: false);
                String date =
                    '${DateFormat('dd/MM/yyyy').format(DateTime.now())}';

                String time =
                    '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                final logoImage = pw.MemoryImage(
                  (await rootBundle.load("assets/images/AppIcon.png"))
                      .buffer
                      .asUint8List(),
                );
                final image = pw.MemoryImage(
                  (user.image ?? Uint8List(0)),
                );

                pdf.addPage(
                  pw.MultiPage(
                      margin: const pw.EdgeInsets.all(10),
                      pageFormat: PdfPageFormat.a4,
                      build: (pw.Context context) {
                        return <pw.Widget>[
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Container(
                                      color: PdfColors.black,
                                      width: 100,
                                      height: 50,
                                      child: pw.Column(),
                                    ),
                                    pw.Text("Spandview",
                                        style: pw.TextStyle(
                                            color: PdfColors.black,
                                            fontSize: 19,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Container(
                                      color: PdfColors.black,
                                      width: 100,
                                      height: 713,
                                      child: pw.Column(),
                                    ),
                                  ]),
                              pw.Container(
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(children: [
                                        pw.SizedBox(width: 20),
                                        pw.Row(children: [
                                          pw.Text('Time : ',
                                              style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text(time,
                                              style: pw.TextStyle(
                                                  color: PdfColors.grey,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        ]),
                                        pw.SizedBox(width: 60),
                                        pw.Text('Spandview',
                                            style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 18,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(width: 50),
                                        pw.Row(children: [
                                          pw.Text('Date : ',
                                              style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text(date,
                                              style: pw.TextStyle(
                                                  color: PdfColors.grey,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        ])
                                      ]),
                                      pw.SizedBox(height: 40),
                                      pw.Row(children: [
                                        pw.SizedBox(width: 20),
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text('Spant',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 36,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      letterSpacing: 2)),
                                              pw.Text('Report',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 60,
                                                      fontWeight:
                                                          pw.FontWeight.normal,
                                                      letterSpacing: 2)),
                                            ]),
                                        pw.SizedBox(width: 140),
                                        pw.Image(
                                          logoImage,
                                          height: 100,
                                        ),
                                      ]),
                                      pw.SizedBox(height: 30),
                                      pw.Row(children: [
                                        pw.SizedBox(width: 30),
                                        pw.Container(
                                          child: pw.ClipOval(
                                            child: pw.Image(image,
                                                height: 300, width: 160),
                                          ),
                                        ),
                                        pw.SizedBox(width: 20),
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(user.username ?? '',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 36,
                                                      fontWeight:
                                                          pw.FontWeight.bold)),
                                              pw.SizedBox(height: 15),
                                              pw.Text('tushalgopani3@gmail.com',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.grey,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          pw.FontWeight.bold)),
                                              pw.SizedBox(height: 10),
                                              pw.Row(children: [
                                                pw.Text('Current Balance : ',
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 18,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(
                                                    '${(user.total ?? 25000) - expanse + income}',
                                                    style: pw.TextStyle(
                                                        color: PdfColors.grey,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                            ])
                                      ]),
                                      pw.SizedBox(height: 70),
                                      pw.Row(children: [
                                        pw.SizedBox(width: 20),
                                        pw.Column(children: [
                                          pw.Container(
                                              height: 2,
                                              width: 440,
                                              color: PdfColors.black),
                                          pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.Column(children: [
                                                  pw.Text('NO',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('1',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('2',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('3',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                ]),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.SizedBox(width: 50),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.Column(children: [
                                                  pw.Text('Type',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('Income',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.green,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('Expanace',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.red,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('Savings',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.blue,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                ]),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.SizedBox(width: 50),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.Column(children: [
                                                  pw.Text('Amount',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('$income',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.green,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('$expanse',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.red,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('$savings',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.blue,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                ]),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                              ]),
                                          pw.Container(
                                              height: 2,
                                              width: 440,
                                              color: PdfColors.black),
                                          pw.SizedBox(
                                            height: 10,
                                          ),
                                          pw.Row(children: [
                                            pw.SizedBox(
                                              width: 120,
                                            ),
                                            pw.Text('Total Amount :',
                                                style: const pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 18,
                                                  letterSpacing: 2,
                                                )),
                                            pw.SizedBox(width: 35),
                                            pw.Text(
                                                '${income - expanse + savings}',
                                                style: pw.TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    letterSpacing: 1)),
                                          ]),
                                          pw.SizedBox(
                                            height: 10,
                                          ),
                                          pw.Container(
                                              height: 2,
                                              width: 440,
                                              color: PdfColors.black),
                                        ]),
                                      ]),
                                      pw.SizedBox(
                                        height: 55,
                                      ),
                                      pw.Row(children: [
                                        pw.SizedBox(
                                          width: 20,
                                        ),
                                        pw.Container(
                                          child: pw.ConstrainedBox(
                                            constraints:
                                                const pw.BoxConstraints(
                                              maxWidth: 450,
                                            ),
                                            child: pw.Text(
                                              "          ${user.username} balances income and spending, emphasizing savings for goals. Regular budget reviews ensure financial resilience.",
                                              style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 18,
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                      pw.SizedBox(
                                        height: 30,
                                      ),
                                      pw.Row(children: [
                                        pw.SizedBox(
                                          width: 110,
                                        ),
                                        pw.Text(' Spend Smart, View Success!',
                                            style: pw.TextStyle(
                                              color: PdfColors.black,
                                              fontSize: 18,
                                              fontWeight: pw.FontWeight.bold,
                                            )),
                                      ])
                                    ]),
                              ),
                            ]),
                          ]),
                        ];
                      }),
                );
                await Printing.layoutPdf(
                  onLayout: (format) => pdf.save(),
                );
                final output = await getTemporaryDirectory();
                final file = File("${output.path}/Spandview-Report.pdf");
                await file.writeAsBytes(await pdf.save());
              },
              onTilePressed: () async {
                UserController user =
                    Provider.of<UserController>(context, listen: false);
                String date =
                    '${DateFormat('dd/MM/yyyy').format(DateTime.now())}';

                String time =
                    '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                final logoImage = pw.MemoryImage(
                  (await rootBundle.load("assets/images/ic_launcher.png"))
                      .buffer
                      .asUint8List(),
                );
                final image = pw.MemoryImage(
                  (user.image ?? Uint8List(0)),
                );

                pdf.addPage(
                  pw.MultiPage(
                      margin: const pw.EdgeInsets.all(10),
                      pageFormat: PdfPageFormat.a4,
                      build: (pw.Context context) {
                        return <pw.Widget>[
                          pw.Column(children: [
                            pw.Row(children: [
                              pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Container(
                                      color: PdfColors.black,
                                      width: 100,
                                      height: 50,
                                      child: pw.Column(),
                                    ),
                                    pw.Text("Spandview",
                                        style: pw.TextStyle(
                                            color: PdfColors.black,
                                            fontSize: 19,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Container(
                                      color: PdfColors.black,
                                      width: 100,
                                      height: 713,
                                      child: pw.Column(),
                                    ),
                                  ]),
                              pw.Container(
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Row(children: [
                                        pw.SizedBox(width: 20),
                                        pw.Row(children: [
                                          pw.Text('Time : ',
                                              style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text(time,
                                              style: pw.TextStyle(
                                                  color: PdfColors.grey,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        ]),
                                        pw.SizedBox(width: 60),
                                        pw.Text('Spandview',
                                            style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 18,
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(width: 50),
                                        pw.Row(children: [
                                          pw.Text('Date : ',
                                              style: pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.Text(date,
                                              style: pw.TextStyle(
                                                  color: PdfColors.grey,
                                                  fontSize: 18,
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                        ])
                                      ]),
                                      pw.SizedBox(height: 40),
                                      pw.Row(children: [
                                        pw.SizedBox(width: 20),
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text('Spant',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 36,
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      letterSpacing: 2)),
                                              pw.Text('Report',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 60,
                                                      fontWeight:
                                                          pw.FontWeight.normal,
                                                      letterSpacing: 2)),
                                            ]),
                                        pw.SizedBox(width: 140),
                                        pw.Image(
                                          logoImage,
                                          height: 100,
                                        ),
                                      ]),
                                      pw.SizedBox(height: 30),
                                      pw.Row(children: [
                                        pw.SizedBox(width: 30),
                                        pw.Container(
                                          child: pw.ClipOval(
                                            child: pw.Image(image,
                                                height: 300, width: 160),
                                          ),
                                        ),
                                        pw.SizedBox(width: 20),
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(user.username ?? '',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.black,
                                                      fontSize: 36,
                                                      fontWeight:
                                                          pw.FontWeight.bold)),
                                              pw.SizedBox(height: 15),
                                              pw.Text('tushalgopani3@gmail.com',
                                                  style: pw.TextStyle(
                                                      color: PdfColors.grey,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          pw.FontWeight.bold)),
                                              pw.SizedBox(height: 10),
                                              pw.Row(children: [
                                                pw.Text('Current Balance : ',
                                                    style: pw.TextStyle(
                                                        color: PdfColors.black,
                                                        fontSize: 18,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                                pw.Text(
                                                    '${(user.total ?? 25000) - expanse + income}',
                                                    style: pw.TextStyle(
                                                        color: PdfColors.grey,
                                                        fontSize: 20,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                            ])
                                      ]),
                                      pw.SizedBox(height: 70),
                                      pw.Row(children: [
                                        pw.SizedBox(width: 20),
                                        pw.Column(children: [
                                          pw.Container(
                                              height: 2,
                                              width: 440,
                                              color: PdfColors.black),
                                          pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.Column(children: [
                                                  pw.Text('NO',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('1',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('2',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('3',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                ]),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.SizedBox(width: 50),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.Column(children: [
                                                  pw.Text('Type',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('Income',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.green,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('Expanace',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.red,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('Savings',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.blue,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                ]),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.SizedBox(width: 50),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                                pw.Column(children: [
                                                  pw.Text('Amount',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.black,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('$income',
                                                      style: pw.TextStyle(
                                                          color:
                                                              PdfColors.green,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.SizedBox(height: 05),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('$expanse',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.red,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                  pw.Container(
                                                      height: 1,
                                                      width: 110,
                                                      color: PdfColors.black),
                                                  pw.SizedBox(height: 05),
                                                  pw.Text('$savings',
                                                      style: pw.TextStyle(
                                                          color: PdfColors.blue,
                                                          fontSize: 18,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)),
                                                ]),
                                                pw.Container(
                                                    height: 120,
                                                    width: 2,
                                                    color: PdfColors.black),
                                              ]),
                                          pw.Container(
                                              height: 2,
                                              width: 440,
                                              color: PdfColors.black),
                                          pw.SizedBox(
                                            height: 10,
                                          ),
                                          pw.Row(children: [
                                            pw.SizedBox(
                                              width: 120,
                                            ),
                                            pw.Text('Total Amount :',
                                                style: const pw.TextStyle(
                                                  color: PdfColors.black,
                                                  fontSize: 18,
                                                  letterSpacing: 2,
                                                )),
                                            pw.SizedBox(width: 35),
                                            pw.Text(
                                                '${income - expanse + savings}',
                                                style: pw.TextStyle(
                                                    color: PdfColors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                    letterSpacing: 1)),
                                          ]),
                                          pw.SizedBox(
                                            height: 10,
                                          ),
                                          pw.Container(
                                              height: 2,
                                              width: 440,
                                              color: PdfColors.black),
                                        ]),
                                      ]),
                                      pw.SizedBox(
                                        height: 55,
                                      ),
                                      pw.Row(children: [
                                        pw.SizedBox(
                                          width: 20,
                                        ),
                                        pw.Container(
                                          child: pw.ConstrainedBox(
                                            constraints:
                                                const pw.BoxConstraints(
                                              maxWidth: 450,
                                            ),
                                            child: pw.Text(
                                              "          ${user.username} balances income and spending, emphasizing savings for goals. Regular budget reviews ensure financial resilience.",
                                              style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 18,
                                                fontWeight:
                                                    pw.FontWeight.normal,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                      pw.SizedBox(
                                        height: 30,
                                      ),
                                      pw.Row(children: [
                                        pw.SizedBox(
                                          width: 110,
                                        ),
                                        pw.Text(' Spend Smart, View Success!',
                                            style: pw.TextStyle(
                                              color: PdfColors.black,
                                              fontSize: 18,
                                              fontWeight: pw.FontWeight.bold,
                                            )),
                                      ])
                                    ]),
                              ),
                            ]),
                          ]),
                        ];
                      }),
                );
                await Printing.layoutPdf(
                  onLayout: (format) => pdf.save(),
                );
                final output = await getTemporaryDirectory();
                final file = File("${output.path}/Spandview-Report.pdf");
                await file.writeAsBytes(await pdf.save());
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        headerAnimationLoop: false,
                        animType: AnimType.scale,
                        title: 'Warning',
                        desc:
                        'Are you sure you want to log out ?',
                        btnCancelOnPress: () async {
                          print(Provider.of<UserController>(context, listen: false).username);
                        },
                        btnOkOnPress: () async {
                          Provider.of<UserController>(context, listen: false).logoutUser();
                          await Provider.of<LoginScreenController>(context,listen: false).islogout();
                          await DbHelper.dbHelper.initDB();
                          Navigator.of(context).pushReplacement(
                              PageTransition(
                                type: PageTransitionType.size,
                                duration: const Duration(seconds: 1),
                                alignment: Alignment.bottomCenter,
                                child: LoginPage(),
                              ));
                        },
                      ).show()
                      ;
                    },
                    child: Text(
                      'Log out'.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  "Spandview v1.0.0",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
