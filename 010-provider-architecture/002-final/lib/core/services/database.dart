import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/post.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String postsTable = 'posts_table';

  String colUserId = 'userId';
  String colId = 'id';
  String colTitle = 'title';
  String colBody = 'body';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }
  // Getter for our _database variable
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'posts.db';  
    // Open/Create the database at a given path
    var postsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return postsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $postsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUserId INTEGER, $colTitle TEXT, $colBody TEXT)');
    await db.rawInsert('INSERT INTO $postsTable($colUserId,$colTitle, $colBody)  VALUES (?, ?, ?)',[1, "1st Dummy Post", "This is the 1st dummy post for user 1"]);
    await db.rawInsert('INSERT INTO $postsTable($colUserId,$colTitle, $colBody)  VALUES (?, ?, ?)',[2, "2nd Dummy Post", "This is the 2nd dummy post for user 1"]);
    await db.rawInsert('INSERT INTO $postsTable($colUserId,$colTitle, $colBody)  VALUES (?, ?, ?)',[3, "3rd Dummy Post", "This is the 3rd dummy post for user 1"]);
    await db.rawInsert('INSERT INTO $postsTable($colUserId,$colTitle, $colBody)  VALUES (?, ?, ?)',[4, "4th Dummy Post", "This is the 4th dummy post for user 1"]);
    await db.rawInsert('INSERT INTO $postsTable($colUserId,$colTitle, $colBody)  VALUES (?, ?, ?)',[5, "5th Dummy Post", "This is the 5th dummy post for user 1"]);
  }

  void dropDb() async {
    Database db = await this.database;
    await db.execute('DROP TABLE  $postsTable');
  }

  // Fetch Operation : Get all post objects from the database
  Future<List<Map<String, dynamic>>> getPostMapList() async {
    Database db = await this.database;
    var result = await db.query(postsTable);
    return result;
  }

  // Insert Operation : Insert a Post object into the database
  Future<int> insertPost(Post post) async {
    Database db = await this.database;
    var result = await db.insert(postsTable, post.toMap());
    return result;
  }

  // Update Operation : Update a post object and save it to the database
  Future<int> updatePost(Post post) async {
    Database db = await this.database;
    var result = await db.update(postsTable, post.toMap(),
        where: '$colId = ?', whereArgs: [post.id]);
    return result;
  }

  // Delete Operation : Delete a Post object from the database
  Future<int> deletePost(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $postsTable WHERE $colId = $id');
    return result;
  }

  // Get number of Post Objects in the database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $postsTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Post List' [ List<Post> ]
  Future<List<Post>> getPostList() async {
    var postMapList = await getPostMapList(); // Get 'Map List' from database
    int count = postMapList.length;
    List<Post> postList = List<Post>();
    for (int i = 0; i < count; i++) {
      postList.add(Post.fromMapObject(postMapList[i]));
    }
    return postList;
  }

  Future<List<Post>> getPostsForUser(int userId) async {
    // For brevity just returning getPostList()
    return await getPostList();
  }
}
