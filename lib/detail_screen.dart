import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_feed_app/widgets/post_action_widget.dart';

class DetailScreen extends StatefulWidget {
  final Map post;

  const DetailScreen({super.key, required this.post});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoaded = false;
  Timer? _likeDebounce;
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    bool isLiked = post['isLiked'] == true;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: post['id'],
              child: Image.network(
                post['media_mobile_url'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    Future.microtask(() {
                      setState(() => isLoaded = true);
                    });
                    return child;
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 2,
            child: Container(
              // height: 70,
              // width: 408,
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width * 0.99,
              // color: Colors.grey,
              child: Column(
                children: [
                  Divider(color: Colors.white, thickness: 1),
                  PostActions(
                    post: widget.post,
                    isLiked: isLiked,
                    onLike: () => _handleLike(widget.post),
                  ),
                ],
              ),
            ),
          ),
        ],
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
        setState(() {
          post['isLiked'] = prevLiked;
          post['like_count'] = prevCount;
        });
      }
    });
  }
}
