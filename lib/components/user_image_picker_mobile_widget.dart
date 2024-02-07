import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// IMAGE PICKER PARA PLATAFORMA MOBILE
class UserImagePickerMobileWidget extends StatefulWidget {
  // receber do authForm para definir a imagem do Formulario igual a imagem
  // que vai ser selecionada da galeria
  final void Function(File image) onImagePick;
  const UserImagePickerMobileWidget({super.key, required this.onImagePick});

  @override
  State<UserImagePickerMobileWidget> createState() =>
      _UserImagePickerStateMobileWidget();
}

class _UserImagePickerStateMobileWidget
    extends State<UserImagePickerMobileWidget> {
  // android image
  File? _mobileImage;

  // Pegar imagem da galeria
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      // OPCIONAL -> Diminuir a resolução pra não ocupar todo espaço do firebase
      // imageQuality: 50,
      // maxWidth: 150,
    );
    // se não escolher nenhuma imagem vai acabar aqui
    if (pickedImage == null) return;
    // tirar mounted se der erro!!!!!!
    if (mounted) {
      setState(() {
        _mobileImage = File(pickedImage.path);
      });
      widget.onImagePick(_mobileImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _mobileImage != null ? FileImage(_mobileImage!) : null,
        ),
        TextButton.icon(
          icon: Icon(
            Icons.image,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: const Text('Adicionar Imagem'),
          onPressed: () => _pickImage(),
        ),
      ],
    );
  }
}
