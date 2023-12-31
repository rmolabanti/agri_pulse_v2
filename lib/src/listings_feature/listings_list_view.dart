import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../settings/settings_view.dart';
import 'listing.dart';
import 'listing_details_view.dart';

/// Displays a list of SampleItems.
class ListingsListView extends StatelessWidget {
  const ListingsListView({
    super.key,
    this.items = const [
      Listing("1"),
      Listing("2"),
    ],
  });

  static const routeName = '/';

  final List<Listing> items;

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
        body: StoreConnector<List<Listing>, _ViewModel>(
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
                      title: Text(item.id),
                      leading: CircleAvatar(
                        // Display the first character of the text as the
                        // background image.
                        backgroundColor:
                            Colors.primaries[index % Colors.primaries.length],
                        // Display the first character of the text as the
                        // background image.
                        child: Text(item.id[0],
                            style: const TextStyle(color: Colors.white)),
                      ),
                      onTap: () {
                        // Navigate to the details page. If the user leaves and returns to
                        // the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                          context,
                          ListingDetailsView.routeName,
                        );
                      });
                },
              );
            }));
  }
}

class _ViewModel {
  final List<Listing> items;

  _ViewModel({required this.items});

  factory _ViewModel.fromStore(Store<List<Listing>> store) {
    return _ViewModel(items: store.state);
  }
}
