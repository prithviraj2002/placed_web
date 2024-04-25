import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/modules/overview/controller/overview_controller.dart';
import 'package:placed_web/utils/utils.dart';

class Overview extends StatefulWidget {
  Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  OverviewController overviewController = Get.find<OverviewController>();

  JobController jobController = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlacedColors.backgroundWhite,
      body: Container(
        padding: const EdgeInsets.only(top: 6, right: 6, left: 6),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Overview',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 92,
                    width: 178,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0XFF2D64FA),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Students enrolled',
                            style: GoogleFonts.poppins(
                                color: PlacedColors.PrimaryWhite, fontSize: 16),
                          ),
                        ),
                        Obx(() {
                          return Text(
                            overviewController.profiles.length.toString(),
                            style: GoogleFonts.poppins(
                                color: PlacedColors.PrimaryWhite, fontSize: 28, fontWeight: FontWeight.bold),
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 92,
                    width: 242,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0XFF2D64FA),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Companies Onboarded',
                            style: GoogleFonts.poppins(
                                color: PlacedColors.PrimaryWhite, fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(child: Obx(() {
                          return Text(
                            overviewController.jobs.length.toString(),
                            style: GoogleFonts.poppins(
                                color: PlacedColors.PrimaryWhite, fontSize: 28, fontWeight: FontWeight.bold),
                          );
                        }))
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 92,
                    width: 242,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0XFF2D64FA),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Highest Package Offered',
                            style: GoogleFonts.poppins(
                                color: PlacedColors.PrimaryWhite, fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(child: Obx(() {
                          return Text(
                            '${overviewController.highestPackageOffered.value.toString()} LPA',
                            style: GoogleFonts.poppins(
                                color: PlacedColors.PrimaryWhite, fontSize: 28, fontWeight: FontWeight.bold),
                          );
                        }))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Card(
                    margin: const EdgeInsets.only(left: 16),
                    surfaceTintColor: PlacedColors.PrimaryWhite,
                    child: Container(
                      height: 280,
                      width: 196,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 24,),
                          Text(
                            'Top Recruiter',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: Obx(() {
                              return FutureBuilder(
                                  future: Utils.loadImage(
                                      AppwriteStorage.getDeptDocViewUrl(
                                          jobController
                                              .topRecruiter.value.jobId)),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      String imageData = snapshot.data;
                                      return Image.network(
                                        imageData,
                                        height: 120,
                                        width: 120,
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Icon(Icons.error_outline));
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  });
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Card(
                    margin: const EdgeInsets.only(left: 16),
                    surfaceTintColor: PlacedColors.PrimaryWhite,
                    child: Container(
                      height: 280,
                      width: 388,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 24,),
                          Text(
                            'Students by Department',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 10,),
                          FutureBuilder(
                              future: overviewController
                                  .getDepartmentWiseProfiles(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, int> departmentWiseProfiles =
                                      snapshot.data;
                                  List<int> mapValues =
                                  departmentWiseProfiles.values.toList();
                                  List<String> mapKeys =
                                  departmentWiseProfiles.keys.toList();
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                            height: 122,
                                            width: 122,
                                            child: PieChart(
                                                PieChartData(
                                              centerSpaceRadius:
                                              30,
                                              sectionsSpace: 4,
                                              sections: [
                                                PieChartSectionData(
                                                  showTitle: false,
                                                  value: mapValues[1] * 1.0,
                                                  color: PlacedColors
                                                      .PieChartYellow,
                                                ),
                                                PieChartSectionData(
                                                  showTitle: false,
                                                  value: mapValues[0] * 1.0,
                                                  color:
                                                  PlacedColors.PieChartBlue,
                                                ),
                                                PieChartSectionData(
                                                  showTitle: false,
                                                  value: mapValues[2] * 1.0,
                                                  color: PlacedColors
                                                      .PieChartLightBlue,
                                                ),
                                                PieChartSectionData(
                                                  showTitle: false,
                                                  value: 2.0,
                                                  color: PlacedColors
                                                      .PieChartOrange,
                                                ),
                                              ],
                                            ))),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: ListView(
                                          padding: const EdgeInsets.all(0.0),
                                          shrinkWrap: true,
                                          children: [
                                            ListTile(
                                              leading: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: PlacedColors
                                                        .PieChartYellow,
                                                    shape: BoxShape.circle),
                                              ),
                                              title: const Text('CSE'),
                                            ),
                                            ListTile(
                                              leading: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: PlacedColors
                                                        .PieChartBlue,
                                                    shape: BoxShape.circle),
                                              ),
                                              title: const Text('CE'),
                                            ),
                                            ListTile(
                                              leading: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: PlacedColors
                                                        .PieChartLightBlue,
                                                    shape: BoxShape.circle),
                                              ),
                                              title: const Text('IT'),
                                            ),
                                            ListTile(
                                              leading: Container(
                                                height: 16,
                                                width: 16,
                                                decoration: BoxDecoration(
                                                    color: PlacedColors
                                                        .PieChartOrange,
                                                    shape: BoxShape.circle),
                                              ),
                                              title: const Text('Others'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Expanded(
                                    child: Center(
                                        child: Icon(Icons.error_outline)),
                                  );
                                } else {
                                  return const Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Card(
                    margin: const EdgeInsets.only(left: 16),
                    surfaceTintColor: PlacedColors.PrimaryWhite,
                    child: Container(
                      height: 280,
                      width: 358,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 24,),
                          Text(
                            'Positions Offered',
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          FutureBuilder(
                              future: overviewController.getJobRoles(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  final Map<String, int> jobRoles =
                                      snapshot.data;
                                  List<String> jobRoleKeys =
                                  jobRoles.keys.toList();
                                  List<int> jobRoleValues =
                                  jobRoles.values.toList();
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                          height: 132,
                                          width: 132,
                                          child: PieChart(PieChartData(
                                              centerSpaceRadius:
                                              30,
                                              sectionsSpace: 4,
                                              sections: List.generate(
                                                  jobRoleKeys.length,
                                                      (index) => PieChartSectionData(
                                                      showTitle: false,
                                                      value:
                                                      jobRoleValues[index] *
                                                          1.0,
                                                      color: PlacedColors
                                                          .pieChartColors[
                                                      index]))))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (ctx, index) {
                                              return ListTile(
                                                leading: Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                      color: PlacedColors
                                                          .pieChartColors[index],
                                                      shape: BoxShape.circle),
                                                ),
                                                title: Text(jobRoleKeys[index]),
                                              );
                                            },
                                            itemCount: jobRoleKeys.length,
                                          )),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return const Expanded(
                                      child: Center(
                                          child: Icon(Icons.error_outline)));
                                } else {
                                  return const Expanded(
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16),
                height: 334,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                    color: PlacedColors.PrimaryWhite,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Students per job post',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                        child: FutureBuilder(
                            future: overviewController.getStudentsPerJob(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                Map<String, int> studentsPerJob = snapshot.data;
                                return BarChart(
                                    BarChartData(
                                        gridData: const FlGridData(
                                            show: true, drawHorizontalLine: true,
                                            drawVerticalLine: false,
                                        ),
                                        titlesData: FlTitlesData(
                                          rightTitles: const AxisTitles(
                                              sideTitles:
                                              SideTitles(showTitles: false)),
                                          topTitles: const AxisTitles(
                                              sideTitles:
                                              SideTitles(showTitles: false)),
                                          bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  return Text(studentsPerJob.keys.toList()[int.parse(value.toString())]);
                                                },
                                              )),
                                        ),
                                        borderData: FlBorderData(
                                          border: Border(
                                              bottom: BorderSide(color: const Color(0xffc4c4c4).withOpacity(0.7)),
                                              ),
                                        ),
                                        barGroups: List.generate(
                                            studentsPerJob.keys.length,
                                                (index) => BarChartGroupData(
                                                x: index,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: studentsPerJob.values
                                                          .toList()[index] *
                                                          1,
                                                    width: 40,
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    color: PlacedColors.pieChartColors[index]
                                                  )
                                                ]))));
                              } else if (snapshot.hasError) {
                                return const Center(
                                    child: Icon(Icons.error_outline));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            }))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}