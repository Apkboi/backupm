import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/library/presentation/blocs/wellness_library/wellness_library_bloc.dart';

class FavoriteActionButton extends StatefulWidget {
  const FavoriteActionButton(
      {super.key, required this.favourite, required this.id});

  final bool favourite;
  final String id;

  @override
  State<FavoriteActionButton> createState() => _FavoriteActionButtonState();
}

class _FavoriteActionButtonState extends State<FavoriteActionButton> {
  late bool isFavorite;
  final libraryBloc = WellnessLibraryBloc(injector.get());

  @override
  void initState() {
    isFavorite = widget.favourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WellnessLibraryBloc, WellnessLibraryState>(
      bloc: libraryBloc,
      listener: (context, state) {
        if (state is UpdateFavouritesSuccessState) {
          isFavorite = state.response.data.inFavourite;
          setState(() {});
        }
        if (state is UpdateFavouritesFailureState) {
          CustomDialogs.error(state.error);
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            libraryBloc.add(UpdateFavouriteEvent(widget.id));
          },
          child: CircleAvatar(
            backgroundColor: Pallets.white,
            child: state is UpdateFavouritesLoadingState
                ? CustomDialogs.getLoading(size: 15)
                : Icon(
                    isFavorite ? Icons.favorite_rounded : Icons.favorite_border,
                    color: Pallets.navy,
                    size: 18,
                  ),
          ),
        );
      },
    );
  }
}
