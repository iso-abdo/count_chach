import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/home/home_provider.dart';
import 'home_provider.dart';
import '../../core/layout/main_layout.dart';
import '../../core/layout/home_provider.dart';

class LockView extends StatefulWidget {
  @override
  _LockViewState createState() => _LockViewState();
}

class _LockViewState extends State<LockView> {

  final TextEditingController codeController = TextEditingController();

  // 🔥 الأكواد المتاحة
  final List<String> validCodes = [
  "a5598x","b8789z","c7611w","a7511x","b5943z","c7895w","a1975x","a9770z","b2908w","c8276x",
  "a6711z","b4377w","c2835x","a1939z","a4646w","b7663x","c8446z","a3420w","b1621x","c4440z",
  "a8913w","a1642x","b4832z","c7855w","a9624x","b7432z","c5015w","a2914x","a3915z","b6508w",
  "c3825x","a2399z","b5911w","c7920x","a2109z","a9346w","b1305x","c2476z","a9002w","b3234x",
  "c6188z","a2557w","a3791x","b1470z","c1341w","a5676x","b4902z","c4796w","a4477x","a5007z",
  "b8100w","c8575x","a2581z","b1641w","c1451x","a4869z","a6194w","b9852x","c3225z","a7187w",
  "b7263x","c1951z","a9925w","a3847x","b9062z","c7500w","a6902x","b5920z","c5013w","a2290x",
  "a2890z","b6684w","c3682x","a8973z","b2949w","c1338x","a7914z","a9410w","b2773x","c5931z",
  "a4470w","b4368x","c9183z","a7150w","a9033x","b6975z","c3416w","a7721x","b3110z","c2602w",
  "a7188x","a5948z","b6740w","c3583x","a5323z","b5074w","c6762x","a4698z","a2172w","b1693x",
  "c7879z","a5373w","b2808x","c2701z","a2678w","a1256x","b4102z","c7939w","a6337x","b8792z",
  "c8872w","a4522x","a2772z","b5014w","c1458x","a1433z","b9833w","c1742x","a4126z","a5175w",
  "b3889x","c2518z","a6166w","b1822x","c1481z","a5370w","a7279x","b7773z","c8542w","a6037x",
  "b3184z","c6784w","a7699x","a6636z","b5208w","c7307x","a5422z","b3281w","c4990x","a7024z",
  "a9987w","b5016x","c3423z","a6838w","b4947x","c1766z","a8919w","a6720x","b3976z","c6335w",
  "a5597x","b7062z","c3973w","a9434x","a7961z","b3824w","c2626x","a6343z","b4314w","c3732x",
  "a6205z","a5457w","b2688x","c8501z","a9559w","b5976x","c2294z","a1811w","a4307x","b1672z",
  "c4395w","a4843x","b8799z","c7310w","a1509x","a6840z","b4096w","c5414x","a6835z","b3726w",
  "c2391x","a5111z","a1746w","b7185x","c5574z","a1379w","b3383x","c7797z","a8381w","a9761x",
  "b6130z","c3777w","a2918x","b3472z","c3747w","a7745x","a6450z","b1599w","c6487x"
  ];

  void checkCode() {
    final provider = Provider.of<HomeProvider>(context, listen: false);

    String input = codeController.text.trim();

    if (!validCodes.contains(input)) {
      showMessage("❌ كود غير صحيح");
      return;
    }

    if (provider.usedCodes.contains(input)) {
      showMessage("❌ الكود مستخدم قبل كده");
      return;
    }

    // ✅ تفعيل
    provider.usedCodes.add(input);
    provider.isActivated = true;
    provider.saveData();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainLayout()),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفعيل التطبيق")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: "ادخل كود التفعيل",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: checkCode,
              child: Text("دخول"),
            ),
          ],
        ),
      ),
    );
  }
}