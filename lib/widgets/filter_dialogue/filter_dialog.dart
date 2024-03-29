import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/constants/app-ui/placed_colors.dart';
import 'package:placed_web/model/filter_model/filter_model.dart';
import 'package:placed_web/model/job_model/job_model.dart';
import 'package:placed_web/modules/post_a_job_module/controller/post_job_controller.dart';

class FilterDialog extends StatefulWidget {
  // JobPost jobPost;
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

  TextEditingController semController = TextEditingController();
  TextEditingController cgpaController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController yearOfGraduationController = TextEditingController();
  TextEditingController activeBacklogController = TextEditingController();
  TextEditingController totalBackLogController = TextEditingController();
  TextEditingController XIIMarksController = TextEditingController();
  TextEditingController diplomaMarksController = TextEditingController();
  TextEditingController XMakrsController = TextEditingController();

  PostJobController controller = Get.find<PostJobController>();

  String selectedBranch = '';
  List<String> branchOptions = [
    'CE',
    'CSE',
    'IT'
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    semController.dispose();
    cgpaController.dispose();
    branchController.dispose();
    yearOfGraduationController.dispose();
    activeBacklogController.dispose();
    totalBackLogController.dispose();
    XIIMarksController.dispose();
    diplomaMarksController.dispose();
    XMakrsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: PlacedColors.PrimaryWhite,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        margin: const EdgeInsets.only(left: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Eligibility Criteria', style: TextStyle(fontSize: 20),),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Current semester',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'greater than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: semController,
                    decoration: InputDecoration(
                        hintText: 'Between 1 and 8',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'CGPA',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'greater than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: cgpaController,
                    decoration: InputDecoration(
                        hintText: 'Between 1.0 and 10.0',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Branch',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: PlacedColors.PrimaryGrey4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonFormField(
                          items: branchOptions.map((String value){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value)
                            );
                          }).toList(),
                          onChanged: (String? value){
                            if(value != null){
                              setState(() {
                                selectedBranch = value;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select value'
                          ),
                        ),
                      )
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Year of graduation',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: yearOfGraduationController,
                    decoration: InputDecoration(
                        hintText: 'eg. 2024',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Active backlogs',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'less than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: activeBacklogController,
                    decoration: InputDecoration(
                        hintText: 'Between 0 and 9',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Total backlogs',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'less than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: totalBackLogController,
                    decoration: InputDecoration(
                        hintText: 'Between 0 and 9',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Percentage in 12th',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'greater than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: XIIMarksController,
                    decoration: InputDecoration(
                        hintText: 'eg. 90, 80 etc',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Diploma percentage',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'greater than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: diplomaMarksController,
                    decoration: InputDecoration(
                        hintText: 'eg. 90, 80 etc',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                children: <Widget>[
                  Expanded(child: Text('Criteria', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Condition', style: TextStyle(fontSize: 16),)),
                  const SizedBox(width: 16,),
                  Expanded(child: Text('Value', style: TextStyle(fontSize: 16),)),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'Percentage in 10th',
                        hintStyle: TextStyle(color: PlacedColors.PrimaryBlack),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'greater than or equal to',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                  const SizedBox(width: 16,),
                  Expanded(child: TextFormField(
                    controller: XMakrsController,
                    decoration: InputDecoration(
                        hintText: 'eg. 90, 80 etc',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: PlacedColors.PrimaryGrey4),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: PlacedColors.PrimaryGrey4)
                        )
                    ),
                  ),),
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Filter filter = Filter(
                          currentSemester: int.parse(semController.text) ?? 1,
                          CGPA: double.parse(cgpaController.text) ?? 1.0,
                          branch: selectedBranch,
                          yearOfGraduation: yearOfGraduationController.text ?? '',
                          activeBackLogs: int.parse(activeBacklogController.text) ?? 0,
                          totalBackLogs: int.parse(totalBackLogController.text) ?? 0,
                          XIIMarks: double.parse(XIIMarksController.text) ?? 0.0,
                          diplomaMarks: double.parse(diplomaMarksController.text) ?? 0.0,
                          XMarks: double.parse(XMakrsController.text) ?? 0.0
                      );
                      controller.filter!.value = filter;
                      print('Filters selected');
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 104, height: 48,
                      decoration: BoxDecoration(
                          color: PlacedColors.PrimaryBlueMain,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text('Save', style: TextStyle(color: PlacedColors.PrimaryWhite, fontSize: 16),)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}