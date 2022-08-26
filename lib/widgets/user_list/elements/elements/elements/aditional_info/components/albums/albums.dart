import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_cubit.dart';
import 'package:test_app/blocs/user_albums_cubit/user_albums_state.dart';
import 'package:test_app/components/error.dart';
import 'package:test_app/components/loading.dart';
import 'package:test_app/widgets/user_list/elements/elements/elements/aditional_info/components/albums/elements/albums_preview.dart';

class Albums extends StatelessWidget {
  const Albums({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAlbumCubit, UserAlbumsState>(
      builder: (context, state) {
        if (state is UserAlbumsErrorState) {
          return const Error();
        }
        if (state is UserAlbumsLoadedState) {
          return AlbumPreview(
            albums: state.albums,
          );
        }
        return const Loading();
      },
    );
  }
}
