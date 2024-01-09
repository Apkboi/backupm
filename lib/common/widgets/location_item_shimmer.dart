import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LocationItemShimmer extends StatefulWidget {
  const LocationItemShimmer({Key? key}) : super(key: key);

  @override
  State<LocationItemShimmer> createState() => _LocationItemShimmerState();
}

class _LocationItemShimmerState extends State<LocationItemShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Theme.of(context).cardTheme.color!.withAlpha(30),
      baseColor: Colors.grey.withOpacity(0.2),
      child: Column(children: [
        ListView.builder(
          shrinkWrap: true,
          // controller: widget.controller,
          itemCount: 6,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _ShimmerItem(),
            ),
          ),
        ),
      ],),
    ) ;
  }
}



class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Center(
              child: Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 25,
              )),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 16,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 15,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey),
                ),

                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //   decoration: BoxDecoration(
                //     color: Theme.of(context).colorScheme.primary,
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: const Text(
                //     'Recommended',
                //     style: TextStyle(fontSize: 12, color: Colors.white),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            height: 15,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5,
                ),
                color: Colors.grey),
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

