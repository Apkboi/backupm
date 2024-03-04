import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/image_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/string_extension.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';
import 'package:mentra/gen/assets.gen.dart';

class LibraryItem extends StatelessWidget {
  const LibraryItem({Key? key, required this.category}) : super(key: key);

  final LibraryCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(PageUrl.allArticlesScreen, queryParameters: {
          PathParam.libraryCategory: jsonEncode(category.toJson()),
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: category.backgroundColor.toColor()),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: category.name,
                      style: GoogleFonts.fraunces(
                          color: Pallets.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Pallets.white,
                            padding: EdgeInsets.zero),
                        onPressed: () {
                          context.pushNamed(PageUrl.allArticlesScreen,
                              queryParameters: {
                                PathParam.libraryCategory:
                                    jsonEncode(category.toJson()),
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextView(
                              text: 'Explore',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            8.horizontalSpace,
                            const Icon(
                              Icons.arrow_forward,
                              size: 20,
                            )
                          ],
                        ))
                  ],
                ),
              ),
              ImageWidget(
                // imageUrl: Assets.images.pngs.sleep.path,
                onTap: () {
                  context.pushNamed(PageUrl.allArticlesScreen, queryParameters: {
                    PathParam.libraryCategory: jsonEncode(category.toJson()),
                  });
                },
                canPreview: false,
                imageUrl: category.image.url,
                width: 120.w,
                height: 120.h,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
