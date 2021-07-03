import 'package:ecom/provider/model_hud.dart';
import 'file:///E:/AndroidProjects/e_com/lib/screens/admin_screens/admin_home.dart';
import 'file:///E:/AndroidProjects/e_com/lib/screens/user_screens/sign_up_screen.dart';
import 'file:///E:/AndroidProjects/e_com/lib/screens/user_screens/user_home.dart';
import 'package:ecom/services/auth.dart';
import 'package:ecom/src/constants.dart';
import 'package:ecom/src/string_constants.dart';
import 'package:flutter/material.dart';
import 'file:///E:/AndroidProjects/e_com/lib/widgets/user_screens_widgets/log_screen_widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=Auth();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String mail,pass;

  bool keepMeLogin=false;

  @override
  Widget build(BuildContext context) {
   final height= MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kMainColor,

      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading ,
        child: Form(
          key: _globalKey,

          child: ListView(

            children: <Widget>[
              AppLogo(height: height),

              SizedBox(height: height*0.1,),

              LogCustomTextField(hintText: 'Enter Your Email',myIcon: Icons.email,
              function: (value){mail=value;},
              ),

              SizedBox(height: height*0.02,),

              LogCustomTextField(hintText: 'Enter Your Password',myIcon: Icons.lock,
              function: (value){pass=value;},
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      checkColor: kMainColor.withOpacity(0.5),
                      activeColor: Colors.white,
                      value:keepMeLogin,
                      onChanged: (value){
                        setState(() {
                          keepMeLogin=value;
                        });

                      }, ),
                    Text('Remember Me',style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),

              SizedBox(height: height*0.05,),






              Builder(
                builder: (context)=> LogButton(btnText: 'Login',
                    function: (){
                  if(keepMeLogin)
                    {
                      keepUserLogin();
                    }
                  validateLogIn(context);
                } ),
              ),

              SizedBox(height: height*0.1,),

              Row(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: <Widget>[

                  Text('Don\'t have an account? ',style: TextStyle(color: Colors.white,fontSize: 16),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text('Sign Up',style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold ),))

                ],
              )



            ],
          ),
        ),
      ),
    );
  }

  validateLogIn(BuildContext context)
  async{

    var modelHud=Provider.of<ModelHud>(context,listen: false);
    if(_globalKey.currentState.validate())

      try{
        modelHud.changeIsloading(true);
        _globalKey.currentState.save();
        final authResult= await _auth.signIn(mail.trim(), pass.trim());
        modelHud.changeIsloading(false);
        if(mail=='admin@admin.com')
          Navigator.of(context).pushNamed(AdminHome.id);
        else
          Navigator.of(context).pushNamed(UserHome.id);


      }catch(e){
        modelHud.changeIsloading(false);
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message)));
      }

  }

  void keepUserLogin() async{

    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setBool(kKeepMeLog, keepMeLogin);

  }
}
