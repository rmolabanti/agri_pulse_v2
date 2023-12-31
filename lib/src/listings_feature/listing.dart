/// A placeholder class that represents an entity or model.
class Listing {
  const Listing(this.id);

  final String id;

  static Listing fromJson(itemData) {
    return Listing(itemData['name']);
  }
}
