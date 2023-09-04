import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [StoryArea(), FeedList()],
      ),
    );
  }
}

class StoryArea extends StatelessWidget {
  const StoryArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          //List.generate : length의 길이만큼 0부터 index - 1까지 범위의 각 인덱스를 오름차순으로 호출하여 만든 값으로 리스트를 생성합니다.
          // growable의 기본값은 true이고, false인 경우 생성된 리스트의 길이는 고정됩니다.
          children: List.generate(
              10,
              (index) => UserStory(
                    userName: 'User$index',
                  ))),
    );
  }
}

class UserStory extends StatelessWidget {
  final String userName;

  const UserStory({
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.circular(40)),
          ),
          Text(userName),
        ],
      ),
    );
  }
}

//feed 클레스
class FeedDate {
  final String userName;
  final int likeCount;
  final String content;

  //생성자
  FeedDate(
      {required this.userName, required this.likeCount, required this.content});
}

//더미 데이터
final feedateList = [
  FeedDate(userName: 'User1', likeCount: 99, content: "나 그녀랑 헤어졌어"),
  FeedDate(
      userName: 'User2', likeCount: 56, content: "나 너보다 늦게 잤는데 너보다 일찍 일어났어"),
  FeedDate(userName: 'User3', likeCount: 76, content: "너 재능있어"),
  FeedDate(userName: 'User4', likeCount: 32, content: "그녀가 내가 좋대"),
  FeedDate(userName: 'User5', likeCount: 101, content: "여름.."),
  FeedDate(userName: 'User6', likeCount: 8, content: "가을.."),
];

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true, //스크롤 막기
        physics: const NeverScrollableScrollPhysics(), //이중 스크롤 막기
        itemCount: feedateList.length,
        itemBuilder: (context, index) =>
            FeedItem(feedData: feedateList[index]));
  }
}

class FeedItem extends StatelessWidget {
  final FeedDate feedData;

  const FeedItem({required this.feedData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade300,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(feedData.userName)
                ],
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          height: 280,
          color: Colors.indigo.shade300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.chat_bubble)),
                  IconButton(
                      onPressed: () {}, icon: Icon(CupertinoIcons.paperplane)),
                ],
              ),
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bookmark)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '좋아요 ${feedData.likeCount}개',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: feedData.userName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const WidgetSpan(child: SizedBox(width: 4,)), //글자 사이 띄위기
            TextSpan(text: feedData.content),
          ], style: const TextStyle(color: Colors.black))),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}
