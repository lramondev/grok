class StatusModel {
  final int id;
  final String name;
  final String description;
  final String icon;

  StatusModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      icon: json['icon']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'icon': icon
  };
}