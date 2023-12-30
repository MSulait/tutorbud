import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'learn_event.dart';
part 'learn_state.dart';

class LearnBloc extends Bloc<LearnEvent, LearnState> {
  LearnBloc() : super(LearnInitial()) {
    on<LearnInitialEvent>(learnInitialEvent);
    on<FindTeacherButtonClickedEvent>(findTeacherButtonClickedEvent);
  }

  FutureOr<void> learnInitialEvent(
      LearnInitialEvent event, Emitter<LearnState> emit) async {
    emit(LearnLoadingState());
    emit(LearnLoadedSuccessState());
  }

  FutureOr<void> findTeacherButtonClickedEvent(FindTeacherButtonClickedEvent event, Emitter<LearnState> emit) {
    emit(NavigatetoFindTeacherScreenState(studentId: event.studentId,subject: event.subject, topic: event.topic, note: event.note, studentName: event.studentName, imagepath: event.imagepath));
  }
}
