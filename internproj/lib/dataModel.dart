class DataModel {
  int? id, parent;
  String? name, slug;

  DataModel({
    this.id,
    this.name,
    this.parent,
    this.slug,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
  }
}
