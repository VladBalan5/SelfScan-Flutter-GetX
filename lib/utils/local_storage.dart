import 'package:localstorage/localstorage.dart';

class localStorage {
  static final LocalStorage storage = LocalStorage('products_images.json');

  static void addItem(String product_id, String image_url) {
    if (storage.getItem(product_id) == null) {
      print('write to storage $storage');
      storage.setItem(product_id, image_url);
    } else {
      return;
    }
  }

  static String getitem(String product_id) {
    print('read from storage $product_id');
    final url = storage.getItem(product_id);
    if (url != null) {
      return url;
    } else {
      return null.toString();
    }
  }

  static void clearStorage() async {
    print('clear image storage');
    await storage.clear();
  }
}
