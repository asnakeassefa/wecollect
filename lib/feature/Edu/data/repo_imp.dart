
import 'package:injectable/injectable.dart';

import '../../../core/network/api_provider.dart';
import '../../../core/network/endpoints.dart';
import '../domain/content_repo.dart';
import 'content_model.dart';
@Injectable(as: ContentRepository)
class ContentRepositoryImp implements ContentRepository {
  Api api = Api();
  @override
  Future<ContentModel> getContent() {
    final url = Endpoints.content;
    return api.get(url).then((response) {
      if (response.statusCode == 200) {
        final res = ContentModel.fromJson(response.data);
        return res;
      } else {
        throw Exception('Failed to load data');
      }
    });
  }

}