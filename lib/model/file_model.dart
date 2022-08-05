class FileModel {
  String? name;
  String? path;
  String? extension;
  FileModel({this.name, this.path, this.extension});
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      path: json['path'] as String,
      name: json['name'] as String,
      extension: json['extension'] as String,
    );
  }
}
