import 'package:flutter/material.dart';

void main() {
  runApp(const RosaryApp());
}

class RosaryApp extends StatelessWidget {
  const RosaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rosary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const RosaryPage(),
    );
  }
}

class RosaryPage extends StatefulWidget {
  const RosaryPage({super.key});

  @override
  State<RosaryPage> createState() => _RosaryPageState();
}

class _RosaryPageState extends State<RosaryPage> {
  int counter = 0; // عداد التسبيحات الحالية
  int index = 0; // لتحديد العبارة الحالية
  bool isFinished = false; // لمعرفة هل انتهى التسبيح أم لا

  final List<String> tasbeehList = [
    'سبحان الله',
    'الحمد لله',
    'الله أكبر',
  ];

  void _increment() {
    if (isFinished) return; // إذا انتهى التسبيح لا نفعل شيئاً

    setState(() {
      counter++;

      if (counter == 33) {
        // عند الوصول لـ 33
        if (index < 2) {
          // لم نصل للعبارة الأخيرة بعد
          index++;
          counter = 0; // نعيد العداد للصفر وننتقل للعبارة التالية
        } else {
          // انتهت جميع التسبيحات (99)
          isFinished = true;
          _showFinishDialog();
        }
      }
    });
  }

  void _reset() {
    setState(() {
      counter = 0;
      index = 0;
      isFinished = false;
    });
  }

  void _showFinishDialog() {
    // رسالة تنبيه عند الانتهاء
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم التسبيح 🎉'),
        content: const Text('لقد أكملت التسبيح 99 مرة.\nجزاك الله خيراً ❤'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('السبحة الإلكترونية'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isFinished
                    ? 'انتهيت من التسبيح'
                    : tasbeehList[index], // عرض العبارة الحالية
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  isFinished ? '✔' : '$counter', // يظهر صح عند الانتهاء
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: isFinished ? null : _increment, // يعطل الزر عند الانتهاء
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isFinished ? Colors.grey : Colors.teal, // لون مختلف
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'تسبيح',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.teal, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'إعادة البدء',
                  style: TextStyle(fontSize: 20, color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
      ),
  );
}
}
