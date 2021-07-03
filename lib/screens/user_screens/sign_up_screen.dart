import 'package:ecom/provider/model_hud.dart';
import 'package:ecom/screens/user_screens/login_screen.dart';
import 'package:ecom/services/auth.dart';
import 'package:ecom/src/constants.dart';
import 'file:///E:/AndroidProjects/e_com/lib/widgets/user_screens_widgets/log_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';



class SignUpScreen extends StatelessWidget {
  static String id ='sign_up_screen';

  String _mail;
  String _pass;
  final _auth=Auth();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {



    final height= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key:_globalKey,
          child: ListView(



            children: <Widget>[
              AppLogo(height: height),

              SizedBox(height: height*0.1,),

              LogCustomTextField(hintText: 'Enter Your Name',myIcon: Icons.perm_identity,function: (value)
              {

              },),

              SizedBox(height: height*0.02,),

              LogCustomTextField(hintText: 'Enter Your Email',myIcon: Icons.email,function: (value){
                _mail=value;
              },),

              SizedBox(height: height*0.02,),

              LogCustomTextField(hintText: 'Enter Your Password',myIcon: Icons.lock,function: (value){

                _pass=value;

              },),


              SizedBox(height: height*0.05,),

              Builder(
                builder: (context)=> LogButton(
                  btnText: 'Sign Up',
                  function: () async{

                    var modelHud=Provider.of<ModelHud>(context,listen: false);

                  if(_globalKey.currentState.validate())
                    {

                      try {
                        modelHud.changeIsloading(true);
                        _globalKey.currentState.save();

                      final authResult= await _auth.signUp(_mail.trim(), _pass.trim());
                        modelHud.changeIsloading(false);



                      }
                      catch(e){

                        modelHud.changeIsloading(false);
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message)
                        ));

                      }
                    }

                    },),
              ),

              SizedBox(height: height*0.1,),

              Row(
                mainAxisAlignment:MainAxisAlignment.center ,
                children: <Widget>[

                  Text('Do have another account?  ',style: TextStyle(color: Colors.white,fontSize: 16),),

                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text('Log In',style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold ),))

                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}

