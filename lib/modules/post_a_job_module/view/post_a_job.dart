import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/post_a_job_module/controller/post_job_controller.dart';
import 'package:intl/intl.dart';
import 'package:placed_web/utils/utils.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key});

  @override
  State<PostJob> createState() => _PostJobState();
}

class _PostJobState extends State<PostJob> {

  final formKey = GlobalKey<FormState>();

  PostJobController controller = Get.find<PostJobController>();

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(PlacedStrings.postAJob,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              const Text(PlacedStrings.companyLogo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Container(
                height: 200,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7,
                decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(onPressed: () {
                      controller.uploadPhoto();
                    },
                        child: const Text(PlacedStrings.uploadLogo)),
                    const SizedBox(height: 10,),
                    Obx(() =>
                    controller.selectedPhoto.value!.name.isNotEmpty ? Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Image.network(
                        controller.selectedPhoto.value!.path, scale: 10,),
                    ) : Container()),
                    const Text('PNG, JPG and JPEG are supported'),
                  ],),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(PlacedStrings.companyName, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),),
                  Expanded(child: Container()),
                  Text(PlacedStrings.jobTitle, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        controller: companyName,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Eg. TATA Consultancy Services'
                        ),
                        validator: (String? name) {
                          if (name == null || name.isEmpty) {
                            return 'Cannot have an empty company name';
                          }
                          return null;
                        },
                      )
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: TextFormField(
                        controller: jobTitle,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Eg. Junior Software Engineer'
                        ),
                        validator: (String? job) {
                          if (job == null || job.isEmpty) {
                            return 'Cannot have an empty Job Title';
                          }
                          return null;
                        },
                      )
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(PlacedStrings.jobType, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),),
                  Expanded(child: Container()),
                  Text(PlacedStrings.jobLocation, style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        controller: jobType,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Eg. Full time, Part time'
                        ),
                        validator: (String? name) {
                          if (name == null || name.isEmpty) {
                            return 'Cannot have an empty company name';
                          }
                          return null;
                        },
                      )
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                      child: TextFormField(
                        controller: jobLocation,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Eg. Ahmedabad, Bangalore'
                        ),
                        validator: (String? job) {
                          if (job == null || job.isEmpty) {
                            return 'Cannot have an empty Job Title';
                          }
                          return null;
                        },
                      )
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text(PlacedStrings.packageRange,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        controller: packageStartRange,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'From'
                        ),
                        validator: (String? name) {
                          if (name == null || name.isEmpty) {
                            return 'Cannot have an empty package range';
                          }
                          return null;
                        },
                      )
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                      child: TextFormField(
                        controller: packageEndRange,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'To'
                        ),
                      )
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Text(PlacedStrings.lastDateToApply,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () async{
                  var currentDate = DateTime.now();
                  controller.selectedDate.value = (await showDatePicker(context: context,
                      firstDate: DateTime.now(),
                      lastDate: currentDate.add(Duration(days: 10 * 365))))!;
                  setState(() {
                    lastDateToApply = TextEditingController(text: controller.selectedDate.string.substring(0,10));
                  });
                },
                child: Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: lastDateToApply,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'DD/MM/YYYY'
                    ),
                    validator: (String? job) {
                      if (job == null || job.isEmpty) {
                        return 'Cannot have an empty date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Text(PlacedStrings.additionalDescription,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 10),
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      maxLines: null,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mention any other relevant job details here'
                      ),
                      validator: (String? job) {
                        if (job == null || job.isEmpty) {
                          return 'Cannot have an empty description';
                        }
                        return null;
                      },
                    ),
                  )
              ),
              const SizedBox(height: 20,),
              Text(PlacedStrings.uploadDocs,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  controller.uploadDocuments();
                  uploadDocs = TextEditingController(
                      text: controller.selectedFile.value.path);
                },
                child: Expanded(
                    child: Obx(() {
                      return TextFormField(
                        readOnly: true,
                        enabled: false,
                        controller: uploadDocs,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: controller.selectedFile.value.name.isEmpty
                              ? 'Select Documents (PDF, JPG, PNG supported)'
                              : '${controller.selectedFile.value
                              .name} file selected',
                        ),
                      );
                    })
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TextButton(onPressed: () {},
                          child: Text(PlacedStrings.addEligibility,
                            style: TextStyle(fontSize: 16, color: Colors
                                .blue),)),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            controller.companyName.value = companyName.text;
                            controller.jobTitle.value = jobTitle.text;
                            controller.jobType.value = jobType.text;
                            controller.jobLocation.value = jobLocation.text;
                            controller.endDate.value = lastDateToApply.text;
                            controller.packageEndRange.value = packageEndRange
                                .text;
                            controller.packageStarterRange.value =
                                packageStartRange.text;
                            controller.desc.value = descriptionController.text;
                            controller.createJobPost();
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: Center(child: Text(PlacedStrings.post,
                            style: TextStyle(color: Colors.white),),),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


