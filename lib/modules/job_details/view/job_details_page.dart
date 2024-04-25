import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_dimens.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';
import 'package:placed_web/ui/closed_FAB/closed_fab.dart';
import 'package:placed_web/ui/expanded_FAB/expanded_fab.dart';
import 'package:placed_web/widgets/custom_textformfield.dart';
import 'package:placed_web/widgets/end_drawer/end_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetails extends StatefulWidget {
  JobPost jobPost;

  JobDetails({required this.jobPost, super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  JobDetailController controller = Get.find<JobDetailController>();
  TextEditingController searchController = TextEditingController();
  final drawerKey = GlobalKey<ScaffoldState>();
  List<Profile> filteredData = [];
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfiles(widget.jobPost.jobId);
    controller.getAnnouncements(widget.jobPost.jobId);
    filteredData = controller.profiles;
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? controller.profiles
          : controller.profiles
          .where((profile) =>
      profile.name.toLowerCase().contains(text.toLowerCase()) ||
          profile.IU.toLowerCase().contains(text.toLowerCase()) || profile.email.toLowerCase().contains(text.toLowerCase()) || profile.phoneNumber.toString().toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: drawerKey,
        backgroundColor: PlacedColors.backgroundWhite,
        endDrawer: Obx(() {
          return StudentDrawer(profile: controller.selectedProfile.value);
        }),
        body: Obx(() {
          return controller.profiles.isNotEmpty
              ? Container(
            color: PlacedColors.PrimaryWhiteDark,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.arrow_back)),
                      const SizedBox(width: 12,),
                      Text(
                        widget.jobPost.companyName,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.fromLTRB(16,16,16,0),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: PlacedColors.PrimaryWhite,),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black12,
                              ),
                              child: Center(
                                child: CustomTextFieldForm(
                                  hintText: '🔍 Search table',
                                  textInputType: TextInputType.text
                                  ,
                                  ontap: _onSearchTextChanged,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.exportToExcel(widget.jobPost.companyName);
                              },
                              child: Container(
                                height: 40,
                                width: 130,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: PlacedColors.PrimaryBlueMain),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/Export.svg',
                                      color: PlacedColors.PrimaryBlueMain,
                                      height: PlacedDimens.icon_size,
                                      width: PlacedDimens.icon_size,
                                    ),
                                    SizedBox(width: 8,),
                                    Text(
                                      PlacedStrings.exportSheet,
                                      style: TextStyle(
                                          color: PlacedColors.PrimaryBlueMain),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(() {
                              return DataTable(
                                  border: TableBorder(horizontalInside: BorderSide(color: PlacedColors.PrimaryWhiteDark)),
                                  sortColumnIndex: 2,
                                  sortAscending: isAscending,
                                  dividerThickness: 0.00000000001,
                                  columns: [
                                    DataColumn(label: Text('SR.NO')),
                                    DataColumn(label: Text('Profile')),
                                    DataColumn(label: Text('Name'), onSort: sortName),
                                    DataColumn(label: Text('Email')),
                                    DataColumn(label: Text('Date of Birth')),
                                    DataColumn(label: Text('IU')),
                                    DataColumn(label: Text('Phone Number')),
                                    DataColumn(label: Text('Course')),
                                    DataColumn(label: Text('Degree')),
                                    DataColumn(label: Text('Year')),
                                    DataColumn(label: Text('Semester')),
                                    DataColumn(label: Text('Resume'))
                                  ],
                                  rows: List.generate(filteredData.length, (index) {
                                    final profile = filteredData[index];
                                    return DataRow(
                                        cells: [
                                          DataCell(Text('${index + 1}')),
                                          DataCell(
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey),
                                                    shape: BoxShape.circle
                                                ),
                                                child: CircleAvatar(
                                                  radius: 50, // Adjust the radius as needed
                                                  backgroundColor: Colors.transparent, // Make the background transparent
                                                  backgroundImage: NetworkImage(AppwriteStorage.getImageViewUrl(profile.id), scale: 10, ),
                                                ),
                                              )
                                          ),
                                          DataCell(TextButton(
                                            onPressed: () {
                                              if (!drawerKey.currentState!
                                                  .isEndDrawerOpen) {
                                                controller.selectedProfile.value =
                                                    profile;
                                                drawerKey.currentState!
                                                    .openEndDrawer();
                                              }
                                              else {
                                                drawerKey.currentState!
                                                    .closeEndDrawer();
                                              }
                                            },
                                            child: Text(profile.name, style: TextStyle(color: profile.status ? PlacedColors.PrimaryBlueMain : PlacedColors.SecondaryRed),),
                                          )),
                                          DataCell(Text(profile.email)),
                                          DataCell(Text(profile.dateOfBirth)),
                                          DataCell(Text(profile.IU)),
                                          DataCell(Text(profile.phoneNumber)),
                                          DataCell(Text(profile.course)),
                                          DataCell(Text(profile.degree)),
                                          DataCell(Text(profile.year.toString())),
                                          DataCell(Text(profile.sem.toString())),
                                          DataCell(
                                              TextButton(
                                                  onPressed: () {
                                                    final Uri _url = Uri.parse(AppwriteStorage.getResumeViewUrl(profile.id));
                                                    launchUrl(_url);
                                                  },
                                                  child: const Text('View resume')
                                              )
                                          )
                                        ]);
                                  })
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
              : controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : const Center(
            child: Text(
              'No Applications yet!',
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Obx(() {
          return Container(
            color: Colors.white,
            height: controller.isExpanded.value ? MediaQuery
                .of(context)
                .size
                .width * 0.3 : 50,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.25,
            child: controller.isExpanded.value
                ? ExpandedFAB(
                jobPost: widget.jobPost)
                : ClosedFAB(),
          );
        })
    );
  }

  void sortName(int columnIndex, bool ascending) {
    if(columnIndex == 2){
      filteredData.sort((profile1, profile2) => compareString(ascending, profile1.name, profile2.name));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending =  ascending;
    });
  }

  int compareString(bool ascending, String name, String name2) {
    return ascending ? name.compareTo(name2) : name2.compareTo(name);
  }
}