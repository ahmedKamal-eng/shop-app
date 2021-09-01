import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user/shop_app/home_model.dart';
import 'package:shop_app/shop_app/cubit.dart';
import 'package:shop_app/shop_app/states.dart';
import 'package:shop_app/styles/colors.dart';

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

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                children: List.generate(model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index])),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(model.image),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                )
            ]),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, height: 1.3),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(fontSize: 12, color: defaultColor),
                ),
                SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice.round()}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.favorite_border_outlined),
                    onPressed: () {})
              ],
            ),
          ],
        ),
      );
}
