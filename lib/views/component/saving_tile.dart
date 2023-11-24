import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controller/savings_controller.dart';

class SavingTile extends StatelessWidget {

  final String? savingName;
  final double? progressAmount;
  final double? goalAmount;
  final Uint8List? image;


  SavingTile({
    required this.savingName,
    required this.progressAmount,
    required this.goalAmount,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
          )
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(width: size.width,height: size.height * 0.15,
              child: Image.memory(image ?? Provider.of<SavingsController>(context).imageBytes?? Uint8List(0),fit: BoxFit.fill,),
            ),
          ),
          Text(savingName??''),
          Text('₹ ${progressAmount}',style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w600,  letterSpacing: 1, color: Colors.black
          )),
          Text('/₹ ${goalAmount}',style: TextStyle(color: Colors.grey,fontSize: 14,letterSpacing: 1,fontWeight: FontWeight.bold),),
          SliderTheme(
            data: SliderThemeData(

              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0,disabledThumbRadius: 0),
            ),
            child: Slider(value: progressAmount??0.0,
              onChanged: (val){},
              min: 0,
              max: goalAmount??0.0,
              activeColor: Colors.indigoAccent,
              inactiveColor: Colors.grey.shade200,
              onChangeEnd: (val){
              log("${val}  Completed......................");
              },
            ),
          ),
        ],
      ),
    );
  }
}
