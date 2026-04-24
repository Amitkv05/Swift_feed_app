import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_feed_app/detail_screen.dart';
import 'package:swift_feed_app/feed_provider.dart';
import 'package:swift_feed_app/widgets/helper.dart';
import 'package:swift_feed_app/widgets/post_card_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final int limit = 10;
  bool isFetching = false;
  bool isOffline = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(feedProvider.notifier).fetchPosts();
    });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isFetching) {
        isFetching = true;

        final online = await hasInternet();

        if (!online) {
          if (!mounted) return;
          setState(() {
            isOffline = true;
          });
          isFetching = false;
          return;
        }

        setState(() {
          isOffline = false;
        });

        await ref.read(feedProvider.notifier).fetchPosts();

        isFetching = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ✅ clean up controller
    super.dispose();
  }

  Future<void> refreshPosts() async {
    print('refreshPosts');
    await ref.read(feedProvider.notifier).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(feedProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("SwiftFeed"), centerTitle: true),
      body: posts.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: CircularProgressIndicator()),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: refreshPosts,
                  child: Text("Refresh", style: TextStyle(color: Colors.black)),
                ),
              ],
            )
          : RefreshIndicator(
              onRefresh: refreshPosts,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index < posts.length) {
                    final post = posts[index];
                    return PostCard(
                      post: post,
                      onTap: () {
                        Navigator.push(
                          context,
                          myRoute(builder: (_) => DetailScreen(post: post)),
                        );
                      },
                    );
                  } else {
                    if (index == posts.length) {
                      if (isOffline) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              "📡 You're offline",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }

                      return SizedBox();
                    }
                  }
                },
              ),
            ),
    );
  }
}

class myRoute extends MaterialPageRoute {
  myRoute({required WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
