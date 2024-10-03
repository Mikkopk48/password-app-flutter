import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
class HomeScreen extends StatefulWidget {


  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final _formKey = GlobalKey<FormState>();

final _passwordCtrl = TextEditingController();

ValueNotifier<PasswordStrength?> passNotifier = ValueNotifier<PasswordStrength?>(null);

bool isVisible = true;

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Scaffold(
      body:Padding(padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            Text('Register 🔐',style:textTheme.titleLarge,),
            const SizedBox(height: 15,),
            Text(PasswordStrength.instructions),
            const SizedBox(height: 20,),
            TextField(
            controller : _passwordCtrl,
            obscureText: !isVisible,
            decoration:  InputDecoration(
              labelText:'Password',
              border:const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
              isVisible
              ? Icons.visibility
              : Icons.visibility_off,
              size: 20,
                ),
                onPressed: () {
                  setState((){
                  isVisible = !isVisible;
              });
            },
              ),
            ),
            onChanged: (value){
              passNotifier.value = PasswordStrength.calculate(text: value);
            } ,
            ), SizedBox(height: 30,),
            PasswordStrengthChecker(
              strength: passNotifier),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: MaterialButton(
                  color: Colors.black87,
                  child: const Text('Generate Password',style: TextStyle(color: Colors.white),),
                  onPressed:() {
                    PasswordGeneratorConfiguration config = const PasswordGeneratorConfiguration(
                      length:32,
                      minUppercase: 8,
                      minSpecial: 8,
                      minDigits: 4,
                      minLowercase: 2
                      );
                      const SizedBox(height: 20,);
                      final passwordGenerator = PasswordGenerator.fromConfig(configuration: config);
                      final password = passwordGenerator.generate();
                      setState(() {
                        _passwordCtrl.text = password;
                        passNotifier.value = PasswordStrength.calculate(text: password);
                      });
                  },),
              )
          ],
          ),
        ),
      )
      );
  }
}