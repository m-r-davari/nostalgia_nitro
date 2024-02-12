import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {

  final SharedPreferences prefs;
  SharedPrefUtil(this.prefs);

  void saveHiScore(int hiScore)async{
    await prefs.setInt('HiScore', hiScore);
  }

  int loadHiScore(){
    return prefs.getInt('HiScore') ?? 0;
  }

  void removeHighScore()async{
    await prefs.remove('HiScore');
  }

}