import 'package:flutter/material.dart';

class SavGoalTile extends StatelessWidget {
  final String? savingName;
  final String? savingdate;
  final double? amount;


  SavGoalTile({
    required this.savingName,
    required this.savingdate,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(8),
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          offset: Offset(2, 1),
          color: Colors.grey.shade100,
        ),BoxShadow(
          offset: Offset(-2, -1),
          color: Colors.grey.shade100,
        ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 20),
            child: Container(
              height: size.height * 0.06,child: Image.asset(
                'assets/images/AppIcon.png',fit: BoxFit.fitWidth,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 1),
                    color: Colors.grey.shade100,
                  ),BoxShadow(
                    offset: Offset(-2, -1),
                    color: Colors.grey.shade100,
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  savingName ?? '',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),
                ),
                Text(
                 savingdate ?? '',
                  style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.arrow_drop_up_rounded,color: Colors.greenAccent,),
                  Text(
                    '${amount}' ?? '',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.greenAccent),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
