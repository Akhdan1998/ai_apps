part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PrefServices _prefServices = PrefServices();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _prefServices.readCache('emailGoogle').then((value) {
      print(value.toString());
      if (value != null) {
        return Get.to(HomePage(value));
      } else {
        return LoginPage();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (darkLight != true) ? dasarDark : textDark,
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/loginGoogle.png', scale: 2),
            const SizedBox(height: 20),
            Text(
              'Halo Bunda,',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.bold,
                color: (darkLight != true) ? textDark : textLight9,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Silahkan Login atau Mendaftar untuk melanjutkan fitur parentoday.ai',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.w300,
                color: (darkLight != true) ? textDark : textLight10,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: (darkLight != true) ? dasarDark : textDark,
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: GestureDetector(
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            await signInWithGoogle().then((result) {}).catchError((error) {});
          },
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: (darkLight != true) ? dasarDark : textDark,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: (darkLight != true) ? textDark : shadow,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Container(
              child: (isLoading == true)
                  ? Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: (darkLight != true) ? textDark : warnaUtama,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png', scale: 2),
                        const SizedBox(width: 5),
                        Text(
                          'Masuk/Daftar dengan Google',
                          style: GoogleFonts.poppins().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: (darkLight != true) ? textDark : textLight11,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
