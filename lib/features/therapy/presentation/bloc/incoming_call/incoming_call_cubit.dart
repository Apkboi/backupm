import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'incoming_call_state.dart';

class IncomingCallCubit extends Cubit<IncomingCallState> {
  IncomingCallCubit() : super(IncomingCallInitial());
}
