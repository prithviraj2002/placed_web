import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/ui/job_details_dialog/job_details_dialogue.dart';
import 'package:placed_web/utils/utils.dart';

class ActivityTab extends StatelessWidget {
  Profile profile;
  ActivityTab({required this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    return profile.appliedJobs!.isNotEmpty ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12,),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text('Applied jobs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        const SizedBox(height: 4,),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () async {
                    JobPost job = await AppWriteDb.getJobById(profile.appliedJobs![index]);
                    showDialog(
                        context: context,
                        builder: (ctx){
                          return JobDetailsDialog(jobPost: job, allowEdit: false,);
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: PlacedColors.PrimaryBlueLight1),
                      boxShadow: [
                        BoxShadow(
                          color: PlacedColors.CardShadowBlack,
                          blurRadius: 20,
                          offset: Offset(3, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: PlacedColors.PrimaryWhite,
                    ),
                    margin: EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(left: 16,top: 8),
                            decoration: BoxDecoration(
                              color: PlacedColors.PrimaryWhite,
                              shape: BoxShape.circle,
                              border: Border.all(color: PlacedColors.PrimaryWhite, width: 1.0),
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: PlacedColors.PrimaryBlueLight1)
                                ),
                                child: ClipOval(child: Image.network(AppwriteStorage.getDeptDocViewUrl(profile.appliedJobs![index]), height: 32, width: 32, scale: 10, fit: BoxFit.cover,)))
                        ),
                        // Second part with text
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: FutureBuilder(
                                      future: AppWriteDb.getJobById(profile.appliedJobs![index]),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          JobPost job = snapshot.data;
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Title text
                                              Text(
                                                job.positionOffered,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: PlacedColors.PrimaryBlack,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(job.companyName)
                                            ],
                                          );
                                        } else if (snapshot.hasError) {
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                              children: [CircularProgressIndicator()]);
                                        }
                                      })),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(height: 4,);
              },
              itemCount: profile.appliedJobs!.length
          ),
        ),
      ],
    ) : Center(child: Text('Not applied to any jobs yet!', style: TextStyle(fontSize: 20),),);
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.companyName, required this.icon});

  final String companyName;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: Color(0xFF6C6C6C),
          height: 16,
          width: 16,
        ),
        SizedBox(width: 4,),
        Text(
          companyName,
          style: TextStyle(
              color: PlacedColors.PrimaryGrey2,
              fontSize: 12,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}
