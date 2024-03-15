import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/modules/students/controller/students_controller.dart';

class StudentsPage extends StatelessWidget {
  StudentsPage({super.key});

  StudentsController controller = Get.find<StudentsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
      body: Obx(() {
        if(controller.profiles.isEmpty && !controller.isLoading){
          return const Center(child: Text('No profiles yet!'));
        }
        else if(controller.profiles.isNotEmpty && !controller.isLoading){
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black12,
                            ),
                            child: Center(
                              child: TextFormField(
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
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            height: 40,
                            width: 240,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Text(PlacedStrings.sortByText),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              height: 40,
                              width: 115,
                              decoration: BoxDecoration(
                                  color:
                                  PlacedColors.PrimaryBlueMain,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white,),
                                  Text(
                                    PlacedStrings.addStudent,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
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
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: 3,
                          dividerThickness: 0.00000000001,
                          columns: [
                            DataColumn(label: Text('SR.NO')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Date of Birth')),
                            DataColumn(label: Text('IU')),
                            DataColumn(label: Text('Phone Number')),
                            DataColumn(label: Text('Course')),
                            DataColumn(label: Text('Degree')),
                            DataColumn(label: Text('Year')),
                            DataColumn(label: Text('Semester'))
                          ],
                          rows: controller.getDataRow()),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if(controller.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }
        else{
          return const Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}
