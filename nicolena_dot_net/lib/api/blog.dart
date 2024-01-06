import 'dart:io';
import 'dart:async';

import 'package:toml/toml.dart';

import 'blog_post.dart';

class Blog {

  int testNum = 1;
  //List<BlogPost> posts = [];

  Blog._create(){ 
    print('_create() private constructor');
  }

  static Future<Blog> create() async {
    print('create() public factory');

    var testBlog = Blog._create();

    final dir  = Directory('../blog_posts/test/');
    final List<FileSystemEntity> entities = await dir.list().toList();
    entities.forEach(print);

    return testBlog;

  }
}
