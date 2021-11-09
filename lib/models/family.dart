class Family {
  int? id;
  String? name;
  String? icon;
  int? totalMembers;
  List<List<int>> indexes = [];

  Family({
    this.id,
    this.name,
    this.icon,
    this.totalMembers
  });
}

List<Family> familyList = [
  Family(
      id: 1,
      name: 'Family A(4)',
      icon: 'assets/icons/food.svg',
      totalMembers: 4
  ),
  Family(
      id: 2,
      name: 'Family B(7)',
      icon: 'assets/icons/drinks.svg',
      totalMembers: 7
  ),
  Family(
      id: 3,
      name: 'Family C(3)',
      icon:'assets/icons/fruit.svg',
      totalMembers: 3
  ),
  Family(
      id: 4,
      name: 'Family D(9)',
      icon:'assets/icons/vege.svg',
      totalMembers: 9
  ),
];
