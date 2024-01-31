
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'change_therapist_event.dart';

part 'change_therapist_state.dart';

class ChangeTherapistBloc
    extends Bloc<ChangeTherapistEvent, ChangeTherapistState> {
  ChangeTherapistBloc() : super(ChangeTherapistInitial()) {
    on<ChangeTherapistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
