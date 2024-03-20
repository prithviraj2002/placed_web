import 'package:flutter/material.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/modules/import_a_sheet/view/import_sheet.dart';
import 'package:placed_web/modules/jobs/view/jobs.dart';
import 'package:placed_web/modules/overview/view/overview.dart';
import 'package:placed_web/modules/post_a_job_module/view/post_a_job.dart';
import 'package:placed_web/modules/students/view/students.dart';
import 'package:placed_web/modules/students/view/students_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedIndex = 0;

  List<String> pages = [
    'Overview',
    'Students',
    'Job Applicants',
    'Post a Job',
  ];

  void updateWidget(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  
  Widget returnPage(int index){
    if(index == 0){
      return Overview();
    }
    else if(index == 1){
      return StudentsPage();
    }
    else if(index == 2){
      return Jobs();
    }
    else if(index == 3){
      return PostJob();
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: MediaQuery
                .of(context)
                .size
                .width * 0.2,
            color: PlacedColors.PrimaryBlueMain,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      PlacedStrings.indusUniversity,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      updateWidget(0);
                    },
                    title: Text(
                      PlacedStrings.overview,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      updateWidget(1);
                    },
                    title: Text(
                      PlacedStrings.students,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      updateWidget(2);
                    },
                    title: Text(
                      PlacedStrings.jobApplicants,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      updateWidget(3);
                    },
                    title: Text(
                      PlacedStrings.postAJob,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ]),
          ),
          Expanded(child: returnPage(selectedIndex))
        ],
      ),
    );
  }
}
