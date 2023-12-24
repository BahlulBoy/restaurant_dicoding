import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/models/restaurant_model.dart';

class DetailRestaurantView extends StatelessWidget {
  const DetailRestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    final Restaurant data =
        ModalRoute.of(context)!.settings.arguments as Restaurant;
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: data.pictureId ?? '',
                      child: Image.network(
                        data.pictureId ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
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
                          )),
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
                              data.name ?? '',
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
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 8),
                                  child: Text(
                                    '${data.rating ?? 0.0}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 8),
                                  child: Text(
                                    data.city ?? '',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            data.description ?? '',
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
                              return Text(
                                '- ${data.menus?.foods?[index].name ?? ''}',
                                style: Theme.of(context).textTheme.labelSmall,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 4),
                            itemCount: data.menus?.foods?.length ?? 0,
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
                              return Text(
                                '- ${data.menus?.drinks?[index].name ?? ''}',
                                style: Theme.of(context).textTheme.labelSmall,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 4),
                            itemCount: data.menus?.foods?.length ?? 0,
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
    );
  }
}
