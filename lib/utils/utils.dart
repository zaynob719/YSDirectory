import 'package:YSDirectory/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: brown,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        content: Text(content),
      ),
    );
  }
}

Future<List<int>?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  try {
    final XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      // No image selected
      return null;
    }
  } catch (e) {
    // Handle any errors that occurred during image selection
    //print('Error selecting image: $e');
    return null;
  }
}
