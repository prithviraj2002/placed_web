import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/constants/app-ui/placed_strings.dart';
import 'package:placed_web/modules/home_module/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.listenToProfiles();
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
      body: Row(
        children: <Widget>[
          Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.2,
              color: const Color(PlacedColors.primaryBlue),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        PlacedStrings.indusUniversity,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        PlacedStrings.overview,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        PlacedStrings.students,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        PlacedStrings.companies,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ])),
          Expanded(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            PlacedStrings.students,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color:
                                      const Color(PlacedColors.primaryBlue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                        PlacedStrings.addStudent,
                                        style: TextStyle(color: Colors.white),
                                      )),
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
                                  width: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(
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
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() { return
                        controller.profiles.isEmpty ? const Center(
                          child: CircularProgressIndicator(),
                        ) : ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(controller.profiles[index].name),
                                    Text(controller.profiles[index].IU),
                                    Text(controller.profiles[index].branch),
                                    Text(controller.profiles[index].sem.toString()),
                                    Text(controller.profiles[index].cgpa.toString()),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider(color: Colors.black12,);
                            },
                            itemCount: controller.profiles.length
                        );
                      })
                    ])),
          ),
        ],
      ),
    );
  }
}
