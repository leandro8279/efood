import 'package:country_code_picker/country_code_picker.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/auth/signup/signup_viewmodel.dart';
import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/core/share/code_picker_widget.dart';
import 'package:efood/ui/core/share/custom_button.dart';
import 'package:efood/ui/core/share/custom_text_field.dart';
import 'package:efood/ui/core/share/render_conditional.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.viewModel});

  final SignUpViewModel viewModel;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailController;
  late TextEditingController _numberController;
  final FocusNode _numberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  late String _countryDialCode;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _numberController = TextEditingController();
    _countryDialCode = CountryCode.fromCountryCode('BR').dialCode ?? '';
    // Provider.of<AuthProvider>(context, listen: false).clearVerificationMessage();
    // _countryDialCode = CountryCode.fromCountryCode(
    //   Provider.of<SplashProvider>(context, listen: false).configModel.countryCode,
    // ).dialCode;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(AppDimens.paddingLarge),
                child: Center(
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
                        SizedBox(height: 30),
                        Center(
                          child: Padding(
                            padding: .all(15.0),
                            child: Image.asset(
                              AppAssets.images.logo,
                              matchTextDirection: true,
                              height: MediaQuery.of(context).size.height / 4.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'signup'.tr,
                            style: AppTextStyles.headline3(fontSize: 24, color: AppColors.getGreyBunkerColor()),
                          ),
                        ),
                        SizedBox(height: 35),

                        RenderConditional(
                          conditional: widget.viewModel.emailVerification,
                          widget1: Text('email'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                          widget2: Text(
                            'mobile_number'.tr,
                            style: AppTextStyles.headline2(color: AppColors.getHintColor()),
                          ),
                        ),
                        SizedBox(height: AppDimens.paddingSmall),

                        RenderConditional(
                          conditional: widget.viewModel.emailVerification,
                          widget1: CustomTextField(
                            hintText: 'demo_gmail'.tr,
                            isShowBorder: true,
                            focusNode: _emailFocus,
                            nextFocus: _numberFocus,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          widget2: Row(
                            children: [
                              CodePickerWidget(
                                onChanged: (CountryCode countryCode) {
                                  _countryDialCode = countryCode.dialCode ?? '';
                                },
                                initialSelection: _countryDialCode,
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
                                  inputType: TextInputType.phone,
                                  inputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RenderConditional(
                              conditional: true, // authProvider.verificationMessage.length > 0
                              widget1: CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5),
                              widget2: SizedBox.shrink(),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "authProvider.verificationMessage",
                                style: AppTextStyles.headline2(
                                  fontSize: AppDimens.fontSizeSmall,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // for continue button
                        SizedBox(height: 12),
                        RenderConditional(
                          conditional: true, //  !authProvider.isPhoneNumberVerificationButtonLoading
                          widget1: CustomButton(btnTxt: 'continue'.tr, onTap: () {}),
                          widget2: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                            ),
                          ),
                        ),

                        // for create an account
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.offAndToNamed(AppRoutes.login),
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
      ),
    );
  }
}
