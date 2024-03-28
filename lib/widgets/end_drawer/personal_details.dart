import 'package:flutter/material.dart';
import 'package:placed_web/appwrite/appwrite_db/appwrite_db.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/profile_model/profile_model.dart';
import 'package:placed_web/modules/home_module/view/home.dart';

class PersonalDetails extends StatefulWidget {
  Profile profile;
  PersonalDetails({required this.profile, super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  List<String> statusOptions = [
    'Active', 'Blocked'
  ];

  String selectedStatus = 'Active';

  void setStatus(){
    if(widget.profile.status){
      selectedStatus = 'Active';
    }
    else if(!widget.profile.status){
      selectedStatus = 'Blocked';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      children: [
        Text('Email', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(widget.profile.email, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Phone Number', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(widget.profile.phoneNumber, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Enrollment Number', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(widget.profile.IU, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Date of Birth', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(widget.profile.dateOfBirth, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Residential Address', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        Text(widget.profile.address, style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
        const SizedBox(height: 8,),
        Text('Account Status', style: TextStyle(color: PlacedColors.PrimaryGrey3),),
        const SizedBox(height: 2,),
        DropdownButton(
          underline: Container(),
          value: selectedStatus,
            items: statusOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  height: 28,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: value == 'Active' ? PlacedColors.SecondaryGreen3 : Color(0xffFFB5B5)
                  ),
                  child: Center(child: Text(value, style: TextStyle(color: value == 'Active' ? PlacedColors.SecondaryGreen2 : PlacedColors.SecondaryRed),)),
                ),
              );
            }).toList(), onChanged: (dynamic value){
            if(value != null){
              showDialog(context: context, builder: (ctx){
                return AlertDialog(
                  title: selectedStatus == 'Blocked' ? Text('${widget.profile.name} will not be able to apply to other job posts') : Text('${widget.profile.name} will be able to apply to other job posts'),
                  content: selectedStatus == 'Blocked' ? Text('Are you sure you want to block this student?') : Text('Are you sure you want to unblock this student?'),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: Text('No')),
                    TextButton(onPressed: () {
                      if(selectedStatus == 'Blocked'){
                        widget.profile.status = false;
                        AppWriteDb.blockAccount(widget.profile).then((value) {
                          if(value.$id.isNotEmpty){
                            showDialog(context: (context), builder: (ctx){
                              Future.delayed(Duration(seconds: 5), (){
                                print('After successfully blocking ${widget.profile.status}');
                                Navigator.pop(context);
                              });
                              return AlertDialog(
                                title: Text('${widget.profile.name} blocked successfully!'),
                              );
                            });
                          } else{
                            showDialog(context: (context), builder: (ctx){
                              Future.delayed(Duration(seconds: 5), (){
                                Navigator.pop(context);
                              });
                              return AlertDialog(
                                title: Text('${widget.profile.name} could not be blocked! An error occurred'),
                              );
                            });
                          }
                        });
                      }
                      else if(selectedStatus == 'Active'){
                        widget.profile.status = true;
                        AppWriteDb.blockAccount(widget.profile).then((value) {
                          if(value.$id.isNotEmpty){
                            showDialog(context: (context), builder: (ctx){
                              Future.delayed(Duration(seconds: 5), (){
                                Navigator.pop(context);
                              });
                              return AlertDialog(
                                title: Text('${widget.profile.name} unblocked successfully!'),
                              );
                            });
                          } else{
                            showDialog(context: (context), builder: (ctx){
                              Future.delayed(Duration(seconds: 5), (){
                                Navigator.pop(context);
                              });
                              return AlertDialog(
                                title: Text('${widget.profile.name} could not be unblocked! An error occurred'),
                              );
                            });
                          }
                        });
                      }
                    }, child: Text('Yes'))
                  ],
                );
              });
              setState(() {
                selectedStatus = value;
              });
            }
        })
        // Text(profile.status.toString(), style: TextStyle(color: PlacedColors.PrimaryBlack, fontSize: 16),),
      ],
    );
  }
}
