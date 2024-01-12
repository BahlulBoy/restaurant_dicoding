import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/page/favorite_restaurant/favorite_restaurant_provider.dart';
import 'package:restaurant_dicoding/page/home/components/list_item_card.dart';

class FavoriteRestaurantView extends StatelessWidget {
  const FavoriteRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteRestaurantProvider(),
      builder: (context, child) => const _FavoriteRestaurantView(),
    );
  }
}

class _FavoriteRestaurantView extends StatelessWidget {
  const _FavoriteRestaurantView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FavoriteRestaurantProvider>().state;
    final read = context.read<FavoriteRestaurantProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final data = state.data[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, MyPaths.detail, arguments: {
                  'id': data.id,
                  'pic': data.pictureId,
                }).then((value) => read.getFavoriteRestaurantList());
              },
              child: ListItemCard(data: data),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          padding: const EdgeInsets.only(
            top: 3,
            left: 8,
            right: 8,
          ),
          itemCount: state.data.length,
        ),
      ),
    );
  }
}
