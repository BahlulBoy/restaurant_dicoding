import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/constants/api_const.dart';
import 'package:restaurant_dicoding/models/list_restaurant_model.dart';

class GridItemCard extends StatelessWidget {
  const GridItemCard({
    required this.data,
    super.key,
  });

  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Hero(
                  tag: data.id ?? '',
                  child: Image.network(
                    ApiConst.mediumPic(data.pictureId ?? ''),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
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
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.white,
                    ),
                    Text(
                      ' ${data.rating ?? 0.0}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                          ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.name ?? '-',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 8,
                    ),
                    Text(
                      data.city ?? '-',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 8,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
