import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.jobPost.companyName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Obx((){
        return controller.profiles.isNotEmpty ?
        ListView.separated(itemBuilder: (ctx, index){
          return Card(
            child: ListTile(
              title: Text(controller.profiles[index].name),
            ),
          );
        }, separatorBuilder: (ctx, index){
          return const SizedBox(height: 10,);
        }, itemCount: controller.profiles.length) : Center(child: Text('No Applications yet!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),);
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          width: MediaQuery.of(context).size.width * 0.3,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Send broadcast message', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
              Icon(Icons.keyboard_arrow_up_outlined, color: Colors.white, )
            ],
          ),
        ),
      ),
    );
  }
}
