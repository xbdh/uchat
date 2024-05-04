import '../repositories/call_repositories.dart';

class GetRtcTokenUseCase {
  final CallRepository repository;

  GetRtcTokenUseCase({required this.repository});

  Future<String> call(String channelName) async {
    return await repository.getRtcToken(channelName);
  }
}