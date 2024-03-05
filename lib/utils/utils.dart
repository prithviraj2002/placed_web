import 'dart:io';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class Utils{
  static Future<String> pickLogo() async{
    final ImagePickerPlugin picker = ImagePickerPlugin();
    final XFile? image = await picker.getImageFromSource(source: ImageSource.gallery);
    if(image!.path.isNotEmpty){
      return image.path;
    }
    else{
      return '';
    }
  }

  static Future<PlatformFile?> pickDocs() async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      return PlatformFile(name: result.files.first.name, size: result.files.first.size);
    }
    return null;
  }
}