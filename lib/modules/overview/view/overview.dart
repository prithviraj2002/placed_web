import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/modules/overview/controller/overview_controller.dart';

class Overview extends StatelessWidget {
  Overview({super.key});

  OverviewController overviewController = Get.find<OverviewController>();
  JobController jobController = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50,),
            Text('Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 92,
                  width: 172,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                      color: Color(0XFF2D64FA),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Students enrolled', style: TextStyle(
                          color: PlacedColors.PrimaryWhite, fontSize: 20),),
                      Expanded(child: Obx(() {
                        return Text(overviewController.profiles.length.toString(), style: TextStyle(color: PlacedColors.PrimaryWhite, fontSize: 32),);
                      }))
                    ],
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  height: 92,
                  width: 222,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                      color: Color(0XFF2D64FA),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Companies Onboarded', style: TextStyle(
                          color: PlacedColors.PrimaryWhite, fontSize: 20),),
                      Expanded(child: Obx(() {
                        return Text(overviewController.jobs.length.toString(), style: TextStyle(color: PlacedColors.PrimaryWhite, fontSize: 32),);
                      }))
                    ],
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  height: 92,
                  width: 232,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                      color: Color(0XFF2D64FA),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Highest Package Offered', style: TextStyle(
                          color: PlacedColors.PrimaryWhite, fontSize: 18),),
                      Expanded(child: Obx(() {
                        return Text('${overviewController.highestPackageOffered.value.toString()} LPA', style: TextStyle(color: PlacedColors.PrimaryWhite, fontSize: 32),);
                      }))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Container(
                  height: 280,
                  width: 196,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Card(
                    surfaceTintColor: PlacedColors.PrimaryWhite,
                    child: Column(
                      children: <Widget>[
                        Text('Top Recruiter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Expanded(child: Obx(() {
                          return Image.network(AppwriteStorage.getDeptDocViewUrl(jobController.topRecruiter.value.jobId), height: 120, width: 120,);
                        }),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
