import 'dart:io';

import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/profile/profile_viewmodel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class const ProfileScreen({super.key, required final ProfileViewModel viewModel}) extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late FocusNode _firstNameFocus;
  late FocusNode _lastNameFocus;
  late FocusNode _emailFocus;
  late FocusNode _phoneNumberFocus;
  late FocusNode _passwordFocus;
  late FocusNode _confirmPasswordFocus;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late File? file;
  late XFile? data;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void _choose() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      }
    });
  }

  Worker? profilerWorker;

  @override
  void initState() {
    super.initState();

    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _emailFocus = FocusNode();
    _phoneNumberFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    profilerWorker = ever(widget.viewModel.profile, (profile) {
      if (profile != null) {
        _firstNameController.text = profile.fName;
        _lastNameController.text = profile.lName;
        _phoneNumberController.text = profile.phone;
        _emailController.text = profile.email;
      }
    });
  }

  @override
  void dispose() {
    profilerWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(context: context, title: 'my_profile'.tr),
      body: Obx(
        () => RenderConditional(
          conditional: widget.viewModel.isSignedIn,
          widget1: RenderConditional(
            conditional: widget.viewModel.profile.value != null,
            widget1: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      child: Center(
                        child: Container(
                          width: width > 700 ? 700 : width,
                          padding: width > 700
                              ? EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge, vertical: AppDimens.paddingSmall)
                              : null,
                          decoration: width > 700
                              ? BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1)],
                                )
                              : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // for profile image
                              Container(
                                margin: EdgeInsets.symmetric(vertical: AppDimens.paddingLarge),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.border,
                                  border: Border.all(color: AppColors.greyChateau, width: 3),
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: _choose,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: RenderConditional(
                                          conditional: file != null,
                                          widget1: Image.file(file!, width: 80, height: 80, fit: BoxFit.fill),
                                          widget2: RenderConditional(
                                            conditional: data != null,
                                            widget1: Image.network(data!.path, width: 80, height: 80, fit: BoxFit.fill),
                                            widget2: FadeInImage.assetNetwork(
                                              placeholder: AppAssets.images.placeholderUser,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              image:
                                                  '${widget.viewModel.config.baseUrls.customerImageUrl}/${widget.viewModel.profile.value!.image}',
                                              imageErrorBuilder: (c, o, s) {
                                                return Image.asset(
                                                  AppAssets.images.placeholderUser,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 15,
                                        right: -10,
                                        child: InkWell(
                                          onTap: _choose,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.border,
                                              border: Border.all(width: 2, color: AppColors.greyChateau),
                                            ),
                                            child: Icon(Icons.edit, size: 13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // for name
                              Center(
                                child: Text(
                                  '${widget.viewModel.profile.value!.fName} ${widget.viewModel.profile.value!.lName}',
                                  style: AppTextStyles.rubikMedium.copyWith(fontSize: AppDimens.fontSizeExtraLarge),
                                ),
                              ),

                              SizedBox(height: 28),
                              // for first name section
                              Text('first_name'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'John',
                                isShowBorder: true,
                                controller: _firstNameController,
                                focusNode: _firstNameFocus,
                                nextFocus: _lastNameFocus,
                                inputType: TextInputType.name,
                                capitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),

                              // for last name section
                              Text('last_name'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'Doe',
                                isShowBorder: true,
                                controller: _lastNameController,
                                focusNode: _lastNameFocus,
                                nextFocus: _phoneNumberFocus,
                                inputType: TextInputType.name,
                                capitalization: TextCapitalization.words,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),

                              // for email section
                              Text('email'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'demo_gmail'.tr,
                                isShowBorder: true,
                                controller: _emailController,
                                isEnabled: false,
                                focusNode: _emailFocus,
                                nextFocus: _phoneNumberFocus,

                                inputType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),

                              // for phone Number section
                              Text('mobile_number'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'number_hint'.tr,
                                isShowBorder: true,
                                controller: _phoneNumberController,
                                focusNode: _phoneNumberFocus,
                                nextFocus: _passwordFocus,
                                inputType: TextInputType.phone,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),
                              Text('password'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'password_hint'.tr,
                                isShowBorder: true,
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                nextFocus: _confirmPasswordFocus,
                                isPassword: true,
                                isShowSuffixIcon: true,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),
                              Text('confirm_password'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'password_hint'.tr,
                                isShowBorder: true,
                                controller: _confirmPasswordController,
                                focusNode: _confirmPasswordFocus,
                                isPassword: true,
                                isShowSuffixIcon: true,
                                inputAction: TextInputAction.done,
                              ),
                              SizedBox(height: AppDimens.paddingLarge),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                RenderConditional(
                  conditional: true, // !profileProvider.isLoading
                  widget1: Center(
                    child: Container(
                      width: width > 700 ? 700 : width,
                      padding: EdgeInsets.all(AppDimens.paddingSmall),
                      margin: EdgeInsets.zero,
                      child: CustomButton(
                        btnTxt: 'update_profile'.tr,
                        onTap: () async {
                          // String _firstName = _firstNameController.text.trim();
                          // String _lastName = _lastNameController.text.trim();
                          // String _phoneNumber = _phoneNumberController.text.trim();
                          // String _password = _passwordController.text.trim();
                          // String _confirmPassword = _confirmPasswordController.text.trim();
                          // if (widget.viewModel.profile.value!.fName == _firstName &&
                          //     widget.viewModel.profile.value!.lName == _lastName &&
                          //     widget.viewModel.profile.value!.phone == _phoneNumber &&
                          //     widget.viewModel.profile.value!.email == _emailController.text &&
                          //     file == null &&
                          //     data == null &&
                          //     _password.isEmpty &&
                          //     _confirmPassword.isEmpty) {
                          //   showCustomSnackBar('change_something_to_update'.tr, context);
                          // } else if (_firstName.isEmpty) {
                          //   showCustomSnackBar('enter_first_name'.tr, context);
                          // } else if (_lastName.isEmpty) {
                          //   showCustomSnackBar('enter_last_name'.tr, context);
                          // } else if (_phoneNumber.isEmpty) {
                          //   showCustomSnackBar('enter_phone_number'.tr, context);
                          // } else if ((_password.isNotEmpty && _password.length < 6) ||
                          //     (_confirmPassword.isNotEmpty && _confirmPassword.length < 6)) {
                          //   showCustomSnackBar('password_should_be'.tr, context);
                          // } else if (_password != _confirmPassword) {
                          //   showCustomSnackBar('password_did_not_match'.tr, context);
                          // } else {
                          //   UserInfoModel updateUserInfoModel = UserInfoModel();
                          //   updateUserInfoModel.fName = _firstName ?? "";
                          //   updateUserInfoModel.lName = _lastName ?? "";
                          //   updateUserInfoModel.phone = _phoneNumber ?? '';
                          //   String _pass = _password ?? '';

                          //   ResponseModel _responseModel = await profileProvider.updateUserInfo(
                          //     updateUserInfoModel,
                          //     _pass,
                          //     file,
                          //     data,
                          //     Provider.of<AuthProvider>(context, listen: false).getUserToken(),
                          //   );

                          //   if (_responseModel.isSuccess) {
                          //     profileProvider.getUserInfo(context);
                          //     showCustomSnackBar('updated_successfully'.tr, context, isError: false);
                          //   } else {
                          //     showCustomSnackBar(_responseModel.message, context);
                          //   }
                          //   setState(() {});
                          // }
                        },
                      ),
                    ),
                  ),
                  widget2: Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                  ),
                ),
              ],
            ),
            widget2: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))),
          ),
          widget2: NotLoggedInScreen(),
        ),
      ),
    );
  }
}
