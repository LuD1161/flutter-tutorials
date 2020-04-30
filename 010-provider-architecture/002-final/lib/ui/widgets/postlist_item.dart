import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/core/models/post.dart';

import '../../core/viewmodels/home_model.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  const PostListItem({this.post, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0.0, 2.0),
                  color: Color.fromARGB(80, 0, 0, 0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(
                post.title,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
              ),
              subtitle:
                  Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: IconButton(icon: Icon(Icons.delete),
              onPressed: (){
                Provider.of<HomeModel>(context, listen: false).deletePost(post);
              },
              ),
            )
          ],
        ),
      ),
    );
  }
}
