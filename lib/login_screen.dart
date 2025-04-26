import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smart_garage_final_project/components/customized_chckbox.dart';
import 'package:smart_garage_final_project/core/routes/app_routes.dart';
import 'package:smart_garage_final_project/core/utils/app_assets.dart';
import 'package:smart_garage_final_project/core/utils/app_strings.dart';
import 'package:smart_garage_final_project/core/utils/app_validator.dart';
import 'package:smart_garage_final_project/core/utils/helper/helper_functions.dart';
import 'package:smart_garage_final_project/core/utils/size_config.dart';
import 'package:smart_garage_final_project/core/utils/theme/colors_manager.dart';
import 'package:smart_garage_final_project/core/utils/theme/text_styles.dart';
import 'package:smart_garage_final_project/firebase/firebase_auth_consumer.dart';
import 'package:smart_garage_final_project/logic/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:smart_garage_final_project/logic/provider/form_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    FormInput formInput = FormInput();
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          buildWhen: (previous, current) => current is GoogleSignInLoading || current is GoogleSignInSuccess,
          listener: (context, state) {
            if (state is GoogleSignInSuccess) {
              context.pushReplacementNamed(AppRoutes.goParkScreen);
            }
          },
          builder: (context, state) {

            if (state is GoogleSignInLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: context.blockHeight * 20,
                    width: context.blockWidth * 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.imagesHtiLogo),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: context.blockWidth * 8,
                      end: context.blockWidth * 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomeBack,
                          style: TextStyles.font25BoldWhite,
                        ),
                        Text(
                          AppStrings.enterUserNameAndPassword,
                          style: TextStyles.font14regularWhite,
                        ),
                        SizedBox(height: context.blockHeight * 3),

                        Provider.value(
                          value: formInput,
                          child: FieldsSectionLoginScreen(),
                        ),
                        SizedBox(height: context.blockHeight * 0.5),
                        Row(
                          children: [
                            CustomizedCheckbox(isChecked: false),
                            Text(
                              AppStrings.rememberMe,
                              style: TextStyles.font12regularGrey,
                            ),
                            Spacer(),
                            BlocConsumer<
                              AuthenticationCubit,
                              AuthenticationState
                            >(
                              buildWhen:
                                  (previous, current) =>
                                      current is ResetPasswordMailSentLoading ||
                                      current is ResetPasswordMailSentSuccess ||
                                      current is ResetPasswordMailSentFailed,
                              listener: (context, state) {
                                if (state is ResetPasswordMailSentSuccess) {
                                  HelperFunctions.showSnackBar(
                                    msg: state.message!,
                                    context: context,
                                  );
                                }
                                if (state is ResetPasswordMailSentFailed) {
                                  HelperFunctions.showSnackBar(
                                    msg: state.errorMessage!,
                                    context: context,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is ResetPasswordMailSentLoading) {
                                  return CircularProgressIndicator(
                                    color: ColorsManager.authScreenPurple,
                                  );
                                } else {
                                  return TextButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthenticationCubit>(
                                        context,
                                      ).sendResetPasswordMail(
                                        email: formInput.emailController.text,
                                        // context: context,
                                      );
                                    },
                                    child: Text(
                                      AppStrings.forgetPassword,
                                      style: TextStyles.font12regularPurple,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: context.blockHeight * 5),

                        BlocConsumer<AuthenticationCubit, AuthenticationState>(
                          buildWhen:
                              (previous, current) =>
                                  current is AuthenticationLoading ||
                                  current is AuthenticationError ||
                                  current is AuthenticationSuccess,

                          listener: (context, state) {
                            if (state is AuthenticationSuccess) {
                              if (FirebaseAuthConsumer.isUserAuthorized()) {
                                context.pushReplacementNamed(
                                  AppRoutes.goParkScreen,
                                );
                              } else {
                                HelperFunctions.showSnackBar(
                                  msg: state.message!,
                                  context: context,
                                );
                              }
                            } else if (state is AuthenticationError) {
                              if (state.errorMessage != null) {
                                HelperFunctions.showSnackBar(
                                  msg: state.errorMessage!,
                                  context: context,
                                );
                              }
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthenticationLoading) {
                              return CustomButtonForAction(
                                centerWidget: CircularProgressIndicator(
                                  color: ColorsManager.white,
                                ),
                                backgroundColor: ColorsManager.authScreenPurple,
                                outlineColor: ColorsManager.authScreenPurple,
                              );
                            } else {
                              return CustomButtonForAction(
                                centerWidget: Text(
                                  AppStrings.signIn,
                                  style: TextStyles.font14BoldWhite,
                                ),
                                backgroundColor: ColorsManager.authScreenPurple,
                                outlineColor: ColorsManager.authScreenPurple,
                                onPressed: () {
                                  if (formInput.validateKey.currentState!
                                      .validate()) {
                                    context
                                        .read<AuthenticationCubit>()
                                        .signInWithEmailAndPassword(
                                          email: formInput.emailController.text,
                                          password:
                                              formInput.passwordController.text,
                                        );
                                  }
                                },
                              );
                            }
                          },
                        ),
                        SizedBox(height: context.blockHeight * 1),
                        CustomButtonForAction(
                          centerWidget: Text(
                            AppStrings.createAccount,
                            style: TextStyles.font14BoldWhite,
                          ),
                          backgroundColor: Colors.transparent,
                          outlineColor: ColorsManager.white,
                          onPressed: () {
                            context.pushNamed(AppRoutes.createAccountScreen);
                          },
                        ),
                        SizedBox(height: context.blockHeight * 4),

                        Row(
                          children: [
                            Expanded(
                              child: Divider(thickness: 1, color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Text(
                                AppStrings.orSignInWith,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(thickness: 1, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.blockHeight * 4),
                  Row(
                    children: [
                      Spacer(),
                      CustomSocialIcon(
                        image: Assets.imagesGoogle,
                        onTap:
                            () =>
                                BlocProvider.of<AuthenticationCubit>(
                                  context,
                                ).signInWithGoogle(),
                      ),
                      SizedBox(width: 20.w),
                      CustomSocialIcon(
                        image: Assets.imagesFacebookCircle,
                        onTap: () {},
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class FieldsSectionLoginScreen extends StatelessWidget {
  FieldsSectionLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<FormInput>().validateKey,
      child: Column(
        children: [
          CustomTFF(
            validator:
                (value) => AppValidator.validateEmailCreation(
                  value,
                ), // Pass the current value
            // validator: AppValidator.validateEmail(
            //   context.read<FormInput>().emailController.text,
            // ),
            controller:
                context
                    .read<FormInput>()
                    .emailController, // a value in the FormInput
            hintText: AppStrings.email,
            prefixIcon: CupertinoIcons.person_fill,
          ),
          SizedBox(height: context.blockHeight * 1),
          CustomTFF(
            validator: (value) => AppValidator.validatePasswordSignIn(value),
            controller: context.read<FormInput>().passwordController,
            hintText: AppStrings.password,
            prefixIcon: Icons.lock,
            suffixIcon: Icons.remove_red_eye,
          ),
        ],
      ),
    );
  }
}

class CustomSocialIcon extends StatelessWidget {
  final void Function()? onTap;
  final String image;
  const CustomSocialIcon({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: context.blockHeight * 6,
            width: context.blockHeight * 6,
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(200.r),
            ),
          ),
          Container(
            height: context.blockHeight * 5.7,
            width: context.blockHeight * 5.7,
            decoration: BoxDecoration(
              color: ColorsManager.authScreenBlack,
              borderRadius: BorderRadius.circular(200.r),
            ),
          ),
          Container(
            height: context.blockHeight * 3,
            width: context.blockHeight * 3,
            decoration: BoxDecoration(
              color: ColorsManager.authScreenBlack,
              borderRadius: BorderRadius.circular(200.r),
              image: DecorationImage(image: AssetImage(image)),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButtonForAction extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget centerWidget;
  final Color outlineColor;
  final Color backgroundColor;
  const CustomButtonForAction({
    super.key,
    required this.outlineColor,
    required this.backgroundColor,
    this.onPressed,
    required this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            8.r,
          ), // Adjust radius value for more or less rounding
        ),
        minimumSize: Size(
          double.infinity,
          50.h,
        ), // Sets minimum width and height
        backgroundColor: backgroundColor,
        side: BorderSide(color: outlineColor),
      ),
      onPressed: onPressed,
      child: centerWidget,
    );
  }
}

class CustomTFF extends StatelessWidget {
  final String? hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  CustomTFF({
    super.key,
    required this.prefixIcon,
    this.hintText,
    this.suffixIcon,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      onChanged: (value) {
        double _passwordStrength = AppValidator.calculatePasswordStrength(
          value,
        );
        log(_passwordStrength.toString());
      },
      decoration: InputDecoration(
        errorMaxLines: 3,
        contentPadding: EdgeInsetsDirectional.symmetric(vertical: 16.h),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        prefixIcon: Icon(prefixIcon, color: ColorsManager.white),
        suffixIcon: Icon(suffixIcon, color: ColorsManager.white),
        hintText: hintText,
        hintStyle: TextStyles.font14regularWhite,
      ),
    );
  }
}
