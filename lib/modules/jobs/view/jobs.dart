import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/modules/job_details/view/job_details_page.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';

class Jobs extends StatelessWidget {
  Jobs({super.key});

  JobController jobController = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applicants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
        body: Obx(() {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => JobDetails(jobPost: jobController.jobs[index],)));
                  },
                  child: Card(
                    surfaceTintColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(jobController.jobs[index].companyName),
                        Text(jobController.jobs[index].positionOffered),
                        Text(jobController.jobs[index].jobType),
                        TextButton(onPressed: () {

                        }, child: Text('View job details', style: TextStyle(decoration: TextDecoration.underline),))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(height: 10,);
              },
              itemCount: jobController.jobs.length
          );
        }),
    );
  }
}
