import 'package:efood/ui/auth/verification/verification_viewmodel.dart';
import 'package:efood/ui/core/share/share.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:efood/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class const VerificationScreen({
  super.key,
  required final VerificationViewModel viewModel,
  this.emailAddress = '',
  this.fromSignUp = false,
}) extends StatefulWidget {
  final String emailAddress;
  final bool fromSignUp;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: widget.viewModel.phoneVerification ? 'verify_phone'.tr : 'verify_email'.tr,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: SizedBox(
                width: 1170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 55),
                    RenderConditional(
                      conditional: widget.viewModel.emailVerification,
                      widget1: Image.asset(AppAssets.icons.emailWithBackground, width: 142, height: 142),
                      widget2: Icon(Icons.phone_android_outlined, size: 50, color: Theme.of(context).primaryColor),
                    ),

                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Center(
                        child: Text(
                          '${'please_enter_4_digit_code'.tr}\n ${widget.emailAddress}',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.headline2(color: AppColors.getHintColor()),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                      child: MaterialPinField(
                        length: 4,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        // animationType: AnimationType.fade,
                        theme: MaterialPinTheme(
                          shape: MaterialPinShape.circle,
                          // fieldHeight: 63,
                          // fieldWidth: 55,
                          animationDuration: Duration(milliseconds: 300),
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(10),
                          // selectedColor: AppColors.swatch[200],
                          // selectedFillColor: Colors.white,
                          // inactiveFillColor: AppColors.getSearchBg(),
                          // inactiveColor: AppColors.swatch[200],
                          // activeColor: AppColors.swatch[400],
                          // activeFillColor: AppColors.getSearchBg(),
                        ),
                        // backgroundColor: Colors.transparent,
                        // enableActiveFill: true,
                        onChanged: (value) =>
                            widget.viewModel.updateVerificationCode(value ?? ''),
                        // beforeTextPaste: (text) => true,
                      ),
                    ),
                    Center(
                      child: Text(
                        'i_didnt_receive_the_code'.tr,
                        style: AppTextStyles.headline2(color: AppColors.getGreyBunkerColor()),
                      ),
                    ),

                    Obx(
                      () => Center(
                        child: InkWell(
                          onTap: widget.viewModel.resendCode.running.value
                              ? null
                              : _resendCode,
                          child: Padding(
                            padding: EdgeInsets.all(AppDimens.paddingExtraSmall),
                            child: Text(
                              'resend_code'.tr,
                              style: AppTextStyles.headline3(color: AppColors.getGreyBunkerColor()),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 48),

                    Obx(
                      () => RenderConditional(
                        conditional: widget.viewModel.isEnableVerificationCode,
                        widget1: RenderConditional(
                          conditional: !widget.viewModel.verifyCode.running.value,
                          widget1: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLarge),
                            child: CustomButton(btnTxt: 'verify'.tr, onTap: _verifyCode),
                          ),
                          widget2: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        widget2: SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _resendCode() async {
    final command = widget.viewModel.resendCode;
    await command.execute((widget.emailAddress, widget.fromSignUp));

    if (!mounted) return;

    switch (command.result.value) {
      case Ok<void>():
        showCustomSnackBar(
          'resent_code_successful'.tr,
          context,
          isError: false,
        );
      case Error<void>(:final error):
        showCustomSnackBar(ErrorMessages.of(error).tr, context);
      case null:
        break;
    }
  }

  Future<void> _verifyCode() async {
    final trimmedContact = widget.emailAddress.trim();
    final contact = widget.viewModel.phoneVerification
        ? trimmedContact.startsWith('+')
              ? trimmedContact
              : '+$trimmedContact'
        : trimmedContact;

    if (!widget.fromSignUp) {
      print('Password reset OTP validation is not implemented yet.');
      return;
    }

    final command = widget.viewModel.verifyCode;
    await command.execute((contact, widget.viewModel.verificationCode));

    if (!mounted) return;

    switch (command.result.value) {
      case Ok<void>():
        print('Would navigate to the create-account screen.');
      case Error<void>(:final error):
        showCustomSnackBar(ErrorMessages.of(error).tr, context);
      case null:
        break;
    }
  }
}
