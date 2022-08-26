import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/photos_cubit/photos_cubit.dart';
import 'package:test_app/blocs/photos_cubit/photos_state.dart';
import 'package:test_app/components/error.dart';
import 'package:test_app/components/loading.dart';

class Photos extends StatelessWidget {
  final int albumId;
  const Photos({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotosCubit()..fetchPhotos(albumId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
        ),
        body: BlocBuilder<PhotosCubit, PhotosState>(
          builder: (context, state) {
            if (state is PhotosErrorState) {
              return const Error();
            }
            if (state is PhotosLoadedState) {
              const textStyle = TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 77, 73, 73),
              );
              return Container(
                color: const Color.fromARGB(255, 197, 229, 244),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                  ),
                  items: state.photos
                      .map((item) => Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  color: item.id.isEven
                                      ? const Color.fromARGB(111, 76, 175, 79)
                                      : const Color.fromARGB(112, 33, 149, 243),
                                  child: Text(
                                    item.title,
                                    textAlign: TextAlign.center,
                                    style: textStyle,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(10),
                                        color: item.id.isEven
                                            ? const Color.fromARGB(
                                                112, 33, 149, 243)
                                            : const Color.fromARGB(
                                                111, 76, 175, 79),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Error(),
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Loading();
                                            },
                                            '${item.url}.jpg',
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(10),
                                        color: item.id.isEven
                                            ? const Color.fromARGB(
                                                111, 76, 175, 79)
                                            : const Color.fromARGB(
                                                112, 33, 149, 243),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Error(),
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Loading();
                                            },
                                            '${item.thumbnailUrl}.jpg',
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              );
            }
            return const Loading();
          },
        ),
      ),
    );
  }
}
