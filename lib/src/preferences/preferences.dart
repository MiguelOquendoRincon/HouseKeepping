import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{

  static UserPreferences _instancia = new UserPreferences._internal();
  SharedPreferences _prefs;
  

  factory UserPreferences(){
    return _instancia;
  }
  UserPreferences._internal();
  


  static UserPreferences getInstPref(){
    if(_instancia == null) _instancia = new UserPreferences._internal();

    return _instancia; 
  }

  void loadPrefs() async{
    _prefs = await SharedPreferences.getInstance();
  }

                                           
//   ####  ###### ##### ##### ###### #####  
//  #      #        #     #   #      #    # 
//   ####  #####    #     #   #####  #    # 
//       # #        #     #   #      #####  
//  #    # #        #     #   #      #   #  
//   ####  ######   #     #   ###### #    # 
  set totalTime(String time) => _prefs.setString('totalTime', time); 



//   ####  ###### ##### ##### ###### #####  
//  #    # #        #     #   #      #    # 
//  #      #####    #     #   #####  #    # 
//  #  ### #        #     #   #      #####  
//  #    # #        #     #   #      #   #  
//   ####  ######   #     #   ###### #    # 

  get totalTime => _prefs.getString('totalTime') ?? ' ';


}