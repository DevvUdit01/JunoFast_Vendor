
import 'package:get/get.dart';

class FormPageControlller extends GetxController{

//dependencies:
 // image_picker: ^0.8.7+3
// Future<File?> pickLicenseImage() async {
//   final ImagePicker _picker = ImagePicker();
//   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

//   if (image != null) {
//     return File(image.path);
//   }
//   return null;
// }

// firebse storage code

// dependencies:
//   firebase_storage: ^11.0.16
// Future<String?> uploadLicenseImage(File image) async {
//   try {
//     String fileName = 'licenses/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     UploadTask task = FirebaseStorage.instance.ref(fileName).putFile(image);
//     TaskSnapshot snapshot = await task;
//     return await snapshot.ref.getDownloadURL();
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }


}