
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/content_repo.dart';
import 'dashboard_state.dart';

@injectable
class ContentCubit extends Cubit<ContentState> {
  ContentRepository contentRepository;
  ContentCubit({required this.contentRepository})
      : super(ContentInitial());

  void getContents() async {
    try {
      emit(ContentLoading());
      final contentData = await contentRepository.getContent();
      emit(ContentLoaded(content: contentData));
    } catch (e) {
      emit(ContentError(e.toString()));
    }
  }
}
