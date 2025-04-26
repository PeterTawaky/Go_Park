import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
import 'package:smart_garage_final_project/login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FormInput formInput = FormInput();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: context.blockWidth * 8,
                end: context.blockWidth * 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    highlightColor: ColorsManager.authScreenGrey,
                    icon: Icon(
                      size: 40.sp,
                      Icons.arrow_back_ios_new,
                      color: ColorsManager.white,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),

                  SizedBox(height: context.blockHeight * 1),
                  Text(
                    AppStrings.letsCreateYourAccount,
                    style: TextStyles.font25BoldWhite,
                  ),
                  Center(
                    child: ClipOval(
                      child: Image.asset(
                        Assets
                            .imagesNnnRemovebgPreview, // Change to your image path
                        width: 150.w, // Adjust size
                        height: 150.w,
                        fit: BoxFit.cover, // Ensures the image fills the oval
                      ),
                    ),
                  ),
                  Provider.value(
                    value: formInput,
                    child: FieldsSectionCreateAccountScreen(),
                  ),

                  SizedBox(height: context.blockHeight * 0.5),

                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state is AuthenticationSuccess) {
                        HelperFunctions.showSnackBar(
                          context: context,
                          msg: state.message!,
                        );
                        context.pushNamed(AppRoutes.loginScreen);
                      } else if (state is AuthenticationError) {
                        if (state.errorMessage != null) {
                          HelperFunctions.showSnackBar(
                            context: context,
                            msg: state.errorMessage!,
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
                            AppStrings.createAccount,
                            style: TextStyles.font14BoldWhite,
                          ),
                          backgroundColor: ColorsManager.authScreenPurple,
                          outlineColor: ColorsManager.authScreenPurple,
                          onPressed: () {
                            if (formInput.validateKey.currentState!
                                .validate()) {
                              context
                                  .read<AuthenticationCubit>()
                                  .createNewAccount(
                                    email: formInput.emailController.text,
                                    password: formInput.passwordController.text,
                                  );
                            }
                          },
                        );
                      }
                    },
                  ),

                  SizedBox(height: context.blockHeight * 4),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
        ),
      ),
    );
  }
}

class FieldsSectionCreateAccountScreen extends StatelessWidget {
  const FieldsSectionCreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<FormInput>().validateKey,
      child: Column(
        children: [
          CustomTFF(
            validator: (value) => AppValidator.validateName(value),
            controller: context.read<FormInput>().nickNameController,
            hintText: AppStrings.nickName,
            prefixIcon: CupertinoIcons.person_fill,
          ),
          SizedBox(height: context.blockHeight * 1),

          CustomTFF(
            validator: (value) => AppValidator.validateEmailCreation(value),
            controller: context.read<FormInput>().emailController,
            hintText: AppStrings.email,
            prefixIcon: CupertinoIcons.person_fill,
          ),
          SizedBox(height: context.blockHeight * 1),
          CustomTFF(
            validator: (value) => AppValidator.validatePasswordCreation(value),
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
