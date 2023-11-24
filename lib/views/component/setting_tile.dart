import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {

  final String? titel;
  final IconData icon;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onTilePressed;

  SettingTile({
    required this.titel,
    required this.icon,
    this.onButtonPressed,
    this.onTilePressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTilePressed,
      child: Row(
        children: [
          Icon(icon, size: 30),
          SizedBox(width: 18),
          Text(
            titel??'',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          IconButton(onPressed: onButtonPressed, icon: Icon(Icons.arrow_forward_ios_rounded))
        ],
      ),
    );
  }
}
