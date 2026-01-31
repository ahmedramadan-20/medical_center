import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Service for handling image selection and compression.
///
/// Uses base64 encoding to store images in Firestore instead of Firebase Storage.
/// This approach is free and works well for profile pictures.
class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// Pick an image from the gallery.
  ///
  /// Returns the image as a base64 string, or null if cancelled.
  Future<String?> pickImageFromGallery() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 70,
      );

      if (image != null) {
        return await _convertImageToBase64(image);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image from gallery: $e');
      }
      return null;
    }
  }

  /// Pick an image from the camera.
  ///
  /// Returns the image as a base64 string, or null if cancelled.
  Future<String?> pickImageFromCamera() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 70,
      );

      if (image != null) {
        return await _convertImageToBase64(image);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image from camera: $e');
      }
      return null;
    }
  }

  /// Show a dialog to choose between camera and gallery.
  ///
  /// Returns the image as a base64 string, or null if cancelled.
  Future<String?> pickImage({required bool fromCamera}) async {
    if (fromCamera) {
      return pickImageFromCamera();
    } else {
      return pickImageFromGallery();
    }
  }

  /// Convert an XFile image to base64 string.
  Future<String> _convertImageToBase64(XFile image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  /// Get memory image from base64 string for display.
  Uint8List? getImageFromBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return null;
    }
    try {
      return base64Decode(base64String);
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding base64 image: $e');
      }
      return null;
    }
  }
}
