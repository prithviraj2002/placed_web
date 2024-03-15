import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';
import 'package:placed_web/widgets/custom_message.dart';
import 'package:placed_web/widgets/custom_message_withPDF.dart';

class ExpandedFAB extends StatefulWidget {
  JobPost jobPost;

  ExpandedFAB({required this.jobPost, super.key});

  @override
  State<ExpandedFAB> createState() => _ExpandedFABState();
}

class _ExpandedFABState extends State<ExpandedFAB> {
  TextEditingController messageController = TextEditingController();
  JobDetailController controller = Get.find<JobDetailController>();
  ScrollController listController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  void _scrollToEnd() {
    listController.animateTo(
      listController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
    listController.dispose();
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
                        controller: listController,
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            if (controller
                                .announcements[index]
                                .pdfUrl
                                .isNotEmpty) {
                              return CustomMessageWithPDF(
                                text: controller
                                    .announcements[index]
                                    .message,
                                pdfUrl: controller
                                    .announcements[index]
                                    .pdfUrl
                              );
                            } else {
                              return CustomMessage(
                                msgText: controller
                                    .announcements[index]
                                    .message,
                              );
                            }
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
                              controller.sendAnnouncement(messageController.text, widget.jobPost);
                              messageController.text = '';
                            }
                          }, icon: Icon(Icons.send)),
                          IconButton(
                              onPressed: () {
                                controller.uploadDocuments();
                              },
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
            ) : controller.announcements.isEmpty ? Center(
              child: Text('No Announcements yet!'),
            ) : Center(child: CircularProgressIndicator());
          })
        ],
      ),
    );
  }
}
