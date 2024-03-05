import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/model/broadcast_model/boradcast_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';
import 'package:placed_web/ui/closed_FAB/closed_fab.dart';

class ExpandedFAB extends StatefulWidget {
  JobPost jobPost;

  ExpandedFAB({required this.jobPost, super.key});

  @override
  State<ExpandedFAB> createState() => _ExpandedFABState();
}

class _ExpandedFABState extends State<ExpandedFAB> {
  TextEditingController messageController = TextEditingController();
  JobDetailController controller = Get.find<JobDetailController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.25,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              controller.isExpanded.value = !controller.isExpanded.value;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.5,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Send broadcast message',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            return controller.announcements.isNotEmpty ?
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: const BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide())),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return Container(
                              color: Colors.black12,
                              child: Text(
                                  controller.announcements[index].message),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: controller.announcements.length),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              maxLines: null,
                              controller: messageController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Send Message...'
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              final BroadcastMessage message = BroadcastMessage(
                                  message: messageController.text,
                                  date: DateTime.now().toIso8601String(),
                                  time: DateTime.now().toIso8601String(),
                                  jobId: widget.jobPost.jobId
                              );
                              controller.sendAnnouncement(message);
                              messageController.text = '';
                            }
                          }, icon: Icon(Icons.send)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.attach_file)
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ) : const Center(
              child: Text('No Announcements yet!'),
              );
          })
        ],
      ),
    );
  }
}
