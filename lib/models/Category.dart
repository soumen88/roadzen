class Category {
  int? id;
  String? name;
  String? icon;
  int? totalMembers;

  Category({
    this.id,
    this.name,
    this.icon,
    this.totalMembers
  });
}

List<Category> demoCategories = [
  Category(
      id: 1,
      name: 'Family A(4)',
      icon: 'assets/icons/food.svg',
      totalMembers: 4
  ),
  Category(
      id: 2,
      name: 'Family B(7)',
      icon: 'assets/icons/drinks.svg',
      totalMembers: 7
  ),
  Category(
      id: 3,
      name: 'Family C(3)',
      icon:'assets/icons/fruit.svg',
      totalMembers: 3
  ),
  Category(
      id: 4,
      name: 'Family D(9)',
      icon:'assets/icons/vege.svg',
      totalMembers: 9
  ),
];
