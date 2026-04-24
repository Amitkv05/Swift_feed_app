import 'package:flutter/material.dart';

class PostActions extends StatelessWidget {
  final Map post;
  final bool isLiked;
  final VoidCallback onLike;
  final Color? iconColor;
  final Color? countColor;

  const PostActions({
    required this.post,
    required this.isLiked,
    required this.onLike,
    this.iconColor,
    this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "0",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: countColor ?? Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("No Available")));
                },
                child: Icon(
                  size: 35,
                  Icons.comment_outlined,
                  color: iconColor ?? Colors.white,
                ),
              ),
              SizedBox(width: 20),
              Text(
                post['like_count'].toString(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: countColor ?? Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onLike,
                child: Icon(
                  size: 35,
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : iconColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
