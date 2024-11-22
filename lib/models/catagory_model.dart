class CatagoryModel {
  final String name;
  final String id;

  CatagoryModel({required this.name, required this.id});

  factory CatagoryModel.fromJson(Map<String, dynamic> json) {
    return CatagoryModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  CatagoryModel copyWith({
    String? name,
    String? id,
  }) {
    return CatagoryModel(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
