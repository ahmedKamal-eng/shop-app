import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/register/cubit/cubit.dart';
import 'package:shop_app/register/cubit/states.dart';
import 'package:shop_app/shop_app/shop_layout.dart';

import '../component.dart';
import '../constant.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
            if (state is ShopRegisterSuccessState) {
              if (state.loginModel.status) {
                showToast(
                    message: state.loginModel.message,
                    color: Colors.green[300],
                    context: context);

                CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data.token,
                ).then((value) {
                  token = state.loginModel.data.token;
                  navigateAndFinish(
                    context,
                    ShopLayout(),
                  );
                });
              } else {
                showToast(
                    message: state.loginModel.message,
                    color: Colors.red[300],
                    context: context);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'register now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter your name";
                                }
                              },
                              label: "name",
                              prefix: Icons.person),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter your email";
                                }
                              },
                              label: "email address",
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopRegisterCubit.get(context).suffix,
                              onSubmit: (value) {
                                if (formKey.currentState.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text);
                                }
                              },
                              isPassword:
                                  ShopRegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changeIconVisibility();
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "password is too short";
                                }
                              },
                              label: "password",
                              prefix: Icons.lock_outline),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.number,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "please enter your phone";
                                }
                              },
                              label: "phone",
                              prefix: Icons.phone),
                          SizedBox(
                            height: 15,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                                text: 'Register',
                                isUpperCase: true),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
