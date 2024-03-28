import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/modules/students/controller/students_controller.dart';
import 'package:placed_web/widgets/end_drawer/end_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentsPage extends StatefulWidget {
  StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  StudentsController controller = Get.find<StudentsController>();
  TextEditingController searchController = TextEditingController();
  final drawerKey = GlobalKey<ScaffoldState>();
  List<Profile> filteredData = [];
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredData = controller.profiles;
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? controller.profiles
          : controller.profiles
          .where((profile) =>
      profile.name.toLowerCase().contains(text.toLowerCase()) ||
          profile.IU.toLowerCase().contains(text.toLowerCase()) ||
          profile.email.toLowerCase().contains(text.toLowerCase()) ||
          profile.phoneNumber.toString().toLowerCase().contains(
              text.toLowerCase()))
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
      appBar: AppBar(
        backgroundColor: PlacedColors.backgroundWhite,
        title: Text('Students',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
      body: Obx(() {
        if (controller.profiles.isEmpty && !controller.isLoading) {
          return const Center(child: Text('No profiles yet!'));
        }
        else if (controller.profiles.isNotEmpty && !controller.isLoading) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
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
                          child: TextFormField(
                            onChanged: _onSearchTextChanged,
                            decoration: InputDecoration(
                              prefix: InkWell(
                                onTap: () {},
                                child: const Icon(Icons.search),
                              ),
                              hintText: PlacedStrings.searchTableHintText,
                              hintStyle: const TextStyle(fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.exportToExcel();
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: PlacedColors.PrimaryBlueMain),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                                PlacedStrings.exportSheet,
                                style: TextStyle(
                                    color: PlacedColors.PrimaryBlueMain),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SingleChildScrollView(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            sortColumnIndex: 2,
                            sortAscending: isAscending,
                            dividerThickness: 0.00000000001,
                            columns: [
                              DataColumn(label: Text('SR.NO')),
                              DataColumn(label: Text('Profile')),
                              DataColumn(label: Text('Name'), onSort: onSort),
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
                                        InkWell(
                                          onTap: () {
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                shape: BoxShape.circle
                                            ),
                                            child: CircleAvatar(
                                              radius: 50,
                                              // Adjust the radius as needed
                                              backgroundColor: Colors
                                                  .transparent,
                                              // Make the background transparent
                                              backgroundImage: NetworkImage(
                                                AppwriteStorage.getImageViewUrl(
                                                    profile.id), scale: 10,),
                                            ),
                                          ),
                                        )
                                    ),
                                    DataCell(Text(profile.name)),
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
                                              final Uri _url = Uri.parse(
                                                  AppwriteStorage
                                                      .getResumeViewUrl(
                                                      profile.id));
                                              launchUrl(_url);
                                            },
                                            child: const Text('View resume')
                                        )
                                    )
                                  ]);
                            })
                        )
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        else {
          return const Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 2) {
      filteredData.sort((profile1, profile2) =>
          compareString(ascending, profile1.name, profile2.name));
    }
    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String name, String name2) {
    return ascending ? name.compareTo(name2) : name2.compareTo(name);
  }
}
