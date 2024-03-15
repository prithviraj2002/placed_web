import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomMessageWithPDF extends StatelessWidget {
  String text; String pdfUrl;
  CustomMessageWithPDF({required this.text, required this.pdfUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
      child: ClipPath(
        clipper: UpperNipMessageClipperTwo(MessageType.receive),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
          decoration: BoxDecoration(
            color: PlacedColors.PrimaryBlueLight1,
          ),
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 34,
              ),
              Container(
                height: 100,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: PlacedColors.PrimaryBlueLight1,
                    border:
                        Border.all(color: PlacedColors.PrimaryWhite, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: InkWell(
                  onTap: () {
                    launchUrl(Uri.parse(pdfUrl));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.file_copy, size: 48,),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Campus Drive',
                              style: TextStyle(fontSize: 12, color: PlacedColors.PrimaryBlack)
                            ),
                            Text(
                              '4.1 MB',
                              style: TextStyle(
                                  fontSize: 8,
                                  color: PlacedColors.PrimaryGrey2,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
