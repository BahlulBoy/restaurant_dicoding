import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    required this.name,
    required this.review,
    required this.date,
    super.key,
  });

  final String name, review, date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 8,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              review,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
