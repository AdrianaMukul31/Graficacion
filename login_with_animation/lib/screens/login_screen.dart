import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // Debe estar en el State

  //cerebro de la logica de aanimacciones SMI
  StateMachineController? controller; //los signos verifican que todo este bien
  SMIBool? isChecking; //activa la animacion de checar o ver lo que escribes
  SMIBool? isHandsUp;  //se tapa los ojos
  SMIBool? trigSuccess; //se emociona o se pone feliz
  SMIBool? trigFail;    //animacion de fracaso o se pone triste


  @override
  Widget build(BuildContext context) {
    //consulta el tamaño de la pantalla
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'assets/animated_login_character.riv',
                  stateMachines: ["Login Machine"],
                  //Al iniciarse
                  onInit: (artboard){
                    controller = 
                    StateMachineController.fromArtboard(
                      artboard,
                      "Login Machine",
                      );
                      //verificar que inicio bien
                      if(controller == null) return;
                      artboard.addController(controller!);
                      //asignar las variables y enlazarlas
                      isChecking  = controller!.findSMI('isChecking');
                      isHandsUp   = controller!.findSMI('isHandsUp');
                      trigSuccess = controller!.findSMI('trigSuccess');
                      trigFail    = controller!.findSMI('trigFail');
                  },
                ),
              ),
              const SizedBox(height: 20),
              //Email
              TextField(
                onChanged: (value) {
                  //si el valor es mayor a 0 activa la animacion de checar
                  if(isHandsUp != null){
                    //No tapar los ojos al escribir email
                    isHandsUp!.change(false);
                  }
                  if(isChecking == null) return;
                  //Activa el modo chismoso
                  isChecking!.change(true);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Password
              TextField(
                onChanged: (value) {
                  //si el valor es mayor a 0 activa la animacion de checar
                  if(isHandsUp != null){
                    //No tapar los ojos al escribir email
                    isHandsUp!.change(true);
                  }
                  if(isChecking == null) return;
                  //Activa el modo chismoso
                  isChecking!.change(false);
                },
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                        isHandsUp!.change(false);
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Texto "Forgot Password?" alineado a la derecha
              SizedBox(
                width:size.width,
                child: const Text("Forgot Password?", 
                //Aliniar a la derecha
                textAlign: TextAlign.right,
                style: TextStyle(decoration: TextDecoration.underline),
                ),
                ),
                //Boton de login
              const SizedBox(height: 10),
              MaterialButton(
              minWidth:size.width,
              height: 50,
              color: Colors.purple,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
                onPressed: () {},
                child: Text("Login", 
                style: TextStyle(
                  color: Colors.white)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [                  
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Sign Up",
                     style: TextStyle(
                      color: Colors.black,
                      //en negritas
                      fontWeight: FontWeight.bold,
                      //subrayado
                      decoration: TextDecoration.underline,
                      ),
                      ),
                  ),
                ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}