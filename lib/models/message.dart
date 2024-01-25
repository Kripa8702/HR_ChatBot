class Message {
  final String text;
  final bool isMe;

  Message(this.text, this.isMe);

  @override
  String toString() {
    return '${isMe ? 'User' : 'AI'}: $text';
  }
}
