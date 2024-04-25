import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
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
      body: Obx(() {
        return jobController.jobs.isNotEmpty && !jobController.isLoading
            ? Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                color: PlacedColors.PrimaryWhiteDark,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 76, 0, 24),
                        child: Text(
                          'Job Applicants',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) => JobDetails(
                                                    jobPost: jobController
                                                        .jobs[index],
                                                  )));
                                    },
                                    child: Container(
                                      height: 63,
                                      child: Card(
                                        surfaceTintColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: PlacedColors
                                                  .PrimaryBlueLight1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: FutureBuilder(
                                                future: Utils.loadImage(
                                                    jobController
                                                        .jobs[index].logoUrl),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    // Placeholder widget while loading
                                                    return Container(
                                                        height: 16,
                                                        width: 16,
                                                        child:
                                                            const LinearProgressIndicator());
                                                  } else if (snapshot
                                                      .hasError) {
                                                    // Error handling
                                                    return const Icon(
                                                        Icons.error);
                                                  } else {
                                                    // Image loaded successfully
                                                    return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: PlacedColors
                                                              .PrimaryBlueLight1,
                                                        ),
                                                        height: 32,
                                                        width: 32,
                                                        child: Image.network(
                                                            jobController
                                                                .jobs[index]
                                                                .logoUrl));
                                                  }
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  jobController
                                                      .jobs[index].companyName,
                                                  style: GoogleFonts.poppins(
                                                      color: PlacedColors
                                                          .PrimaryBlack,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  jobController.jobs[index]
                                                      .positionOffered,
                                                  style: GoogleFonts.poppins(
                                                      color: PlacedColors
                                                          .PrimaryGrey2,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Expanded(
                                              child: Text(
                                                jobController
                                                    .jobs[index].jobType,
                                                style: GoogleFonts.poppins(
                                                    color: PlacedColors
                                                        .PrimaryGrey2,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Expanded(
                                                child: PopupMenuButton(
                                              itemBuilder:
                                                  (BuildContext context) => [
                                                const PopupMenuItem(
                                                    value: "edit",
                                                    child: Text(
                                                        "View / Edit job Drive")),
                                                const PopupMenuItem(
                                                    value: "delete",
                                                    child: Text(
                                                      "Delete Drive",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ))
                                              ],
                                              elevation: 2,
                                              onSelected: (value) {
                                                if (value == 'edit') {
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) {
                                                        return JobDetailsDialog(
                                                            jobPost:
                                                                jobController
                                                                        .jobs[
                                                                    index]);
                                                      });
                                                } else if (value == "delete") {
                                                  showDialog(
                                                      context: context,
                                                      builder: (ctx) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            'Delete Drive?',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          content: const Text(
                                                              'Deleting the drive deletes all the associated data. This action cannot be undone.'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'No, Cancel')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  jobController.delJob(
                                                                      jobController
                                                                              .jobs[
                                                                          index]);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Yes, Delete',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ))
                                                          ],
                                                        );
                                                      });
                                                }
                                              },
                                            )),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                              separatorBuilder: (ctx, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: jobController.jobs.length)),
                    ],
                  ),
                ),
              )
            : !jobController.isLoading && jobController.jobs.isEmpty
                ? Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    color: PlacedColors.PrimaryWhiteDark,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 76, 0, 24),
                        child: Text(
                          'Job Applicants',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      )
                    ]))
                : !jobController.isLoading && jobController.jobs.isEmpty
                    ? const Center(
                        child: Text(
                          'No jobs created yet!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
