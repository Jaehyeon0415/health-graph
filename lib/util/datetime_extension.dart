extension DateTimeExtension on DateTime {
  /// "오후/오전 H시 mm분" 형식의 문자열로 변환합니다.
  String toKRTimeString() {
    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? '오후' : '오전';
    return '$period $hour시 $minute분';
  }
  
  /// "오후/오전 H시" 형식의 문자열로 변환합니다.
  String toKRHourString() {
    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final period = this.hour >= 12 ? '오후' : '오전';
    return '$period $hour시';
  }
}