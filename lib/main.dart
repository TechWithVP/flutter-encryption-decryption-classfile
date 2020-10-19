import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'my_encryption.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tec = TextEditingController();
  var encryptedText, plainText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption/Decryption"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: tec,
              ),
            ),
            Column(
              children: [
                Text(
                  "PLAIN TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(plainText == null ? "" : plainText),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "ENCRYPTED TEXT",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(encryptedText == null
                      ? ""
                      : encryptedText is encrypt.Encrypted
                          ? encryptedText.base64
                          : encryptedText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    plainText = tec.text;
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.encryptFernet(plainText);
                    });
                    tec.clear();
                  },
                  child: Text("Encrypt"),
                ),
                SizedBox(width: 15,),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      encryptedText =
                          MyEncryptionDecryption.decryptFernet(encryptedText);
                      print("Type: " + encryptedText.runtimeType.toString());
                    });
                  },
                  child: Text("Decrypt"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
