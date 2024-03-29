import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app-ui/placed_colors.dart';
import '../constants/app-ui/placed_dimens.dart';
import '../constants/app-ui/placed_strings.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.leadingImage, required this.title, required this.color});

  final String leadingImage;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: 40,
      width: 221,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            leadingImage,
            color: PlacedColors.PrimaryWhite,
            height: PlacedDimens.icon_size,
            width: PlacedDimens.icon_size,
          ),
          SizedBox(width: 8,),
          Text(
            title,
            style: GoogleFonts.poppins(
                color: PlacedColors.PrimaryWhite,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
