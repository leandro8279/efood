import 'package:country_code_picker/country_code_picker.dart';
import 'package:efood/domain/models/auth/auth_register.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/ui/auth/register/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.viewModel});

  final RegisterViewModel viewModel;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController(text: "Joe");
  final TextEditingController _lastNameController = TextEditingController(text: "Doe");
  final TextEditingController _numberController = TextEditingController(text: "12345678910");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController(text: "pass@1234");
  final TextEditingController _confirmPasswordController = TextEditingController(text: "pass@1234");
  String _countryDialCode = '';

  @override
  void initState() {
    super.initState();

    final initialContact = Get.arguments;
    if (widget.viewModel.emailVerification && initialContact is String) {
      _emailController.text = initialContact;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: .all(AppDimens.paddingLarge),
              child: Center(
                child: Container(
                  width: width > 700 ? 700 : width,
                  padding: width > 700 ? EdgeInsets.all(AppDimens.paddingDefault) : null,
                  decoration: width > 700
                      ? BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 1)],
                        )
                      : null,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'create_account'.tr,
                          style: AppTextStyles.headline3(fontSize: 24, color: AppColors.getGreyBunkerColor()),
                        ),
                      ),
                      SizedBox(height: 20),
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

                      RenderConditional(
                        conditional: widget.viewModel.emailVerification,
                        widget1: CustomTextField(
                          hintText: 'Doe',
                          isShowBorder: true,
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          nextFocus: _emailFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                        ),
                        widget2: CustomTextField(
                          hintText: 'Doe',
                          isShowBorder: true,
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          nextFocus: _numberFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                        ),
                      ),

                      SizedBox(height: AppDimens.paddingLarge),
                      Text('email'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                      SizedBox(height: AppDimens.paddingSmall),

                      CustomTextField(
                        hintText: 'demo_gmail'.tr,
                        isShowBorder: true,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        nextFocus: _passwordFocus,
                        inputType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: AppDimens.paddingLarge),
                      Text('mobile_number'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                      SizedBox(height: AppDimens.paddingSmall),
                      Row(
                        children: [
                          CodePickerWidget(
                            onChanged: (CountryCode countryCode) {
                              _countryDialCode = countryCode.dialCode ?? '';
                            },
                            onInit: (CountryCode countryCode) {
                              _countryDialCode = countryCode.dialCode ?? '';
                            },
                            initialSelection: 'US',
                            favorite: [_countryDialCode],
                            showDropDownButton: true,
                            padding: EdgeInsets.zero,
                            showFlagMain: true,
                            textStyle: TextStyle(color: AppTextStyles.headline1().color),
                          ),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'number_hint'.tr,
                              isShowBorder: true,
                              controller: _numberController,
                              focusNode: _numberFocus,
                              nextFocus: _passwordFocus,
                              inputType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimens.paddingLarge),

                      // for password section
                      Text('password'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                      SizedBox(height: AppDimens.paddingSmall),
                      CustomTextField(
                        hintText: 'password_hint'.tr,
                        isShowBorder: true,
                        isPassword: true,
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        nextFocus: _confirmPasswordFocus,
                        isShowSuffixIcon: true,
                      ),
                      SizedBox(height: 22),

                      // for confirm password section
                      Text('confirm_password'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                      SizedBox(height: AppDimens.paddingSmall),
                      CustomTextField(
                        hintText: 'password_hint'.tr,
                        isShowBorder: true,
                        isPassword: true,
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        isShowSuffixIcon: true,
                        inputAction: TextInputAction.done,
                      ),

                      SizedBox(height: 22),
                      RenderCommandError<AuthRegister>(
                        command: widget.viewModel.register.result,
                        widget: (message) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingSmall),
                          child: Text(
                            message,
                            style: AppTextStyles.headline2(
                              fontSize: AppDimens.fontSizeSmall,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),

                      // for signup button
                      SizedBox(height: 10),

                      Obx(
                        () => widget.viewModel.register.running.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                ),
                              )
                            : CustomButton(btnTxt: 'signup'.tr, onTap: _submitRegistration),
                      ),

                      // for already an account
                      SizedBox(height: 11),
                      InkWell(
                        onTap: () => Get.offNamed(AppRoutes.login),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'already_have_account'.tr,
                                style: AppTextStyles.headline2(
                                  fontSize: AppDimens.fontSizeSmall,
                                  color: AppColors.getGreyColor(),
                                ),
                              ),
                              SizedBox(width: AppDimens.paddingSmall),
                              Text(
                                'login'.tr,
                                style: AppTextStyles.headline3(
                                  fontSize: AppDimens.fontSizeSmall,
                                  color: AppColors.getGreyBunkerColor(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitRegistration() async {
    final fName = _firstNameController.text.trim();
    final lName = _lastNameController.text.trim();
    final number = _numberController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (fName.isEmpty) {
      showCustomSnackBar('enter_first_name'.tr, context);
      return;
    }

    if (lName.isEmpty) {
      showCustomSnackBar('enter_last_name'.tr, context);
      return;
    }

    if (email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr, context);
      return;
    }

    if (!GetUtils.isEmail(email)) {
      showCustomSnackBar('enter_valid_email'.tr, context);
      return;
    }

    if (number.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr, context);
      return;
    }

    if (password.trim().isEmpty) {
      showCustomSnackBar('enter_password'.tr, context);
      return;
    }

    if (password.trim().length < 6) {
      showCustomSnackBar('password_should_be'.tr, context);
      return;
    }

    if (confirmPassword.trim().isEmpty) {
      showCustomSnackBar('enter_confirm_password'.tr, context);
      return;
    }

    if (password != confirmPassword) {
      showCustomSnackBar('password_did_not_match'.tr, context);
      return;
    }

    final phone = number.startsWith('+') ? number : '$_countryDialCode$number';

    await widget.viewModel.register.execute((
      fName: fName,
      lName: lName,
      phone: phone,
      email: email,
      password: password,
    ));

    if (widget.viewModel.register.complete) {
      Get.offNamed(AppRoutes.main);
    }
  }

  @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _numberFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
