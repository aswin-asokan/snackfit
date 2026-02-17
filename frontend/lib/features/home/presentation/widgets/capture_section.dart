import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/shared/extensions/theme_extension.dart';
import 'package:frontend/shared/widgets/custom_button.dart';
import 'package:frontend/features/camera/presentation/screens/take_picture_screen.dart';

class CaptureSection extends StatefulWidget {
  final void Function(File image) onImageCaptured; // callback to parent

  const CaptureSection({super.key, required this.onImageCaptured});

  @override
  State<CaptureSection> createState() => _CaptureSectionState();
}

class _CaptureSectionState extends State<CaptureSection> {
  File? imageFile;

  Future<void> _pickFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      setState(() => imageFile = file);
      widget.onImageCaptured(file); // send to parent
    }
  }

  Future<void> _captureFromCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: firstCamera),
      ),
    );

    if (imagePath != null) {
      final file = File(imagePath);
      setState(() => imageFile = file);
      widget.onImageCaptured(file); // send to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Serve us your look!", style: context.textTheme.titleLarge),
            Text(
              "Because you’re what you eat…",
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
        CustomButton(
          bgColor: context.colorScheme.primary,
          labelColor: context.colorScheme.onPrimary,
          label: "Upload a Photo",
          onPress: _pickFromGallery,
        ),
        CustomButton(
          bgColor: context.colorScheme.inversePrimary,
          labelColor: context.colorScheme.onPrimaryFixedVariant,
          label: "Capture a Photo",
          onPress: _captureFromCamera,
        ),
      ],
    );
  }
}
