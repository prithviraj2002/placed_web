import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_web/modules/job_details/view/job_details_page.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/ui/job_details_dialog/job_details_dialogue.dart';
import 'package:placed_web/utils/utils.dart';

class Jobs extends StatelessWidget {
  Jobs({super.key});

  JobController jobController = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.fromLTRB(24, 76, 0, 24),
          child: Text('Job Applicants', style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, fontSize: 24),),),
      ),
      body: Obx(() {
        return jobController.jobs.isNotEmpty && !jobController.isLoading
            ? Container(
                padding:
                    const EdgeInsets.fromLTRB(24, 76, 0, 24),
                child: ListView.separated(
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => JobDetails(
                                        jobPost: jobController.jobs[index],
                                      )));
                        },
                        child: Container(
                          height: 63,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12)),
                          child: Card(
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: FutureBuilder(
                                    future: Utils.loadImage(jobController.jobs[index].logoUrl),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        // Placeholder widget while loading
                                        return Container(
                                            height: 32, width: 32,
                                            child: LinearProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        // Error handling
                                        return Icon(Icons.error);
                                      } else {
                                        // Image loaded successfully
                                        return Container(
                                          height: 32, width: 32,
                                            child: Image.network(jobController.jobs[index].logoUrl, height: 32, width: 32));
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      jobController.jobs[index].companyName),
                                ),
                                Expanded(
                                  child: Text(jobController
                                      .jobs[index].positionOffered),
                                ),
                                Expanded(
                                  child:
                                      Text(jobController.jobs[index].jobType),
                                ),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return JobDetailsDialog(jobPost: jobController.jobs[index]);
                                        });
                                  },
                                  child: Text(
                                    'View/edit job details',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                )),
                                Expanded(
                                  child: Tooltip(
                                    message: 'Delete Drive',
                                    textStyle: TextStyle(color: Colors.red),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black12)
                                    ),
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(context: context, builder: (ctx){
                                            return AlertDialog(
                                              title: Text('Delete Drive?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                              content: Text('Deleting the drive deletes all the associated data. This action cannot be undone.'),
                                              actions: [
                                                TextButton(onPressed: () {
                                                  Navigator.pop(context);
                                                }, child: Text('No, Cancel')),
                                                TextButton(onPressed: () {
                                                  jobController.delJob(jobController.jobs[index]);
                                                  Navigator.pop(context);
                                                }, child: Text('Yes, Delete', style: TextStyle(color: Colors.red),))
                                              ],
                                            );
                                          });
                                        }, icon: Icon(Icons.more_vert)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: jobController.jobs.length))
            : !jobController.isLoading && jobController.jobs.isEmpty
                ? Center(
                    child: Text(
                      'No jobs created yet!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
