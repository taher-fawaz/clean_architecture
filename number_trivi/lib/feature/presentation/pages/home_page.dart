import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivi/feature/presentation/cubit/note/post_cubit.dart';

import '../../../app_const.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late List<PostModel> posts;
  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "number trivia ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigator.pushNamed(context, PageConst.addNotePage,
          //     arguments: widget.uid);
        },
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, noteState) {
          if (noteState is PostLoaded) {
            return _bodyWidget(noteState);
          } else if (noteState is PostFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      height: 80,
                      child: Icon(
                        Icons.error,
                        size: 100,
                      )),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                      "${noteState.failure.message} with status code ${noteState.failure.statusCode}"),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _noPostsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80, child: Image.asset('assets/notebook.png')),
          const SizedBox(
            height: 10,
          ),
          const Text("No notes here yet"),
        ],
      ),
    );
  }

  Widget _bodyWidget(PostLoaded noteLoadedState) {
    return Column(
      children: [
        Expanded(
          child: noteLoadedState.posts.isEmpty
              ? _noPostsWidget()
              : GridView.builder(
                  itemCount: noteLoadedState.posts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.2),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.UpdateNotePage,
                            arguments: noteLoadedState.posts[index]);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Note"),
                              content: const Text(
                                  "are you sure you want to delete this note."),
                              actions: [
                                TextButton(
                                  child: const Text("Delete"),
                                  onPressed: () {
                                    // BlocProvider.of<PostCubit>(context)
                                    //     .deleteNote(
                                    //         note: noteLoadedState.notes[index]);
                                    // Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 1.5))
                            ]),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              noteLoadedState.posts[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            // SizedBox(
                            //   height: 4,
                            // ),
                            Text(
                              noteLoadedState.posts[index].body!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
