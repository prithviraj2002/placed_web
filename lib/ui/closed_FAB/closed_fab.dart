import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/modules/job_details/controller/job_details_controller.dart';

class ClosedFAB extends StatelessWidget {
  ClosedFAB({super.key});

  JobDetailController controller = Get.find<JobDetailController>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      controller.isExpanded.value = !controller.isExpanded.value;
    }, child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: MediaQuery
          .of(context)
          .size
          .width * 0.5,
      height: 50,
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Send broadcast message',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Icon(
              Icons.keyboard_arrow_up_outlined,
              color: Colors.white,
            )
          ],
        ),
      ),),
    );
  }
}
