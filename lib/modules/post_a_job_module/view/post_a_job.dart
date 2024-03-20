import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/model/filter_model/filter_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/home_module/view/home.dart';
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

  Filter filter = Filter();
  List<String> filterOptions = [
    'Current Semester',
    'CGPA',
    'Branch',
    'Year of Graduation',
    'Active Backlogs',
    'Total Backlogs',
    'Percentage in 12th',
    'Diploma Percentage',
    'Percentage in 10th',
  ];
  List<String> conditions = [
    'Equal to',
    'Less than',
    'Greater than',
    'Less than or equal to',
    'Greater than or equal to',
    'Not equal to',
  ];
  Map<String, dynamic> filters = {};
  List<String> selectedFilters = [];
  List<TextEditingController> valueControllers = [];
  int selectedCondition = 0;
  int selectedOption = 0;
  int filterCount = 0;

  void increaseFilterCount() {
    if (filterCount < filterOptions.length) {
      setState(() {
        filterCount += 1;
      });
    }
  }

  void initializeControllers() {
    for (int i = 0; i < filterOptions.length; i++) {
      valueControllers.add(TextEditingController());
    }
  }

  List<String> availableOptions() {
    List<String> options = List.from(filterOptions);
    for (String selected in selectedFilters) {
      options.remove(selected);
    }
    return options;
  }

  void addFilter(String selectedOption) {
    setState(() {
      selectedFilters.add(selectedOption);
    });
  }

  void removeFilter(String selectedOption) {
    setState(() {
      selectedFilters.remove(selectedOption);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeControllers();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          PlacedStrings.postAJob,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 100),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                PlacedStrings.companyLogo,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                      border: Border.all(style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10)),
                  child: Obx(
                    () => controller.bytes.value.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OutlinedButton(
                                    onPressed: () {
                                      controller.uploadPhoto();
                                    },
                                    child:
                                        const Text(PlacedStrings.uploadLogo)),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('PNG, JPG and JPEG are supported'),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Image.memory(
                                    controller.bytes.value,
                                    scale: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                    onPressed: () {
                                      controller.bytes.value = Uint8List(0);
                                    },
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                    ))
                              ],
                            ),
                          ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      PlacedStrings.companyName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      PlacedStrings.jobTitle,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    controller: companyName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Eg. TATA Consultancy Services'),
                    validator: (String? name) {
                      if (name == null || name.isEmpty) {
                        return 'Cannot have an empty company name';
                      }
                      return null;
                    },
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: jobTitle,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Eg. Junior Software Engineer'),
                    validator: (String? job) {
                      if (job == null || job.isEmpty) {
                        return 'Cannot have an empty Job Title';
                      }
                      return null;
                    },
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      PlacedStrings.jobType,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      PlacedStrings.jobLocation,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    controller: jobType,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Eg. Full time, Part time'),
                    validator: (String? name) {
                      if (name == null || name.isEmpty) {
                        return 'Cannot have an empty company name';
                      }
                      return null;
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: jobLocation,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Eg. Ahmedabad, Bangalore'),
                    validator: (String? job) {
                      if (job == null || job.isEmpty) {
                        return 'Cannot have an empty Job Title';
                      }
                      return null;
                    },
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                PlacedStrings.packageRange,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    controller: packageStartRange,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'From'),
                    validator: (String? name) {
                      if (name == null || name.isEmpty) {
                        return 'Cannot have an empty package range';
                      }
                      return null;
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    controller: packageEndRange,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'To'),
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                PlacedStrings.lastDateToApply,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  var currentDate = DateTime.now();
                  controller.selectedDate.value = (await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: currentDate.add(Duration(days: 10 * 365))))!;
                  setState(() {
                    lastDateToApply = TextEditingController(
                        text: controller.selectedDate.string.substring(0, 10));
                  });
                },
                child: Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: lastDateToApply,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'DD/MM/YYYY'),
                    validator: (String? job) {
                      if (job == null || job.isEmpty) {
                        return 'Cannot have an empty date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                PlacedStrings.additionalDescription,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
                      hintText: 'Mention any other relevant job details here'),
                  validator: (String? job) {
                    if (job == null || job.isEmpty) {
                      return 'Cannot have an empty description';
                    }
                    return null;
                  },
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              Text(
                PlacedStrings.uploadDocs,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  controller.uploadDocuments();
                  uploadDocs = TextEditingController(
                      text: controller.selectedFile.value.path);
                },
                child: Expanded(child: Obx(() {
                  return TextFormField(
                    readOnly: true,
                    enabled: false,
                    controller: uploadDocs,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: controller.selectedFile.value.name.isEmpty
                          ? 'Select Documents (PDF, JPG, PNG supported)'
                          : '${controller.selectedFile.value.name} file selected',
                    ),
                  );
                })),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: filterCount == 1 ? 170.0 : 170.0 * filterCount,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eligibility Criteria',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    'Criteria',
                                    style: TextStyle(fontSize: 16),
                                  )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Condition',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Value',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: DropdownButton(
                                        items: List.generate(
                                            availableOptions().length,
                                            (index) => DropdownMenuItem<String>(
                                                  child: Text(
                                                      availableOptions()[index]),
                                                  value: availableOptions()[index],
                                                )),
                                        onChanged: (String? selectedValue) {
                                          // Handle change in selected value
                                            setState(() {
                                              selectedOption = availableOptions().indexOf(selectedValue!);
                                            });
                                          },
                                        underline: Container(),
                                        hint: Text('Select Criteria'),
                                        icon: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Icon(Icons.keyboard_arrow_down_outlined)
                                          ],
                                        ),
                                          value: selectedOption >= 0 && selectedOption < availableOptions().length
                                              ? availableOptions()[selectedOption]
                                              : null,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      child: DropdownButton(
                                          items: List.generate(
                                              conditions.length,
                                              (index) =>
                                                  DropdownMenuItem<String>(
                                                    child:
                                                        Text(conditions[index]),
                                                    value: conditions[index],
                                                  )),
                                          onChanged: (String? selectedValue) {
                                            // Handle change in selected value
                                              setState(() {
                                                selectedCondition = conditions.indexOf(selectedValue!);
                                              });
                                            },
                                          hint: Text('Select Condition'),
                                          value: conditions[selectedCondition],
                                          underline: Container(),
                                          icon: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(Icons.keyboard_arrow_down_outlined)
                                            ],
                                          ),),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                    controller:
                                        valueControllers[filterCount],
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Value'),
                                  )),
                                ],
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: filterCount),
                    const SizedBox(height: 4,),
                    filterCount > 0
                        ? TextButton(
                            onPressed: () {
                              filters[availableOptions()[selectedOption]] = valueControllers[filterCount].text;
                              addFilter(availableOptions()[selectedOption]);
                              print('selected filters: ${filters.keys}');
                              print('selected filters: ${filters.values}');
                              increaseFilterCount();
                              setState((){
                                selectedOption = 0;
                              });
                            },
                            child: Text(
                              'Add another',
                              style: TextStyle(
                                  color: PlacedColors.PrimaryBlueDark,
                                  fontSize: 20),
                            ))
                        : Container()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      filterCount > 0
                          ? Container()
                          : TextButton(
                              onPressed: () {
                                increaseFilterCount();
                              },
                              child: Text(
                                PlacedStrings.addEligibility,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              )),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate() &&
                              controller.bytes.value.isNotEmpty &&
                              controller.selectedFile.value.size != 0) {
                            controller.companyName.value = companyName.text;
                            controller.jobTitle.value = jobTitle.text;
                            controller.jobType.value = jobType.text;
                            controller.jobLocation.value = jobLocation.text;
                            controller.endDate.value = lastDateToApply.text;
                            controller.packageEndRange.value =
                                packageEndRange.text;
                            controller.packageStarterRange.value =
                                packageStartRange.text;
                            controller.desc.value = descriptionController.text;
                            controller.createJobPost(filter).then((value) {
                              if (value.success) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        surfaceTintColor: Colors.white,
                                        title: Text(
                                            'Creating job post for ${companyName.text}'),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircularProgressIndicator()
                                          ],
                                        ),
                                      );
                                    });
                                Future.delayed(Duration(seconds: 3), () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => Home()),
                                      (route) => false);
                                });
                              } else if (!value.success) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                          surfaceTintColor: Colors.white,
                                          title: Text('An error occurred!'),
                                          content:
                                              Text(value.error.toString()));
                                    });
                              }
                            });
                          } else if (controller.bytes.value.isEmpty &&
                              controller.selectedFile.value.size == 0) {
                            showDialog(
                                context: context,
                                builder: (ctx) {
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
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              PlacedStrings.post,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
