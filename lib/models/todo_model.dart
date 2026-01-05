class TodoModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime? deadline;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.deadline,
  });

  // Convert TodoModel to JSON Map for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'deadline': deadline?.toIso8601String(),
    };
  }

  // Create TodoModel from JSON Map
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
    );
  }

  // Create a copy of TodoModel with updated fields
  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? deadline,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
    );
  }
}
