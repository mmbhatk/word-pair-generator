import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _randomWordPairs = List<WordPair>.from(generateWordPairs().take(1000));
  final _savedWordPairs = List<WordPair>();

  Widget _buildList({savedList = false}) {
    return ListView.separated (
      padding: const EdgeInsets.all(18.0),
      itemCount: savedList ? _savedWordPairs.length : _randomWordPairs.length,
      itemBuilder: (BuildContext context, int index) {
        if(savedList == true) return _buildRow(_savedWordPairs[index], savedList: true);
        return _buildRow(_randomWordPairs[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildRow(WordPair pair, {savedList = false}) {
    var isSaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
      trailing: savedList ? null :
                    Icon(isSaved ? Icons.favorite : Icons.favorite_border,
                                  color: isSaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if(isSaved) _savedWordPairs.remove(pair);
          else _savedWordPairs.add(pair);
        });
      },
      );
  }

  void _pushSaved() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text('Saved WordPairs')),
          body: _buildList(savedList: true),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Pair Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildList(),
    );
  }

}