import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';

class CustomMessage extends StatelessWidget {
  String msgText;
  CustomMessage({required this.msgText, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: ClipPath(
        clipper: UpperNipMessageClipperTwo(
          MessageType.receive
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32,horizontal: 32),
          decoration: BoxDecoration(
            color: PlacedColors.PrimaryBlueLight1,
          ),
          child: Text(
            msgText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal
            ),
          ),
        ),
      ),
    );
  }
}
