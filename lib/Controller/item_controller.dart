import '../Model/to_do_model.dart';

class ItemController {
  List<Item> _items = [];

  List<Item> get items => _items;
  List<Item> get completedItems => _items.where((item) => item.isCompleted).toList();

  void addItem(String title, String description) {
    _items.add(Item(title: title, description: description, uploadDateTime: DateTime.now()));
  }

  void editItem(int index, String title, String description) {
    _items[index].title = title;
    _items[index].description = description;
    _items[index].uploadDateTime = DateTime.now();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
  }

  void completeItem(int index) {
    _items[index].isCompleted = true;
  }
}
