import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:placed_web/appwrite/appwrite_auth/appwrite_auth.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {

  String userId = '';
  String secret = '';

  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  TextEditingController confirmPasswordController = TextEditingController();
  bool showConfirmPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveFromUrl();
  }

  void retrieveFromUrl() {
    Uri uri = Uri.parse(html.window.location.href);
    setState(() {
      userId = uri.queryParameters['userId'] ?? '';
      secret = uri.queryParameters['secret'] ?? '';
    });
  }

  @override
  void dispose(){
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placed Password Recovery')
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: showPassword,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      }, icon: showPassword ? const Icon(Icons.lock) : const Icon(Icons.lock_open))
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    controller: confirmPasswordController,
                    obscureText: showConfirmPassword,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      }, icon: showConfirmPassword ? const Icon(Icons.lock) : const Icon(Icons.lock_open))
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: OutlinedButton(onPressed: () {
                    if(formKey.currentState!.validate()){
                      AppWriteAuth.updatePassword(userId, secret, passwordController.text, confirmPasswordController.text).then((value) {
                        if(value.$createdAt.isNotEmpty){
                          showDialog(context: context, builder: (ctx) {
                            return const AlertDialog(
                              title: Text('Password updated successfully!'),
                            );
                          });
                        }
                        else if(value.$createdAt.isEmpty){
                          showDialog(context: context, builder: (ctx) {
                            return const AlertDialog(
                              title: Text('An error occurred!'),
                            );
                          });
                        }
                        else{
                          showDialog(context: context, builder: (ctx) {
                            return const AlertDialog(
                              content: Center(child: CircularProgressIndicator(),),
                            );
                          });
                        }
                      });
                    }
                  }, child: const Text('Update Password')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
