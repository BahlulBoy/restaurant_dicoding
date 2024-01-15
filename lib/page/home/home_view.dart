import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_dicoding/models/list_restaurant_model.dart';
import 'package:restaurant_dicoding/navigation/my_paths.dart';
import 'package:restaurant_dicoding/page/home/components/grid_item_card.dart';
import 'package:restaurant_dicoding/page/home/components/list_item_card.dart';
import 'package:restaurant_dicoding/helpers/screen_state_condition.dart';
import 'package:restaurant_dicoding/page/home/home_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: HomeProvider.new,
      builder: (context, child) => const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>().state;
    final read = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: state.isSearchShow
                  ? TextFormField(
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
                      onChanged: (value) async {
                        await read.getListRestaurantSearch(value);
                      },
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  : _title(
                      data: [],
                      context: context,
                    ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              read.showSearch();
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                state.isSearchShow ? Icons.close : Icons.search,
              ),
            ),
          ),
          if (!state.isSearchShow) ...[
            InkWell(
              onTap: () {
                read.isGridChanger();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  state.isGrid ? Icons.grid_view_outlined : Icons.list_alt,
                ),
              ),
            ),
            PopupMenuButton(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.settings,
                ),
              ),
              onSelected: (value) {
                read.onClickPopupMenu(context, value);
              },
              itemBuilder: (context) {
                return {'Favorite', 'Setting'}.map(
                  (e) {
                    return PopupMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    );
                  },
                ).toList();
              },
            ),
          ],
          const SizedBox(width: 10),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (state.screenState == ScreenStateCondition.success) ...[
              if (state.isSearchShow)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Text(
                    'restaurant found ${state.listRestaurantShow.length}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              Expanded(
                child: state.screenState == ScreenStateCondition.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _body(state.isGrid, state.listRestaurantShow),
              ),
            ],
            if (state.screenState == ScreenStateCondition.loading) ...[
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
            if (state.screenState == ScreenStateCondition.error) ...[
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      state.errorMessage ?? 'Unknow problem',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _title({
    required List<Restaurant> data,
    required BuildContext context,
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

  Widget _body(bool isGridView, List<Restaurant> data) {
    if (isGridView && data.isNotEmpty) {
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
                    Navigator.pushNamed(context, MyPaths.detail, arguments: {
                      'id': data[index].id,
                      'pic': data[index].pictureId,
                    });
                  },
                  child: GridItemCard(data: data[index]),
                ),
                childCount: data.length,
              ),
            ),
          ],
        ),
      );
    } else if (!isGridView && data.isNotEmpty) {
      return ListView.separated(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(context, MyPaths.detail, arguments: {
              'id': data[index].id,
              'pic': data[index].pictureId,
            });
          },
          child: ListItemCard(data: data[index]),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        padding: const EdgeInsets.only(
          top: 3,
          left: 8,
          right: 8,
        ),
        itemCount: data.length,
      );
    } else {
      return const Center(
        child: Text('Data not found'),
      );
    }
  }
}
