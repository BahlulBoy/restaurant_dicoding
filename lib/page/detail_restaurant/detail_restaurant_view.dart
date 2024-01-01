import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/constants/api_const.dart';
import 'package:restaurant_dicoding/page/detail_restaurant/detail_restaurant_provider.dart';
import 'package:restaurant_dicoding/page/home/helpers/screen_state_condition.dart';

class DetailRestaurantView extends StatelessWidget {
  const DetailRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String id = arguments['id'] as String;
    final String pictureId = arguments['pic'] as String;
    return ChangeNotifierProvider(
      create: (context) => DetailRestaurantProvider(id),
      builder: (context, child) => _DetailRestaurantView(id, pictureId),
    );
  }
}

class _DetailRestaurantView extends StatelessWidget {
  const _DetailRestaurantView(this.id, this.pictureId);

  final String id, pictureId;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DetailRestaurantProvider>().state;
    // final String id = arguments['id'] as String;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 220,
                  floating: true,
                  snap: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: state.screenState == ScreenStateCondition.error
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: id,
                      child: Image.network(
                        ApiConst.largePic(pictureId),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/image_error.png',
                          fit: BoxFit.cover,
                        ),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: state.screenState == ScreenStateCondition.success
                ? SingleChildScrollView(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -5,
                          child: Container(
                            height: 12,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          clipBehavior: Clip.none,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 18,
                                  ),
                                  child: Text(
                                    state.data?.name ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 8),
                                        child: Text(
                                          '${state.data?.rating ?? 0.0}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        size: 18,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 8),
                                        child: Text(
                                          state.data?.city ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  state.data?.description ?? '',
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 6,
                                  ),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'Foods:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        state.data?.menus?.foods?[index].name ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 4),
                                  itemCount:
                                      state.data?.menus?.foods?.length ?? 0,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 6,
                                  ),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'Drinks:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        state.data?.menus?.drinks?[index]
                                                .name ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 4),
                                  itemCount:
                                      state.data?.menus?.drinks?.length ?? 0,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 6,
                                  ),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    'Review:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : state.screenState == ScreenStateCondition.error
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            state.messageError ?? 'Unknow problem',
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
          ),
        ),
      ),
    );
  }
}
