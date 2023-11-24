import 'package:flutter/material.dart';
import '../../modal/transaction_modal.dart';
import '../../utility/colors.dart';

class Tile extends StatelessWidget {
  final String? tital;
  final String? subtital;
  final String? image;
  final Color color;
  final Widget amount;
  final String? date;

  Tile({
    required this.tital,
    required this.subtital,
    required this.image,
    required this.color,
    required this.amount,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(8),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 9, right: 20),
            child: Container(
              padding: EdgeInsets.all(08),
              width: 50,
              height: 55,
              child: Image.asset(
                image ?? '',
              ),
              decoration: BoxDecoration(
                color: color.withOpacity(0.8) ?? primary,
                borderRadius: BorderRadius.circular(12),
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
                  tital ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  subtital ??'',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  amount,
                  Text(
                    date ?? '',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
