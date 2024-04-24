import 'dart:convert';
import 'package:mentra/common/widgets/haptic_inkwell.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/constants/package_exports.dart';
import 'package:mentra/core/navigation/path_params.dart';
import 'package:mentra/core/navigation/route_url.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/core/utils/string_extension.dart';
import 'package:mentra/features/library/data/models/get_library_categories_response.dart';

class LibraryItem extends StatelessWidget {
  const LibraryItem({Key? key, required this.category}) : super(key: key);

  final LibraryCategory category;

  @override
  Widget build(BuildContext context) {
    return HapticInkWell(
      onTap: () {
        context.pushNamed(PageUrl.allArticlesScreen, queryParameters: {
          PathParam.libraryCategory: jsonEncode(category.toJson()),
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: category.backgroundColor.toString().toColor()),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: category.name,
                style: GoogleFonts.fraunces(
                    color: Pallets.white,
                    fontSize: 23.sp,
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
      ),
    );
  }
}
