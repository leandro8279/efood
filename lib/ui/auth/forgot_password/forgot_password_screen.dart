import 'package:country_code_picker/country_code_picker.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/auth/forgot_password/forgot_password_viewmodel.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const ForgotPasswordScreen({super.key, required final ForgotPasswordViewModel viewModel}) extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController(text: "leandro@gmail.com");
  final TextEditingController _phoneNumberController = TextEditingController();
  String _countryDialCode = '';

  // @override
  // void initState() {
  //   //  _countryDialCode = CountryCode.fromCountryCode(
  //   //   Provider.of<SplashProvider>(context, listen: false).configModel.countryCode,
  //   // ).dialCode;
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'forgot_password'.tr),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: .all(AppDimens.paddingLarge),
                child: Container(
                  width: width > 700 ? 700 : width,
                  padding: width > 700 ? .all(AppDimens.paddingDefault) : null,
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
                      SizedBox(height: 55),
                      Center(child: Image.asset(AppAssets.icons.closeLock, width: 142, height: 142)),
                      SizedBox(height: 40),

                      RenderConditional(
                        conditional: false, // .configModel.phoneVerification,
                        widget1: Center(
                          child: Text(
                            'please_enter_your_mobile_number_to'.tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.headline2(color: AppColors.getHintColor()),
                          ),
                        ),
                        widget2: Center(
                          child: Text(
                            'please_enter_your_number_to'.tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.headline2(color: AppColors.getHintColor()),
                          ),
                        ),
                      ),

                      RenderConditional(
                        conditional: false, //.configModel.phoneVerification
                        widget1: Padding(
                          padding: const EdgeInsets.all(AppDimens.paddingLarge),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 80),
                              Text('mobile_number'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              Row(
                                children: [
                                  CodePickerWidget(
                                    onChanged: (CountryCode countryCode) {
                                      _countryDialCode = countryCode.dialCode!;
                                    },
                                    initialSelection: _countryDialCode,
                                    favorite: [_countryDialCode],
                                    showDropDownButton: true,
                                    padding: EdgeInsets.zero,
                                    textStyle: TextStyle(color: AppTextStyles.headline1().color),
                                    showFlagMain: true,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      hintText: 'number_hint'.tr,
                                      isShowBorder: true,
                                      controller: _phoneNumberController,
                                      inputType: TextInputType.phone,
                                      inputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 24),
                              RenderConditional(
                                conditional: true, //   !auth.isForgotPasswordLoading,
                                widget1: CustomButton(btnTxt: 'send'.tr, onTap: () {}),
                                widget2: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget2: Padding(
                          padding: const EdgeInsets.all(AppDimens.paddingLarge),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 80),
                              Text('email'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                              SizedBox(height: AppDimens.paddingSmall),
                              CustomTextField(
                                hintText: 'demo_gmail'.tr,
                                isShowBorder: true,
                                controller: _emailController,
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.done,
                              ),
                              SizedBox(height: 24),
                              Obx(
                                () => RenderConditional(
                                  conditional: !widget.viewModel.forgot.running.value, //  !auth.isForgotPasswordLoading
                                  widget1: CustomButton(
                                    btnTxt: 'send'.tr,
                                    onTap: _sendResetCode,
                                  ),
                                  widget2: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                    ),
                                  ),
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

  Future<void> _sendResetCode() async {
    final command = widget.viewModel.forgot;
    final email = _emailController.text.trim();
    await command.execute(email);

    if (!mounted) return;

    switch (command.result.value) {
      case Ok<void>():
        Get.toNamed(
          AppRoutes.verify,
          arguments: {'emailAddress': email, 'fromSignUp': false},
        );
      case Error<void>(:final error):
        showCustomSnackBar(ErrorMessages.of(error).tr, context);
      case null:
        break;
    }
  }
}
