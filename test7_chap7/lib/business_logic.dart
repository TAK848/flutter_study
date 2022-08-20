import "dart:async";
import "dart:math" as math;

class Generator {
  var rand;
  late StreamController<int> intStream;
  init(StreamController<int> stream) {
    rand = math.Random();
    intStream = stream;
  }

  // ランダムな整数を作る
  generate() {
    var data = rand.nextInt(100);
    // ignore: avoid_print
    print("generatorが$dataを作ったよ");
    intStream.sink.add(data);
  }
}

class Coordinator {
  late StreamController<int> intStream;
  late StreamController<String> strStream;
  init(StreamController<int> intStream, StreamController<String> strStream) {
    this.intStream = intStream;
    this.strStream = strStream;
  }

  // 流れてきたものをintからStringにする
  coorinate() {
    // ignore: avoid_print
    print("coordinatorが開始したよ");
    intStream.stream.listen((data) async {
      String newData = data.toString();
      // ignore: avoid_print
      print("coordinatorが$dataから$newDataに変換したよ");
      strStream.sink.add(newData);
    });
  }
}

class Consumer {
  late StreamController<String> strStream;
  init(StreamController<String> stream) {
    strStream = stream;
  }

  // 流れてきたStringを表示する
  consume() {
    // ignore: avoid_print
    print("consumerが開始したよ");
    strStream.stream.listen((data) async {
      // ignore: avoid_print
      print("consumerが$dataを使ったよ");
    });
  }
}
