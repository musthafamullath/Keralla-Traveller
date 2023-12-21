import 'package:image_picker/image_picker.dart';

XFile? image;
Future<XFile?> pickImageFrom() async {
  final pickedImages =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImages != null) {
    return XFile(pickedImages.path);
  }
  return null;
}


