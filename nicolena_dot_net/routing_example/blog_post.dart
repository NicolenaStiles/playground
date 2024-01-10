// Mostly auto-generated.
// Code taken from here: 
// https://www.webinovers.com/web-tools/json-to-dart-convertor?route=en/json-to-dart-convertor

class BlogData {
  BlogData({
    required this.posts,
  });
  late final List<BlogPost> posts;
  
  BlogData.fromJson(Map<String, dynamic> json){
    posts = List.from(json['posts']).map((e)=>BlogPost.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['posts'] = posts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class BlogPost {
  String? title;
  String? date;
  String? subtitle;
  List<String>? tags;
  String? uRL;

  BlogPost({this.title, this.date, this.subtitle, this.tags, this.uRL});

  BlogPost.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    subtitle = json['subtitle'];
    tags = json['tags'].cast<String>();
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{}; 
    data['title'] = title;
    data['date'] = date;
    data['subtitle'] = subtitle;
    data['tags'] = tags;
    data['URL'] = uRL;
    return data;
  }
}
