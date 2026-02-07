import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medapp_frontend/auth/componets/my_textField.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medapp_frontend/providers/auth_provider.dart';
class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final loginemailCtrl = TextEditingController();
final loginpassCtrl = TextEditingController();

final isloading =ref.watch(authProvider).isLoading;
ref.listen(authProvider, (previous, next) {
  if (previous?.error != next.error && next.error != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(next.error!)),
    );
  }
});

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Welcome',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),

              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/healthCare.webp'),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 100,
                width: 200,
                child: Image.asset('assets/images/consultOne.png'),
              ),
              SizedBox(height: 10),
              Text(
                'your health deserves attention, not waiting',
                style: GoogleFonts.manrope(fontSize: 15, color: Colors.grey),
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Email',
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),

              MyTextField(
                controller: loginemailCtrl,
                hint: 'abc123@email.com',
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Password',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: Colors.white
                    ),
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              MyTextField(
                controller: loginpassCtrl,
                hint: '* * * * *', prefixIcon: Icons.lock),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Login',
                    style: GoogleFonts.bungee(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: (){},
                child: Text(
                  "Don't have an account? Sign Up",
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
