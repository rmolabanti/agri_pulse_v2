import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'src/app.dart';
import 'src/sample_feature/actions.dart';
import 'src/sample_feature/sample_item.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final Store<List<SampleItem>> store = getStore();
  store.dispatch(FetchItemsAction());

  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.

  runApp(MyApp(settingsController: settingsController, store: store));
}
