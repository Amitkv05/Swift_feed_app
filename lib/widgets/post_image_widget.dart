import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_feed_app/widgets/post_action_widget.dart';

class PostImage extends StatefulWidget {
  final Map post;

  const PostImage({required this.post});

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    bool isLiked = post['isLiked'] == true;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Hero(
        tag: widget.post['id'],
        child: Stack(
          children: [
            Image.network(
              post['media_thumb_url'],
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
              cacheWidth: 1200,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 400,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
