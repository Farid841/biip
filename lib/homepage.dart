import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = '';
  bool _isButtonSelected = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  @override
  void dispose() {
    _speechToText.stop();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (status) => print('STATUS: $status'),
        onError: (error) => print('ERROR: $error'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speechToText.listen(
          onResult: (result) {
            setState(() {
              _text = result.recognizedWords;
              _controller.text = _text;
            });
            print('Mots reconnus: ${result.recognizedWords}');
          },
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speechToText.stop();
    }
  }

  Widget _buildMicroTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13),
      child: Container(
        decoration: _buildBoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                enabled: false,
                decoration: InputDecoration(
                  hintText: "Parlez maintenant",
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic, color: Colors.blueAccent, size: 26),
              onPressed: _listen,
            ),
          ],
        ),
      ),
    );
  }

  // ...
 BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(blurRadius: 5, color: Colors.blue, offset: Offset(0, 2))],
      borderRadius: BorderRadius.circular(12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMicroTextField(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isListening ? () => _listen() : _listen,
              child: Text(_isListening ? 'Stop' : 'Start'),
            ),
            const SizedBox(height: 16),
            ToggleButtons(
              children: const [
                Icon(Icons.check, color: Colors.white),
                Icon(Icons.close, color: Colors.white),
              ],
              onPressed: (index) {
                setState(() {
                  _isButtonSelected = !_isButtonSelected;
                });
              },
              isSelected: [_isButtonSelected, !_isButtonSelected],
              color: Colors.grey,
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
