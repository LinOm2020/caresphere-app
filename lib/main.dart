import 'package:flutter/material.dart';

void main() {
  runApp(const CareApp());
}

class CareApp extends StatelessWidget {
  const CareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareSphere',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _notes = [];
  final TextEditingController _controller = TextEditingController();

  void _addNote() {
    if (_controller.text.trim().isEmpty) return;
    
    setState(() {
      _notes.add(_controller.text);
    });
    
    _controller.clear();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Заметка добавлена ✓')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareSphere'),
        centerTitle: true,
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_alt_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text('Нажми "+" и добавь первую заметку', 
                       textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(_notes[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Новая заметка'),
              content: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Например: Маме позвонить завтра в 10:00',
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
                ElevatedButton(
                  onPressed: () {
                    _addNote();
                    Navigator.pop(context);
                  },
                  child: const Text('Добавить'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
