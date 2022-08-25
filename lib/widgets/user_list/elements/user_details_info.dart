import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_cubit.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_state.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_cubit.dart';
import 'package:test_app/blocs/user_posts_cubit/user_posts_state.dart';
import 'package:test_app/models/album.dart';
import 'package:test_app/models/post.dart';
import 'package:test_app/models/user.dart';
import 'package:test_app/services/user_repository.dart';

class UserDeatailsInfo extends StatelessWidget {
  final UsersRepository usersRepository = UsersRepository();
  final User user;
  UserDeatailsInfo({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserPostsCubit()..fetchPosts(user.id),
        ),
        BlocProvider(
          create: (context) => UserAlbumCubit()..fetchAlbums(user.id),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: user.id,
            child: Text(user.username),
          ),
        ),
        body: SizedBox(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Text(' ${user.name}'),
                    title: Text(' ${user.phone}'),
                  ),
                  ListTile(
                    leading: Text(' ${user.email}'),
                    title: Text('Website : ${user.website}'),
                  ),
                  ListTile(
                    leading: const Text('Address'),
                    title: Text('${user.address?.city}'),
                    subtitle: Text('${user.address?.street}'),
                    trailing: Text('${user.address?.suite}'),
                  ),
                  ListTile(
                    leading: const Text('Company'),
                    title: Text('${user.company?.name}'),
                    subtitle: Text(
                      ' ${user.company?.catchPhrase}',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    // trailing: Text(' ${user.company?.bs}'),
                  ),
                  BlocBuilder<UserPostsCubit, UserPostsState>(
                    builder: (context, state) {
                      if (state is UserPostsErrorState) {
                        return const Center(
                          child: Text(
                            'Ошибка сети ... ',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        );
                      }
                      if (state is UserPostLoadedState) {
                        return PostsPreview(posts: state.posts);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  BlocBuilder<UserAlbumCubit, UserAlbumsState>(
                    builder: (context, state) {
                      if (state is UserAlbumsErrorState) {
                        return const Center(
                          child: Text(
                            'Ошибка сети ... ',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        );
                      }
                      if (state is UserAlbumsLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const PrewievTitle(title: 'Albums'),
                                  CustomButtonFromAlbums(
                                      albums: state.albums, title: 'All albums')
                                ],
                              ),
                              Card(
                                elevation: 0,
                                color: const Color.fromARGB(107, 158, 158, 158),
                                child: ListTile(
                                  title: Text(state.albums[0].title),
                                ),
                              ),
                              Card(
                                elevation: 0,
                                color: const Color.fromARGB(107, 158, 158, 158),
                                child: ListTile(
                                  title: Text(state.albums[1].title),
                                ),
                              ),
                              Card(
                                elevation: 0,
                                color: const Color.fromARGB(107, 158, 158, 158),
                                child: ListTile(
                                  title: Text(state.albums[2].title),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostsPreview extends StatelessWidget {
  final List<Post> posts;
  const PostsPreview({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PrewievTitle(title: 'Posts'),
              CustomButton(title: 'All Posts', posts: posts)
            ],
          ),
          PostItem(posts: posts[0]),
          PostItem(posts: posts[1]),
          PostItem(posts: posts[2]),
        ],
      ),
    );
  }
}

class PrewievTitle extends StatelessWidget {
  final String title;
  const PrewievTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post posts;
  const PostItem({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(107, 158, 158, 158),
      elevation: 0,
      child: ListTile(
        title: Text(
          posts.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final List<Post> posts;
  const CustomButton({
    Key? key,
    required this.posts,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostsPreviewWidget(posts: posts),
          ),
        );
      },
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}

class CustomButtonFromAlbums extends StatelessWidget {
  final String title;
  final List<Album> albums;
  const CustomButtonFromAlbums({
    Key? key,
    required this.albums,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostsPreviewWidgetFromAlbums(albums: albums),
          ),
        );
      },
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}

class PostsPreviewWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsPreviewWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black.withOpacity(0.33),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final post = posts[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: const Text('Detail post'),
                          ),
                          body: Column(
                            children: [
                              Text(post.title),
                              Text(post.body),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  title: Text(
                    post.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  style: ListTileStyle.drawer,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PostsPreviewWidgetFromAlbums extends StatelessWidget {
  final List<Album> albums;
  const PostsPreviewWidgetFromAlbums({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: albums.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black.withOpacity(0.33),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final album = albums[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: const Text('Detail post'),
                          ),
                          body: Column(
                            children: [
                              Text(album.title),
                              Text(album.id.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  title: Text(
                    album.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  style: ListTileStyle.drawer,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
