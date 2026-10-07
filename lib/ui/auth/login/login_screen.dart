import 'package:efood/routing/app_routes.dart';
import 'package:efood/ui/auth/login/login_viewmodel.dart';
import 'package:efood/ui/core/share/app_assets.dart';
import 'package:efood/ui/core/share/custom_button.dart';
import 'package:efood/ui/core/share/custom_text_field.dart';
import 'package:efood/ui/core/share/render_command_error.dart';
import 'package:efood/ui/core/share/render_conditional.dart';
import 'package:efood/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class const LoginScreen({super.key, required final LoginViewModel viewModel}) extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _emailNumberFocus = FocusNode();

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(text: "leandro@gmail.com");
  final TextEditingController _passwordController = TextEditingController(text: "12345678");

  Worker? _loginWorker;
  bool _redirected = false;

  @override
  void initState() {
    super.initState();

    _loginWorker = ever(widget.viewModel.login.result, (_) => _onLoginResult());

    _onLoginResult();
  }

  void _onLoginResult() {
    final command = widget.viewModel.login;

    if (!mounted || !command.complete || _redirected) return;

    _redirected = true;

    _loginWorker?.dispose();

    Get.offAllNamed(AppRoutes.main);
  }

  @override
  void dispose() {
    _loginWorker?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailNumberFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
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
                          boxShadow: [BoxShadow(color: AppColors.grey, blurRadius: 5, spreadRadius: 1)],
                        )
                      : null,
                  child: Form(
                    key: _formKeyLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset(
                              AppAssets.images.logo,
                              height: MediaQuery.of(context).size.height / 4.5,
                              fit: BoxFit.scaleDown,
                              matchTextDirection: true,
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            'login'.tr,
                            style: AppTextStyles.headline3(color: AppColors.greyBunkerDark).copyWith(fontSize: 24),
                          ),
                        ),
                        SizedBox(height: 35),

                        RenderConditional(
                          conditional: widget.viewModel.config?.emailVerification,
                          widget1: Text('email'.tr, style: AppTextStyles.headline2(color: AppColors.hintDark)),
                          widget2: Text('mobile_number'.tr, style: AppTextStyles.headline2(color: AppColors.hintDark)),
                        ),

                        SizedBox(height: AppDimens.paddingSmall),

                        RenderConditional(
                          conditional: widget.viewModel.config?.emailVerification,
                          widget1: CustomTextField(
                            hintText: 'demo_gmail'.tr,
                            isShowBorder: true,
                            focusNode: _emailNumberFocus,
                            nextFocus: _passwordFocus,
                            controller: _emailController,
                            inputType: TextInputType.emailAddress,
                          ),
                          widget2: SizedBox(),
                        ),

                        SizedBox(height: AppDimens.paddingLarge),
                        Text('password'.tr, style: AppTextStyles.headline2(color: AppColors.hintDark)),
                        SizedBox(height: AppDimens.paddingDefault),
                        CustomTextField(
                          hintText: 'password_hint'.tr,
                          isShowBorder: true,
                          isPassword: true,
                          isShowSuffixIcon: true,
                          focusNode: _passwordFocus,
                          controller: _passwordController,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 22),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => widget.viewModel.toggleRememberMe(),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: widget.viewModel.isActiveRememberMe
                                            ? Theme.of(context).primaryColor
                                            : AppColors.white,
                                        border: Border.all(
                                          color: widget.viewModel.isActiveRememberMe
                                              ? Colors.transparent
                                              : Theme.of(context).primaryColor,
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: widget.viewModel.isActiveRememberMe
                                          ? Icon(Icons.done, color: AppColors.white, size: 17)
                                          : SizedBox.shrink(),
                                    ),
                                  ),
                                  SizedBox(width: AppDimens.paddingSmall),
                                  Text(
                                    'remember_me'.tr,
                                    style: AppTextStyles.headline2().copyWith(
                                      fontSize: AppDimens.fontSizeExtraSmall,
                                      color: AppColors.hintDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                // Navigator.pushNamed(context, Routes.getForgetPassRoute());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'forgot_password'.tr,
                                  style: AppTextStyles.headline2().copyWith(
                                    fontSize: AppDimens.fontSizeSmall,
                                    color: AppColors.hintDark,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 22),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => RenderConditional(
                                conditional: widget.viewModel.login.error,
                                widget1: CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5),
                                widget2: SizedBox.shrink(),
                              ),
                            ),

                            SizedBox(width: 8),
                            Expanded(
                              child: RenderCommandError(
                                command: widget.viewModel.login.result,
                                widget: (text) => Text(
                                  text,
                                  style: AppTextStyles.headline2().copyWith(
                                    fontSize: AppDimens.fontSizeSmall,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // for login button
                        SizedBox(height: 10),

                        Obx(
                          () => RenderConditional(
                            conditional: !widget.viewModel.login.running.value,
                            widget1: CustomButton(
                              btnTxt: 'login'.tr,
                              onTap: () async {
                                final arguments = (_emailController.text.trim(), _passwordController.text.trim());

                                widget.viewModel.login.execute(arguments);
                              },
                            ),
                            widget2: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),

                        // for create an account
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            // Navigator.pushNamed(context, Routes.getSignUpRoute());
                          },
                          child: Padding(
                            padding: .all(AppDimens.paddingSmall),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'create_an_account'.tr,
                                  style: AppTextStyles.headline2().copyWith(
                                    fontSize: AppDimens.fontSizeSmall,
                                    color: AppColors.greyDark,
                                  ),
                                ),
                                SizedBox(width: AppDimens.fontSizeSmall),
                                Text(
                                  'signup'.tr,
                                  style: AppTextStyles.headline3().copyWith(
                                    fontSize: AppDimens.fontSizeSmall,
                                    color: AppColors.greyBunkerDark,
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
