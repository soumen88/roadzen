class FamilyModel {
  int? id;
  String? name;
  String? icon;
  int? totalMembers;
  List<List<int>> indexes = [];

  FamilyModel({
    this.id,
    this.name,
    this.icon,
    this.totalMembers
  });
}

List<FamilyModel> familyList = [
  FamilyModel(
      id: 1,
      name: 'Family A(4)',
      icon: 'assets/icons/food.svg',
      totalMembers: 4
  ),
  FamilyModel(
      id: 2,
      name: 'Family B(7)',
      icon: 'assets/icons/drinks.svg',
      totalMembers: 7
  ),
  FamilyModel(
      id: 3,
      name: 'Family C(3)',
      icon:'assets/icons/fruit.svg',
      totalMembers: 3
  ),
  FamilyModel(
      id: 4,
      name: 'Family D(9)',
      icon:'assets/icons/vege.svg',
      totalMembers: 9
  ),
];
