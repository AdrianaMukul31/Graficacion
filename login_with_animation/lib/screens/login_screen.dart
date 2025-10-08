import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Estado local
  bool _obscurePassword = true;

  // Cerebro de la lógica de animaciones SMI (Rive)
  StateMachineController? controller; 
  SMIBool? isChecking; // activa la animación de checar o ver lo que escribes
  SMIBool? isHandsUp; // se tapa los ojos
  SMIBool? trigSuccess; // se emociona o se pone feliz
  SMIBool? trigFail; // animacion de fracaso o se pone triste

  // 1) FocusNode
  final emailFocus = FocusNode();
  final passFocus = FocusNode();

  // 2) Listeners (Oyentes/Chismosito)
  @override
  void initState() {
    super.initState();
    
    // Listener para el campo de Email
    emailFocus.addListener(() {
      setState(() {
        if (emailFocus.hasFocus) {
          isHandsUp?.change(false);
          isChecking?.change(true); // Activa la animación "checking" al enfocarse
        } else {
          isChecking?.change(false); // Desactiva al perder el foco
        }
      });
    });

    // Listener para el campo de Contraseña (CORREGIDO: Ahora dentro de initState)
    passFocus.addListener(() {
      setState(() {
        // Manos arriba en password (tapa los ojos)
        isHandsUp?.change(passFocus.hasFocus);
        // Desactiva la animación "checking" cuando está en el campo de contraseña
        isChecking?.change(false);
      });
    });
  }

  // 3) Dispose (Limpieza para evitar pérdidas de memoria)
  @override
  void dispose() {
    // Es crucial liberar los recursos de FocusNode y Rive Controller
    emailFocus.dispose();
    passFocus.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        // Se envuelve en SingleChildScrollView para evitar desbordamiento al abrir el teclado
        child: SingleChildScrollView( 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 200,
                  child: RiveAnimation.asset(
                    'assets/animated_login_character.riv',
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                        artboard,
                        "Login Machine",
                      );
                      if (controller == null) return;
                      artboard.addController(controller!);
                      // Asignar las variables y enlazarlas
                      isChecking = controller!.findSMI<SMIBool>('isChecking');
                      isHandsUp = controller!.findSMI<SMIBool>('isHandsUp');
                      trigSuccess = controller!.findSMI<SMIBool>('trigSuccess');
                      trigFail = controller!.findSMI<SMIBool>('trigFail');
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Email
                TextField(
                  focusNode: emailFocus, // Asignación de FocusNode
                  onChanged: (value) {
                    // La lógica principal de isChecking está en el FocusListener, 
                    // pero se puede dejar aquí para el efecto "chismoso" mientras se escribe
                    isChecking?.change(value.isNotEmpty);
                    isHandsUp?.change(false);
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
                // Password
                TextField(
                  focusNode: passFocus, // Asignación de FocusNode
                  onChanged: (value) {
                    // No es necesario cambiar la lógica de manos aquí, se gestiona con el focusListener.
                    // Si quieres que las manos se levanten solo si hay focus Y estás escribiendo:
                    // isHandsUp?.change(passFocus.hasFocus);
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
                          // Quitar manos al mostrar el password, si está visible no se tapa la cara
                          isHandsUp?.change(_obscurePassword && passFocus.hasFocus);
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Texto "Forgot Password?" alineado a la derecha
                SizedBox(
                  width: size.width,
                  child: const Text(
                    "Forgot Password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                // Boton de login
                const SizedBox(height: 10),
                MaterialButton(
                  minWidth: size.width,
                  height: 50,
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    // Ejemplo: llamar a trigSuccess o trigFail al presionar el botón
                    // trigSuccess?.change(true); 
                    // trigFail?.change(true);
                  },
                  child: const Text("Login", style: TextStyle(color: Colors.white)),
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
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}