import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/home_module/view/home.dart';
import 'package:placed_web/modules/jobs/controller/job_controller.dart';
import 'package:placed_web/utils/utils.dart';

class JobDetailsDialog extends StatefulWidget {
  JobPost jobPost;

  JobDetailsDialog({required this.jobPost, super.key});

  @override
  State<JobDetailsDialog> createState() => _JobDetailsDialogState();
}

class _JobDetailsDialogState extends State<JobDetailsDialog> {

  final formKey = GlobalKey<FormState>();
  JobController jobController = Get.find<JobController>();

  TextEditingController companyName = TextEditingController();
  TextEditingController jobLocation = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController jobType = TextEditingController();
  TextEditingController packageStartRange = TextEditingController();
  TextEditingController packageEndRange = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController lastDateToApply = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController uploadDocs = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyName = TextEditingController(text: widget.jobPost.companyName);
    jobLocation = TextEditingController(text: widget.jobPost.jobLocation);
    jobTitle = TextEditingController(text: widget.jobPost.positionOffered);
    jobType = TextEditingController(text: widget.jobPost.jobType);
    packageStartRange =
        TextEditingController(text: widget.jobPost.package.first.toString());
    packageEndRange = TextEditingController(
        text: widget.jobPost.package.last.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.jobPost.description);
    lastDateToApply =
        TextEditingController(text: widget.jobPost.endDate.substring(0, 10));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    companyName.dispose();
    jobLocation.dispose();
    jobTitle.dispose();
    packageStartRange.dispose();
    packageEndRange.dispose();
    descriptionController.dispose();
    jobType.dispose();
    lastDateToApply.dispose();
    uploadDocs.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.white,
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.7,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.3,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(AppwriteStorage.getDeptDocViewUrl(widget.jobPost.jobId)),
                  ),
                ),
                const SizedBox(height: 20,),
                Text('Job Title', style: TextStyle(fontSize: 16),),
                TextFormField(
                  controller: jobTitle,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot have empty job title!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Text('Company Name', style: TextStyle(fontSize: 16),),
                TextFormField(
                  controller: companyName,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot have empty company name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Text('Package Range (LPA)', style: TextStyle(fontSize: 16),),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: packageStartRange,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder()
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Cannot have empty package';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        controller: packageEndRange,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder()
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text('Job Type', style: TextStyle(fontSize: 16),),
                TextFormField(
                  controller: jobType,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot have empty job type!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Text('Job Location', style: TextStyle(fontSize: 16),),
                TextFormField(
                  controller: jobLocation,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot have empty job location!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                Text('Last date to Apply', style: TextStyle(fontSize: 16),),
                TextFormField(
                  controller: lastDateToApply,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder()
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot have empty last date to apply';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      JobPost jobPost = JobPost(
                          companyName: companyName.text,
                          jobId: widget.jobPost.jobId,
                          positionOffered: jobTitle.text,
                          package: [packageStartRange.text, packageEndRange.text ?? ''],
                          endDate: lastDateToApply.text,
                          jobType: jobType.text,
                          jobLocation: jobLocation.text,
                          filters: [],
                          logoUrl: AppwriteStorage.getDeptDocViewUrl(widget.jobPost.jobId),
                          pdfUrl: AppwriteStorage.getDeptDocViewUrl(Utils.reverseString(widget.jobPost.jobId))
                      );
                      AppWriteDb.updateJob(jobPost).then((value){
                        if(value.$createdAt.isNotEmpty){
                          jobController.jobs.remove(widget.jobPost);
                          jobController.jobs.add(jobPost);
                          showDialog(context: context, builder: (ctx){
                            return AlertDialog(
                              title: Text('${widget.jobPost.companyName} Updated Successfully!'),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: Text('Close'))
                              ],
                            );
                          });
                        }
                        else if(value.$createdAt.isEmpty){
                          return AlertDialog(
                            title: Text('An error occurred!'),
                            actions: [
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text('Close'))
                            ],
                          );
                        }
                        else{
                          return AlertDialog(
                            title: Text('Updating job post details!'),
                            actions: [
                              Center(child: CircularProgressIndicator(),)
                            ],
                          );
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    color: Colors.blue,
                    child: Center(
                        child: Text('Save', style: TextStyle(color: Colors
                            .white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
