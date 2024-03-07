import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';

class Utils{
  static Future<Uint8List> pickLogo() async{
    final ImagePickerPlugin picker = ImagePickerPlugin();
    final XFile? image = await picker.getImageFromSource(source: ImageSource.gallery);
    if(image!.path.isNotEmpty){
      final bytesOfFile = await image.readAsBytes();
      return bytesOfFile;
    }
    else{
      return Uint8List(0);
    }
  }

  static Future<PlatformFile?> pickDocs() async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      return result.files.first;
    }
    return null;
  }

  static String reverseString(String val){
    return val.split('').reversed.join('');
  }
}