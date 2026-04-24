import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final feedProvider = StateNotifierProvider<FeedNotifier, List>((ref) {
  return FeedNotifier();
});

class FeedNotifier extends StateNotifier<List> {
  FeedNotifier() : super([]);
  final supabase = Supabase.instance.client;

  Future<void> fetchPosts({bool isLoadMore = false}) async {
    try {
      final userId = 'user_123';

      final data = await supabase
          .from('posts')
          .select('*, user_likes!left(user_id)')
          .eq('user_likes.user_id', userId)
          .order('created_at', ascending: false);
      for (var post in data) {
        post['isLiked'] = post['user_likes'].isNotEmpty;
      }

      state = data;
    } catch (e) {
      print("FETCH ERROR: $e");
      if (!isLoadMore) {
        state = [];
      }
    }
  }
}
