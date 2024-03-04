import 'dart:html';

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
          return jobController.jobs.isNotEmpty ?
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => JobDetails(jobPost: jobController.jobs[index],)));
                        },
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)
                          ),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(jobController.jobs[index].companyName),
                                ),
                                Expanded(
                                  child: Text(jobController.jobs[index].positionOffered),
                                ),
                                Expanded(
                                  child: Text(jobController.jobs[index].jobType),
                                ),
                                Expanded(
                                  child: TextButton(onPressed: () {
                                  }, child: Text('View job details', style: TextStyle(decoration: TextDecoration.underline),),)
                                ),
                                Expanded(
                                  child: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index){
                      return const SizedBox(height: 10,);
                    },
                    itemCount: jobController.jobs.length
                )
              )
             : Center(child: Text('No jobs created yet!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),);
        }),
    );
  }
}
