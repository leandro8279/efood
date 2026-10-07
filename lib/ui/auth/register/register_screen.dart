import 'package:country_code_picker/country_code_picker.dart';
import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/core/share/code_picker_widget.dart';
import 'package:efood/ui/core/share/custom_button.dart';
import 'package:efood/ui/core/share/custom_text_field.dart';
import 'package:efood/ui/core/share/render_conditional.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const new({super.key});

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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  late String _countryDialCode;

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
                        conditional: true, //.configModel.emailVerification
                        widget1: CustomTextField(
                          hintText: 'Doe',
                          isShowBorder: true,
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          nextFocus: _numberFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                        ),
                        widget2: CustomTextField(
                          hintText: 'Doe',
                          isShowBorder: true,
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          nextFocus: _emailFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                        ),
                      ),

                      SizedBox(height: AppDimens.paddingLarge),
                      RenderConditional(
                        conditional: true, // configModel.emailVerification
                        widget1: Text('email'.tr, style: AppTextStyles.headline2(color: AppColors.getHintColor())),
                        widget2: Text(
                          'mobile_number'.tr,
                          style: AppTextStyles.headline2(color: AppColors.getHintColor()),
                        ),
                      ),
                      SizedBox(height: AppDimens.paddingSmall),

                      RenderConditional(
                        conditional: true, //// configModel.emailVerification
                        widget1: CustomTextField(
                          hintText: 'demo_gmail'.tr,
                          isShowBorder: true,
                          controller: _emailController,
                          focusNode: _emailFocus,
                          nextFocus: _passwordFocus,
                          inputType: TextInputType.emailAddress,
                        ),
                        widget2: Row(
                          children: [
                            CodePickerWidget(
                              onChanged: (CountryCode countryCode) {
                                _countryDialCode = countryCode.dialCode!;
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
                                nextFocus: _passwordFocus,
                                inputType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RenderConditional(
                            conditional: true, // authProvider.registrationErrorMessage.length > 0
                            widget1: CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5),
                            widget2: SizedBox.shrink(),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "authProvider.registrationErrorMessage",
                              style: AppTextStyles.headline2(
                                fontSize: AppDimens.fontSizeSmall,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // for signup button
                      SizedBox(height: 10),

                      RenderConditional(
                        conditional: false, //!authProvider.isLoading
                        widget1: CustomButton(btnTxt: 'signup'.tr, onTap: () {}),
                        widget2: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                          ),
                        ),
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
}
