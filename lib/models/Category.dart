class Category {
  int? id;
  String? name;
  String? icon;

  Category({
    this.id,
    this.name,
    this.icon
  });
}

List<Category> demoCategories = [
  Category(
      id: 1,
      name: 'Family One',
      icon: 'assets/icons/food.svg'
  ),
  Category(
      id: 2,
      name: 'Family Two',
      icon: 'assets/icons/drinks.svg'
  ),
  Category(
      id: 3,
      name: 'Family Three',
      icon:'assets/icons/fruit.svg'
  ),
  Category(
      id: 4,
      name: 'Family Four',
      icon:'assets/icons/vege.svg'
  ),
];