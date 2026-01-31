import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_center/core/services/image_service.dart';
import 'package:medical_center/core/utils/app_colors.dart';
import 'package:medical_center/core/utils/app_text_styles.dart';
import 'package:medical_center/core/widgets/custom_button.dart';
import 'package:medical_center/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_cubit.dart';
import 'package:medical_center/features/profile/presentation/profile_cubit/profile_state.dart';
import 'package:medical_center/generated/l10n.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final ImageService _imageService = ImageService();

  String? _selectedPhotoBase64;
  Uint8List? _selectedPhotoBytes;

  @override
  void initState() {
    super.initState();
    // Initialize with current user data
    final cubit = context.read<ProfileCubit>();
    final user = cubit.originalUser;
    _nameController.text =
        user != null ? '${user.firstName} ${user.lastName}' : '';
    _phoneController.text = user?.phone ?? '';
    _emailController.text = user?.email ?? '';

    // Load existing profile photo if available
    if (user?.image != null && user!.image.isNotEmpty) {
      _selectedPhotoBytes = _imageService.getImageFromBase64(user.image);
    }
  }

  Future<void> _pickImage(bool fromCamera) async {
    final base64Image = await _imageService.pickImage(
      fromCamera: fromCamera,
    );

    if (base64Image != null) {
      setState(() {
        _selectedPhotoBase64 = base64Image;
        _selectedPhotoBytes = _imageService.getImageFromBase64(base64Image);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).select_photo_source,
                style: AppTextStyles.cairo400Style20.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading:
                    const Icon(Icons.camera_alt, color: AppColors.primaryColor),
                title: Text(S.of(context).camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(true);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library,
                    color: AppColors.primaryColor,),
                title: Text(S.of(context).gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).edit_profile),
          elevation: 0,
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context); // Go back after successful update
            } else if (state is ProfileUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileUpdateLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Profile Photo Section
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightGrey.withValues(alpha: 0.3),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 3,
                              ),
                            ),
                            child: _selectedPhotoBytes != null
                                ? ClipOval(
                                    child: Image.memory(
                                      _selectedPhotoBytes!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 60,
                                    color: AppColors.deepGrey
                                        .withValues(alpha: 0.5),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: isLoading ? null : _showImageSourceDialog,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).tap_to_change_photo,
                      style: AppTextStyles.cairo300style16.copyWith(
                        fontSize: 12,
                        color: AppColors.deepGrey,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Name Field
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: S.of(context).full_name,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.of(context).field_required;
                        }
                        if (value!.length < 3) {
                          return S.of(context).name_must_be_3_chars;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone Field
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: S.of(context).phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.of(context).field_required;
                        }
                        if (value!.length < 10) {
                          return S.of(context).please_enter_valid_phone;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Field (Read-only)
                    Opacity(
                      opacity: 0.6,
                      child: CustomTextFormField(
                        controller: _emailController,
                        labelText: S.of(context).email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Email cannot be changed',
                        style: AppTextStyles.cairo300style16.copyWith(
                          fontSize: 12,
                          color: AppColors.deepGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Save Button
                    CustomButton(
                      text: isLoading
                          ? S.of(context).saving
                          : S.of(context).save_changes,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<ProfileCubit>().updateProfile(
                                      name: _nameController.text.trim(),
                                      phone: _phoneController.text.trim(),
                                      profilePhotoBase64: _selectedPhotoBase64,
                                    );
                              }
                            },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
