import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_feed_app/widgets/post_action_widget.dart';
import 'package:swift_feed_app/widgets/post_image_widget.dart';

class PostCard extends StatefulWidget {
  final Map post;
  final VoidCallback onTap;

  const PostCard({super.key, required this.post, required this.onTap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Timer? _likeDebounce;
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    bool isLiked = post['isLiked'] == true;
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: RepaintBoundary(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostImage(post: post),
                PostActions(
                  countColor: Colors.grey.shade800,
                  iconColor: Colors.grey.shade800,
                  post: post,
                  isLiked: isLiked,
                  onLike: () => _handleLike(post),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLike(Map post) {
    final prevLiked = post['isLiked'] == true;
    final prevCount = post['like_count'];

    setState(() {
      post['isLiked'] = !prevLiked;
      post['like_count'] = prevLiked ? prevCount - 1 : prevCount + 1;
    });

    _likeDebounce?.cancel();

    _likeDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        await supabase.rpc(
          'toggle_like',
          params: {'p_post_id': post['id'], 'p_user_id': 'user_123'},
        );
      } catch (e) {
        if (!mounted) return;
        setState(() {
          post['isLiked'] = prevLiked;
          post['like_count'] = prevCount;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Failed to like post")));
      }
    });
  }
}
