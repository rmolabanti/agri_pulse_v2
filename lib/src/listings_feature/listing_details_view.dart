import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class ListingDetailsView extends StatelessWidget {
  const ListingDetailsView({super.key});

  static const routeName = '/listing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
