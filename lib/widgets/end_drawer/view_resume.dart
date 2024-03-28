import 'package:flutter/material.dart';
import 'package:placed_web/appwrite/storage/storage.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewResume extends StatelessWidget {
  Profile profile;
  ViewResume({required this.profile, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 263,
      width: 467,
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
          // border: Border.all(color: PlacedColors.PrimaryBlueMain),
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
          color: PlacedColors.PrimaryBlueLight1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center widget wrapped in Expanded
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.picture_as_pdf, size: 42,),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${profile.name} - Resume',
                        style: TextStyle(
                            fontSize: 16,
                            color: PlacedColors.PrimaryBlack,
                            fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // TextButton at the bottom
          Container(
            // width: double.infinity,
            // Make button width as wide as the screen
            padding: EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () {
                // Button onPressed callback
                final uri = Uri.parse(
                    AppwriteStorage.getResumeViewUrl(
                        profile.id));
                launchUrl(uri);
              },
              child: Text(
                'View Resume',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: PlacedColors.PrimaryBlueMain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
