import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? _file = await imagePicker.pickImage(source: source);
  try {
    if (_file != null) {
      print(_file.readAsBytes());
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  } catch (e) {}
}
