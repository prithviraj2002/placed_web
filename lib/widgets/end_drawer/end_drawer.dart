import 'package:flutter/material.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/widgets/end_drawer/activity_tab.dart';
import 'package:placed_web/widgets/end_drawer/education_details.dart';
import 'package:placed_web/widgets/end_drawer/personal_details.dart';
import 'package:placed_web/widgets/end_drawer/view_resume.dart';

class StudentDrawer extends StatefulWidget {
  Profile profile;

  StudentDrawer({required this.profile, super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        surfaceTintColor: PlacedColors.PrimaryWhite,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 220.0,
            actions: [],
            flexibleSpace: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipOval(
                  child: Image.network(
                    AppwriteStorage.getImageViewUrl(widget.profile.id),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.profile.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.profile.degree,
                      style: TextStyle(
                          color: PlacedColors.PrimaryGrey2, fontSize: 16),
                    ),
                    Text(', '),
                    Text(
                      widget.profile.course,
                      style: TextStyle(
                          color: PlacedColors.PrimaryGrey2, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
                dividerColor: Colors.white,
                labelColor: PlacedColors.PrimaryBlack,
                controller: tabController,
                tabs: [
                  Text('Personal', style: TextStyle(fontSize: 18),),
                  Text('Educational', style: TextStyle(fontSize: 18),),
                  Text('Resume',  style: TextStyle(fontSize: 18),),
                  Text('Activity',  style: TextStyle(fontSize: 18),),
                ]),
          ),
          body: TabBarView(
            controller: tabController,
            children: [PersonalDetails(profile: widget.profile),EducationDetails(profile: widget.profile), ViewResume(profile: widget.profile), ActivityTab(profile: widget.profile)],
          ),
        ));
  }
}