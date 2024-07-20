import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          Expanded(
            child: ListView(
              children: [
                LanguageOption(
                  language: 'English',
                  flag: 'https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg',
                  isSelected: selectedLanguage == 'English',
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'English';
                    });
                  },
                ),
                LanguageOption(
                  language: 'Bahasa',
                  flag: 'https://upload.wikimedia.org/wikipedia/commons/9/9f/Flag_of_Indonesia.svg',
                  isSelected: selectedLanguage == 'Bahasa',
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'Bahasa';
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageOption extends StatelessWidget {
  final String language;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOption({
    Key? key,
    required this.language,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.lightBlue[100],
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Image.network(
              flag,
              width: 30.0,
              height: 20.0,
            ),
            SizedBox(width: 10.0),
            Text(
              language,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}