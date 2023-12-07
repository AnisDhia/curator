import 'package:curator/features/dashboard/widgets/search_field.dart';
import 'package:curator/features/navigation/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 50.w,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                children: [
                  SearchField(controller: TextEditingController(), hintText: 'Username'),
                  SizedBox(height: 4.h,), 
                  SearchField(controller: TextEditingController(), hintText: 'Password'),
                  SizedBox(height: 4.h,),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     hintText: 'Username',
                //   ),
                // ),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     hintText: 'Password',
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navigation()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid credentials')));
                    }
                  },
                  child: const Text('Login'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
