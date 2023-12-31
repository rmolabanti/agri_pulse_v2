// actions.dart
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import 'listing.dart';

enum ItemActions { fetchItems, itemsFetched, itemsFetchError }

class FetchItemsAction {}

class ItemsFetchedAction {
  final List<Listing> items;
  ItemsFetchedAction(this.items);
}

class ItemsFetchErrorAction {
  final String error;
  ItemsFetchErrorAction(this.error);
}

List<Listing> itemsReducer(List<Listing> state, action) {
  if (action is FetchItemsAction) {
    fetchItems();
  }
  if (action is ItemsFetchedAction) {
    return action.items;
  } else if (action is ItemsFetchErrorAction) {
    // Handle error (e.g., log or display to user)
    return state;
  } else {
    return state;
  }
}

final store = Store<List<Listing>>(itemsReducer, initialState: []);

Store<List<Listing>> getStore() {
  return store;
}

Future<void> fetchItems() async {
  try {
    //final response = await http.get(Uri.parse(
    //  'https://firebasestorage.googleapis.com/v0/b/agri-pulse-47594.appspot.com/o/listings.json?alt=media&token=270fea6a-8e46-4d08-82c2-c8a6c7e22275'));
    final response = await http.get(Uri.parse(
        'https://rmolabanti.github.io/agri_pulse_v2/assets/listings.json'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load items');
    }

    final parsedJson = jsonDecode(response.body) as Map<String, dynamic>;
    final listings = parsedJson['listings'] as List;
    final fetchedItems =
        listings.map((itemData) => Listing.fromJson(itemData)).toList();
    store.dispatch(ItemsFetchedAction(fetchedItems));
  } catch (error) {
    // Handle error (e.g., log or display to user)
    store.dispatch(ItemsFetchErrorAction(error.toString()));
  }
}
