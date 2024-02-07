import 'package:assocsys/pages/auth_page.dart';
import 'package:assocsys/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
// Necessário para user DatePicker
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // Inicializar o pacote dotenv carregando as variáveis de ambiente
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // MÉTODO QUE FOI CRIADO SÓ PRA PODER CARREGAR NO APP AS DATAS PT_BR
  get _localeDateTime {
    // Inicialize o sistema de localização. Senão vai pegar tudo em ingles
    initializeDateFormatting('pt_BR', null);
  }

  @override
  Widget build(BuildContext context) {
    // Configurar para PT-BR
    _localeDateTime;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: AuthPage(),
      // Configuração dos DatePicker e TimePickers e outros (calendario, moedas)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR')
      ], // Adicione o locale desejado
    );
  }
}
