import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';
import 'package:placed_web/ui/closed_FAB/closed_fab.dart';
import 'package:placed_web/ui/expanded_FAB/expanded_fab.dart';

class JobDetails extends StatefulWidget {
  JobPost jobPost;

  JobDetails({required this.jobPost, super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  JobDetailController controller = Get.find<JobDetailController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfiles(widget.jobPost.jobId);
    controller.getAnnouncements(widget.jobPost.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.jobPost.companyName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() {
          return controller.profiles.isNotEmpty
              ? Container(
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4),
                              height: 40,
                              width: 115,
                              decoration: BoxDecoration(
                                  color:
                                  const Color(PlacedColors.primaryBlue),
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
                                      color: Color(
                                          PlacedColors.primaryBlue)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Center(
                                  child: Text(
                                    PlacedStrings.exportSheet,
                                    style: TextStyle(
                                        color: Color(
                                            PlacedColors.primaryBlue)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
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
          )
              : controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
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
            height: controller.isExpanded.value ? MediaQuery.of(context).size.width * 0.3 : 50,
            width: MediaQuery.of(context).size.width * 0.25,
            child: controller.isExpanded.value
                ? ExpandedFAB(
                jobPost: widget.jobPost)
                : ClosedFAB(),
          );
        })
    );
  }
}

// ListView.separated(itemBuilder: (ctx, index){
// return Card(
// child: ListTile(
// title: Text(controller.profiles[index].name),
// ),
// );
// }, separatorBuilder: (ctx, index){
// return const SizedBox(height: 10,);
// }, itemCount: controller.profiles.length)
