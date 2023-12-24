import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurant_dicoding/models/restaurant_model.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/page/home/components/grid_item_card.dart';
import 'package:restaurant_dicoding/page/home/components/list_item_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isInitial = false;
  bool isGridView = false;
  bool isSearchShow = false;
  bool isLoading = true;
  late TextEditingController controller;
  List<Restaurant> listData = [];
  List<Restaurant> listDataShow = [];

  @override
  void initState() {
    super.initState();
    getDataFromJson();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void showSearch() {
    setState(() {
      isSearchShow = !isSearchShow;
      if (!isSearchShow) {
        listDataShow = listData;
      } else {
        listDataShow = [];
      }
    });
    controller.clear();
  }

  void searchItem(String search) {
    setState(() {
      if (search.isEmpty) {
        listDataShow = [];
      } else {
        listDataShow = listData
            .where(
              (element) =>
                  element.name!.toLowerCase().contains(search.toLowerCase()),
            )
            .toList();
      }
    });
  }

  Future<void> getDataFromJson() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString(
        'assets/json/local_restaurant.json',
      );
      final Map<String, dynamic> parsed = jsonDecode(data);
      setState(() {
        listData = List<Restaurant>.from(
            parsed['restaurants'].map((e) => Restaurant.fromJson(e)));
        listDataShow = List<Restaurant>.from(
            parsed['restaurants'].map((e) => Restaurant.fromJson(e)));
        isLoading = false;
      });
    } catch (e) {
      log('error extract json: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: isSearchShow
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                      ),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Search',
                          hintStyle: Theme.of(context).textTheme.titleSmall,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 11,
                            horizontal: 12,
                          ),
                        ),
                        onChanged: (value) {
                          searchItem(value);
                        },
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  : _title(data: listDataShow),
            ),
            InkWell(
              onTap: showSearch,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  isSearchShow ? Icons.close : Icons.search,
                ),
              ),
            ),
            if (!isSearchShow)
              InkWell(
                onTap: () {
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    isGridView ? Icons.grid_view_outlined : Icons.list_alt,
                  ),
                ),
              ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _body(
                isGridView,
              ),
      ),
    );
  }

  Widget _title({
    required List<Restaurant> data,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dicoding Restaurant',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Recommendation restaurant for you',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );

  Widget _body(bool isGridView) {
    if (isGridView) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MyPaths.detail,
                      arguments: listDataShow[index],
                    );
                  },
                  child: GridItemCard(data: listDataShow[index]),
                ),
                childCount: listDataShow.length,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.separated(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              MyPaths.detail,
              arguments: listDataShow[index],
            );
          },
          child: ListItemCard(data: listDataShow[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        padding: const EdgeInsets.only(
          top: 3,
          left: 8,
          right: 8,
        ),
        itemCount: listDataShow.length,
      );
    }
  }
}
