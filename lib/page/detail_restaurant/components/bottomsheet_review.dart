import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/page/detail_restaurant/detail_restaurant_provider.dart';

class BottomsheetReview extends StatefulWidget {
  const BottomsheetReview({super.key});

  @override
  State<BottomsheetReview> createState() => _BottomsheetReviewState();
}

class _BottomsheetReviewState extends State<BottomsheetReview> {
  late TextEditingController nameCtrl;
  late TextEditingController reviewCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController();
    reviewCtrl = TextEditingController();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    reviewCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<DetailRestaurantProvider>();
    final state = context.watch<DetailRestaurantProvider>().state;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Post Review',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Name',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      isCollapsed: true,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
                    onChanged: (value) {
                      read.changeTextReview(name: value);
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: reviewCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Review',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      isCollapsed: true,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
                    minLines: 3,
                    maxLines: null,
                    onChanged: (value) {
                      read.changeTextReview(review: value);
                    },
                  ),
                  const SizedBox(height: 15),
                  Material(
                    color:
                        state.nameText.isNotEmpty && state.reviewText.isNotEmpty
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        if (state.nameText.isNotEmpty &&
                            state.reviewText.isNotEmpty) {
                          Navigator.pop(context, {
                            'name': nameCtrl.text,
                            'review': reviewCtrl.text,
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Post',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
