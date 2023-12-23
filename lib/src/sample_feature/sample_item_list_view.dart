import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [
      SampleItem("1"),
      SampleItem("2"),
    ],
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agri Pulse'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: StoreConnector<List<SampleItem>, _ViewModel>(
            converter: (store) => _ViewModel.fromStore(store),
            builder: (context, vm) {
              return ListView.builder(
                // Providing a restorationId allows the ListView to restore the
                // scroll position when a user leaves and returns to the app after it
                // has been killed while running in the background.
                restorationId: 'sampleItemListView',
                itemCount: vm.items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = vm.items[index];

                  return ListTile(
                      title: Text('SampleItem ${item.id}'),
                      leading: const CircleAvatar(
                        // Display the Flutter Logo image asset.
                        foregroundImage:
                            AssetImage('assets/images/flutter_logo.png'),
                      ),
                      onTap: () {
                        // Navigate to the details page. If the user leaves and returns to
                        // the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                          context,
                          SampleItemDetailsView.routeName,
                        );
                      });
                },
              );
            }));
  }
}

class _ViewModel {
  final List<SampleItem> items;

  _ViewModel({required this.items});

  factory _ViewModel.fromStore(Store<List<SampleItem>> store) {
    return _ViewModel(items: store.state);
  }
}
