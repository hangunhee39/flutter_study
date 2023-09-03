const assetPath = 'assets/images';

enum InputType {
  rock,
  scissors,
  paper;

  //이미지 경로 get(저장)
  String get path => '$assetPath/$name.png';
}

enum Result {
  playerWin('Player 승리'),
  draw('무승부'),
  cpuWin('Player 패배');

  //enum 에 설명 저장
  const Result(this.displayString);

  final String displayString;
}