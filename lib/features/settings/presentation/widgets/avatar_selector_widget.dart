import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentra/common/widgets/custom_dialogs.dart';
import 'package:mentra/common/widgets/error_widget.dart';
import 'package:mentra/common/widgets/text_view.dart';
import 'package:mentra/core/di/injector.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/features/settings/data/models/get_avatars_response.dart';
import 'package:mentra/features/settings/presentation/blocs/settings/settings_bloc.dart';

class AvartarSelector extends StatefulWidget {
  const AvartarSelector({
    super.key,
    required this.onAvatarSelected,
    required this.onBackgroundSelector,
    this.selectBackgroundColor = true,
    // required this.tittle
  });

  final Function(AvatarImage) onAvatarSelected;
  final Function(Color) onBackgroundSelector;
  final bool? selectBackgroundColor;

  // final String tittle;

  @override
  State<AvartarSelector> createState() => _AvartarSelectorState();
}

class _AvartarSelectorState extends State<AvartarSelector> {
  int selectedIndex = 0;
  int selectedImageIndex = 0;
  int selectedColorIndex = 0;

  @override
  void initState() {
    injector.get<SettingsBloc>().add(GetAvatarsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              SwitchButton(
                tittle: 'Avatar',
                selected: selectedIndex == 0,
                onSelected: () {
                  selectedIndex = 0;
                  setState(() {});
                },
              ),
              10.horizontalSpace,
              if(widget.selectBackgroundColor!)
              SwitchButton(
                tittle: 'Avatar Background',
                selected: selectedIndex == 1,
                onSelected: () {
                  selectedIndex = 1;
                  setState(() {});
                },
              ),
            ],
          ),
          16.verticalSpace,
          IndexedStack(
            index: selectedIndex,
            children: [
              BlocConsumer<SettingsBloc, SettingsState>(
                bloc: injector.get(),
                buildWhen: _buildWhen,
                listener: _listenToSettingStates,
                builder: (context, state) {
                  if (state is GetAvatarsLoadingState) {
                    return SizedBox(
                      height: 200.h,
                      child: Center(
                        child: CustomDialogs.getLoading(size: 20),
                      ),
                    );
                  }
                  if (state is GetAvatarsSuccessState) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        injector.get<SettingsBloc>().add(GetAvatarsEvent());
                      },
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.response.data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 80,
                                  crossAxisCount: 4),
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                selectedImageIndex = index;
                                widget.onAvatarSelected(
                                    state.response.data[index]);
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(state
                                          .response.data[index].image.url)),
                                  border: selectedImageIndex == index
                                      ? Border.all(
                                          width: 1, color: Pallets.primary)
                                      : null,
                                ),
                              ))),
                    );
                  }
                  return AppPromptWidget(
                    onTap: () {
                      injector.get<SettingsBloc>().add(GetAvatarsEvent());
                    },
                  );
                },
              ),
              if(widget.selectBackgroundColor!)

              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: Pallets.avatarBackgrounds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 72,
                      crossAxisCount: 4),
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        selectedColorIndex = index;
                        widget.onBackgroundSelector(
                            Pallets.avatarBackgrounds[index]);
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallets.avatarBackgrounds[index],
                          border: selectedColorIndex == index
                              ? Border.all(width: 1, color: Pallets.primary)
                              : null,
                        ),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _listenToSettingStates(BuildContext context, SettingsState state) {
    if (state is UploadImageLoadingState) {
      CustomDialogs.showLoading(context);
    }
    if (state is UploadImagesSuccessState) {
      context.pop();
      context.pop();
      CustomDialogs.success('Avatar uploaded!');
    }

    if (state is UploadImageFailureState) {
      context.pop();
      CustomDialogs.error(state.error);
    }
  }

  bool _buildWhen(SettingsState previous, SettingsState current) {
    return current is GetAvatarsLoadingState ||
        current is GetAvatarsFailureState ||
        current is GetAvatarsSuccessState;
  }
}

class SwitchButton extends StatefulWidget {
  const SwitchButton(
      {super.key,
      required this.tittle,
      required this.selected,
      required this.onSelected});

  final String tittle;
  final bool selected;
  final VoidCallback onSelected;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Pallets.black,
            backgroundColor:
                widget.selected ? Pallets.lightSecondary : Pallets.white,
            shape: const StadiumBorder()),
        onPressed: () => widget.onSelected(),
        child: TextView(text: widget.tittle));
  }
}
