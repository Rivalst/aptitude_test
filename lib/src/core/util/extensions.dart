extension TimeStringExtension on int {
  /// convert int seconds to string format *m:s*
  String toSecondsString() {
    int minutes = this ~/ 60;
    int remainingSeconds = this % 60;
    
    String secondsString = remainingSeconds.toString().padLeft(2, '0');
    
    return '$minutes:$secondsString';
  }
}
