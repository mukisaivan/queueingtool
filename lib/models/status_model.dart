class Status {
  final String statusName;

  Status({required this.statusName});

  Map<String, dynamic> toMap() {
    return {'statusName': statusName};
  }

  // Assuming you have a factory method to create Status from a map
  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      statusName: map['statusName'] as String,
    );
  }
}
