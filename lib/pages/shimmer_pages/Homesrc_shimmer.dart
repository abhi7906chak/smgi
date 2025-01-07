// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeSrcShimmer extends StatefulWidget {
  const HomeSrcShimmer({super.key});

  @override
  State<HomeSrcShimmer> createState() => _HomeSrcShimmerState();
}

class _HomeSrcShimmerState extends State<HomeSrcShimmer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // child: isLoading
      // ? const Center(
      //     child: CircularProgressIndicator(),
      //   )
      // :
      child: Scaffold(
        body: ListView(children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.45),
                              highlightColor: Colors.white.withOpacity(0.80),
                              child: const CircleAvatar(
                                maxRadius: 30,
                                child: Text("image "),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.45),
                              highlightColor: Colors.white.withOpacity(0.80),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                // clipBehavior: Clip.antiAlias,

                                height: 40,
                                width: 180,
                                // color: Colors.grey.withOpacity(0.45),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.45),
                            highlightColor: Colors.white.withOpacity(0.80),
                            child: Container(
                                height: 40,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(19),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        colors: [
                                          Color(0xFF161697),
                                          Color(0xFF9747FF),
                                        ])),
                                child: const Center(
                                    child: Text(
                                  "Menu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Encode"),
                                ))),
                          ),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.45),
                        highlightColor: Colors.white.withOpacity(0.80),
                        child: Container(
                          height: 40,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.amber,
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.45),
                      highlightColor: Colors.white.withOpacity(0.80),
                      child: Container(
                        height: 260,
                        width: double.infinity,
                        // color: Colors.amber,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        //
                      },
                      child: const Text("data")),
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      "Subjects",
                      style: TextStyle(
                          fontFamily: "Encode",
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
