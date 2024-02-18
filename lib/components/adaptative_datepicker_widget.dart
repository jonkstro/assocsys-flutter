import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  // O componente pai vai enviar esse método que vai alterar lá no formdata a
  // data que vai ser recebida aqui no componente
  final Function(DateTime) onDateChange;
  const AdaptativeDatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  // Método que vai pegar a data
  _showDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      // Define a localização para português do Brasil
      locale: const Locale('pt', 'BR'),
    ).then((value) {
      // se não pegar a data, se cancelar por exemplo, morre aqui
      if (value == null) return;
      // se alterar a data, vai atualizar aqui
      onDateChange(value);
    });
  }

  Widget _getDatePicker(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preencha sua data de nascimento',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      // : _selectedDate.toString(),
                      : DateFormat('dd/MM/y').format(selectedDate!),
                ),
              ),
              TextButton(
                onPressed: () {
                  _showDatePicker(context);
                },
                child: Text(
                  selectedDate == null
                      ? 'Escolha uma data'
                      : 'Selecione outra data',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium?.fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        // WEB
        ? _getDatePicker(context)
        : Platform.isIOS
            // IOS
            ? SizedBox(
                height: 180,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  minimumDate: DateTime(2019),
                  maximumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: onDateChange,
                ),
              )
            // ANDROID
            : _getDatePicker(context);
  }
}
