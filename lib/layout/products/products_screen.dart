import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user/shop_app/home_model.dart';
import 'package:shop_app/shop_app/cubit.dart';
import 'package:shop_app/shop_app/states.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          builder: (context) =>
              productsBuilder(ShopCubit.get(context).homeModel),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => Column(
        children: [
          CarouselSlider(
            items: model.data.banners
                .map(
                  //this will return a list of image
                  (e) => Image(
                    image: NetworkImage(e.image),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1.0, //make the image take all available view
              enlargeCenterPage: false,
              initialPage: 0, //to start from the first item in list
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval:
                  Duration(seconds: 3), // the image stay this duration
              autoPlayAnimationDuration:
                  Duration(seconds: 1), //the animation take this duration
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );
}
