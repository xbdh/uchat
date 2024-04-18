enum FriendViewType { friends, friendRequests, group, allUsers }

enum MessageType {
  text,
  image,
  video,
  audio,
  file,
  gif,
}
// 扩展MessageType枚举，添加方法toString()和fromString()
extension MessageTypeExtension on MessageType {
  // 将枚举转换为字符串
  String toShortString() {
    return this.toString().split('.').last;
  }

  // 从字符串转换为枚举
  static MessageType fromString(String str) {
    return MessageType.values.firstWhere(
          (e) => e.toShortString() == str,
      orElse: () => throw ArgumentError('无法将"$str"转换为MessageType'),
    );
  }
}
