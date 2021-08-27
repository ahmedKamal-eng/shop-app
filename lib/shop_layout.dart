import 'package:flutter/material.dart';
import 'package:shop_app/component.dart';
import 'package:shop_app/login/shop_login.dart';

import 'network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'salla',
        ),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            if (value) {
              navigateAndFinish(context, ShopLoginScreen());
            }
          });
        },
        child: Text('sign out'),
      ),
    );
  }
}
