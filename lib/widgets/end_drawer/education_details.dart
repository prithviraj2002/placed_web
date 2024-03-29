import 'package:flutter/material.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';

class EducationDetails extends StatelessWidget {
  Profile profile;
  EducationDetails({required this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        Text('Year of Engineering', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.year.toString(), style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Semester', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.sem.toString(), style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Year of Graduation', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.engYearOfPassing, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('10th Marks', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.XMarks.toString(), style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('10th Year of Passing', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.XPassingYear, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('10th board', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.board, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('12th Marks', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.XIIMarks.toString(), style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('12th Year of Passing', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.XIIPassingYear.toString(), style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('12th board', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(profile.board, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
      ],
    );
  }
}