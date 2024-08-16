
import '../data/content_model.dart';

abstract class ContentRepository {
  Future<ContentModel> getContent();
}