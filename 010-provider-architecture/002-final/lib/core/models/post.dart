class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }

  // Convert a Note object into a map object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id != null){
      map['id'] = id;
    }
    map['userId'] = this.userId;
    map['id'] = this.id;
    map['title'] = this.title;
    map['body'] = this.body;

    return map;
  }

  // Extract a Note object from a Map Object
  Post.fromMapObject(Map<String, dynamic> map){
    this.id = map['id'];
    this.title = map['title'];
    this.body = map['body'];
    this.userId = map['userId'];
  }
}