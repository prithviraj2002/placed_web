import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    width: 172,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0XFF2D64FA),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Students enrolled',
                          style: TextStyle(
                              color: PlacedColors.PrimaryWhite, fontSize: 20),
                        ),
                        Expanded(child: Obx(() {
                          return Text(
                            overviewController.profiles.length.toString(),
                            style: TextStyle(
                                color: PlacedColors.PrimaryWhite, fontSize: 32),
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
                    width: 222,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0XFF2D64FA),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Companies Onboarded',
                          style: TextStyle(
                              color: PlacedColors.PrimaryWhite, fontSize: 20),
                        ),
                        Expanded(child: Obx(() {
                          return Text(
                            overviewController.jobs.length.toString(),
                            style: TextStyle(
                                color: PlacedColors.PrimaryWhite, fontSize: 32),
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
                    width: 232,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0XFF2D64FA),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Highest Package Offered',
                          style: TextStyle(
                              color: PlacedColors.PrimaryWhite, fontSize: 18),
                        ),
                        Expanded(child: Obx(() {
                          return Text(
                            '${overviewController.highestPackageOffered.value.toString()} LPA',
                            style: TextStyle(
                                color: PlacedColors.PrimaryWhite, fontSize: 32),
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
                  Container(
                    height: 280,
                    width: 196,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Card(
                      surfaceTintColor: PlacedColors.PrimaryWhite,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Top Recruiter',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                  Container(
                    height: 280,
                    width: 388,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Card(
                      surfaceTintColor: PlacedColors.PrimaryWhite,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Students by Department',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
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
                                            height: 132,
                                            width: 132,
                                            child: PieChart(PieChartData(
                                              centerSpaceRadius:
                                              double.infinity,
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
                                              title: Text('CSE'),
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
                                              title: Text('CE'),
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
                                              title: Text('IT'),
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
                                              title: Text('Others'),
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
                  Container(
                    height: 280,
                    width: 388,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Card(
                      surfaceTintColor: PlacedColors.PrimaryWhite,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Positions Offered',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                              double.infinity,
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
                height: 434,
                width: 331,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                    color: PlacedColors.PrimaryWhite,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Students per job post',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 16,
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
                                        gridData: const FlGridData(show: true, drawHorizontalLine: true, drawVerticalLine: false),
                                        titlesData: FlTitlesData(
                                          rightTitles: AxisTitles(
                                              sideTitles:
                                              SideTitles(showTitles: false)),
                                          topTitles: AxisTitles(
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
                                          border: const Border(
                                              bottom: BorderSide(),
                                              left: BorderSide()),
                                        ),
                                        barGroups: List.generate(
                                            studentsPerJob.keys.length,
                                                (index) => BarChartGroupData(
                                                x: index,
                                                barRods: [
                                                  BarChartRodData(
                                                      toY: studentsPerJob.values
                                                          .toList()[index] *
                                                          1.0)
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