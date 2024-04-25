import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/model/filter_model/filter_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/home_module/view/home.dart';
import 'package:placed_web/modules/post_a_job_module/controller/post_job_controller.dart';
import 'package:intl/intl.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/utils/utils.dart';
import 'package:placed_web/widgets/filter_dialogue/filter_dialog.dart';

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

  Filter filter = Filter();

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
        backgroundColor: PlacedColors.backgroundWhite,
        body: Container(
            padding: EdgeInsets.fromLTRB(24, 0, 12, 24),
            color: PlacedColors.PrimaryWhiteDark,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView(
                  padding: const EdgeInsets.only(left: 20),
                  shrinkWrap: true,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      Container(
                        // margin: EdgeInsets.fromLTRB(24, 76, 0, 24),
                        child: Text(
                          PlacedStrings.postAJob,
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: PlacedColors.PrimaryBlack),
                        ),
                      ),
                      const SizedBox(height: 50,),
                      Container(
                          height: 330,
                          // width: MediaQuery.of(context).size.width * 0.8,
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 30, horizontal: 100),
                          child: Form(
                              key: formKey,
                              child: ListView(
                                padding: const EdgeInsets.only(left: 20),
                                children: [
                                Text(PlacedStrings.companyLogo,
                                style: GoogleFonts.poppins(fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: PlacedColors.PrimaryGrey1),),
                              const SizedBox(height: 20,),
                              DottedBorder(
                                radius: Radius.circular(8),
                                color: PlacedColors.PrimaryGrey4,
                                dashPattern: [10, 10],
                                child: Container(
                                    height: 200,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.7,
                                    child: Obx(() =>
                                    controller.bytes.value.isEmpty ? Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          OutlinedButton(onPressed: () {
                                            controller.uploadPhoto();
                                          },
                                              child: Text(
                                                PlacedStrings.uploadLogo,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: PlacedColors
                                                        .PrimaryGrey2
                                                ),)),
                                          const SizedBox(height: 10,),
                                          Text(
                                            'PNG, JPG and JPEG are supported',
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: PlacedColors.PrimaryGrey3
                                            ),),
                                        ],),
                                    ) : Center(child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                      Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Image.memory(
                                        controller.bytes.value, scale: 10,),
                                    ),
                                        const SizedBox(height: 10,),
                                        TextButton(onPressed: () {
                                          controller.bytes.value = Uint8List(0);
                                        },
                                            child: Text('Clear',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  decoration: TextDecoration
                                                      .underline),)),]))
                                    )))
                                ],
                              )
                          )
                      ),
                      // const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Text(PlacedStrings.companyName, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(PlacedStrings.jobTitle, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
                          ),
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
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
                                    hintText: 'Eg. TATA Consultancy Services',
                                    hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
                                    hintText: 'Eg. Junior Software Engineer',
                                    hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                          Expanded(
                            child: Text(PlacedStrings.jobType, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(PlacedStrings.jobLocation, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
                          ),
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
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
                                    hintText: 'Eg. Full time, Part time',
                                    hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3)
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
                                  hintText: 'Eg. Ahmedabad, Bangalore',
                                  hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: TextFormField(
                                controller: packageStartRange,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
                                  hintText: 'From',
                                  hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0),),
                                  hintText: 'To',
                                  hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
                                ),
                              )
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(PlacedStrings.lastDateToApply,
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
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
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'DD/MM/YYYY',
                              hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mention any other relevant job details here',
                                hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w800,color: PlacedColors.PrimaryGrey1),),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
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
                                  hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600,color: PlacedColors.PrimaryGrey3),
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
                              TextButton(
                                  onPressed: () {
                                    showDialog(context: context, builder: (ctx){
                                      return FilterDialog();
                                    });
                                  },
                                  child: Text(PlacedStrings.addEligibility,
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600, color: PlacedColors.PrimaryBlueMain),)),
                              SizedBox(width: 24),
                              InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate() && controller.bytes.value.isNotEmpty && controller.selectedFile.value.size != 0) {
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
                                    controller.createJobPost(filter).then((value) {
                                      if(value.success){
                                        showDialog(context: context, builder: (ctx) {
                                          return AlertDialog(
                                            surfaceTintColor: Colors.white,
                                            title: Text('Creating job post for ${companyName.text}'),
                                            content: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                CircularProgressIndicator()
                                              ],
                                            ),
                                          );
                                        });
                                        Future.delayed(Duration(seconds: 3), () {
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => Home()), (route) => false);
                                        });
                                      }
                                      else if(!value.success){
                                        showDialog(context: context, builder: (ctx) {
                                          return AlertDialog(
                                              surfaceTintColor: Colors.white,
                                              title: Text('An error occurred!'),
                                              content: Text(value.error.toString())
                                          );
                                        });
                                      }
                                    });
                                  }
                                  else if(controller.bytes.value.isEmpty && controller.selectedFile.value.size == 0) {
                                    showDialog(context: context, builder: (ctx){
                                      return AlertDialog(
                                        surfaceTintColor: Colors.white,
                                        title: Text('Upload Error'),
                                        content: Text('No file or photo selected!'),
                                      );
                                    });
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        colors: PlacedColors.gradiantColor),
                                  ),
                                  child: Center(child: Text(PlacedStrings.post,
                                    style: GoogleFonts.lato(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w600),),),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ]
                )
            )
        )
    );
  }
}
