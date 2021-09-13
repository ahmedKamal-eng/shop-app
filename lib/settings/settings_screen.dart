import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/component.dart';
import 'package:shop_app/shop_app/cubit.dart';
import 'package:shop_app/shop_app/states.dart';
import 'package:shop_app/constant.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    nameController.text = cubit.shopLoginModel.data.name;
    emailController.text = cubit.shopLoginModel.data.email;
    phoneController.text = cubit.shopLoginModel.data.phone;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'name',
                      prefix: Icons.person),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      label: "email",
                      prefix: Icons.email),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: "phone",
                      prefix: Icons.phone),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'logOut'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (formKey.currentState.validate()) {
                          ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      text: 'Update'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
