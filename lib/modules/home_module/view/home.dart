import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/modules/import_a_sheet/view/import_sheet.dart';
import 'package:placed_web/modules/jobs/view/jobs.dart';
import 'package:placed_web/modules/overview/view/overview.dart';
import 'package:placed_web/modules/post_a_job_module/view/post_a_job.dart';
import 'package:placed_web/modules/students/view/students.dart';
import 'package:placed_web/modules/students/view/students_page.dart';
import 'package:placed_web/widgets/custom_row.dart';

import '../../../constants/app-ui/placed_dimens.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 2;

  List<String> pages = [
    'Overview',
    'Students',
    'Job Applicants',
    'Post a Job',
    'Import Sheet'
  ];

  void updateWidget(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget returnPage(int index) {
    if (index == 0) {
      return Overview();
    } else if (index == 1) {
      return StudentsPage();
    } else if (index == 2) {
      return Jobs();
    } else if (index == 3) {
      return PostJob();
    } else if (index == 3) {
      return Overview();
    }
    return Overview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: 237,
            color: PlacedColors.PrimaryBlueMain,
            child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 32, 37, 30),
                        child: ListTile(
                          leading: Container(
                            width: 24,
                            height: 24,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/b/b8/New-LOGO-IU4.png'),
                            ),
                          ),
                          title: Text(
                            PlacedStrings.indusUniversity,
                            style: GoogleFonts.lato(
                                color: PlacedColors.PrimaryWhite,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          updateWidget(0);
                        },
                        child: CustomRow(
                          leadingImage: 'assets/Insert_Left.svg',
                          title: PlacedStrings.overview,
                          color: selectedIndex == 0
                              ? PlacedColors.PrimaryWhite.withOpacity(0.20)
                              : PlacedColors.PrimaryWhite.withOpacity(0.0),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'DATABASE',
                        style: GoogleFonts.lato(
                            color: const Color(0xffe9e9e9),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: (){
                          updateWidget(1);
                        },
                        child: CustomRow(
                          leadingImage: 'assets/Graduation_Cap.svg',
                          title: PlacedStrings.students,
                          color: selectedIndex == 1
                              ? PlacedColors.PrimaryWhite.withOpacity(0.20)
                              : PlacedColors.PrimaryWhite.withOpacity(0.0),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          updateWidget(2);
                        },
                        child: CustomRow(
                          leadingImage: 'assets/Office_Building.svg',
                          title: PlacedStrings.Drives,
                          color: selectedIndex == 2
                              ? PlacedColors.PrimaryWhite.withOpacity(0.20)
                              : PlacedColors.PrimaryWhite.withOpacity(0.0),
                        ),
                      ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'TASKS',
                    style: GoogleFonts.lato(
                        color: const Color(0xffe9e9e9),
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: (){
                          updateWidget(3);
                        },
                        child: CustomRow(
                          leadingImage: 'assets/Office_Worker.svg',
                          title: PlacedStrings.postAJob,
                          color: selectedIndex == 3
                              ? PlacedColors.PrimaryWhite.withOpacity(0.20)
                              : PlacedColors.PrimaryWhite.withOpacity(0.0),
                        ),
                      ),
                      // InkWell(
                      //   onTap: (){
                      //     updateWidget(4);
                      //   },
                      //   child: CustomRow(
                      //     leadingImage: 'assets/Overview.svg',
                      //     title: PlacedStrings.importSheet,
                      //     color: selectedIndex == 4
                      //         ? PlacedColors.PrimaryWhite.withOpacity(0.20)
                      //         : PlacedColors.PrimaryWhite.withOpacity(0.0),
                      //   ),
                      // ),
            ]),
          ),
          Expanded(child: returnPage(selectedIndex))
        ],
      ),
    );
  }
}
