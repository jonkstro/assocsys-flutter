import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// IMAGE PICKER PARA PLATAFORMA WEB
class UserImagePickerWebWidget extends StatefulWidget {
  // receber do authForm para definir a imagem do Formulario igual a imagem
  // que vai ser selecionada da galeria
  final void Function(Uint8List image) onImagePick;
  const UserImagePickerWebWidget({super.key, required this.onImagePick});

  @override
  State<UserImagePickerWebWidget> createState() =>
      _UserImagePickerWebWidgetState();
}

class _UserImagePickerWebWidgetState extends State<UserImagePickerWebWidget> {
  // web image
  Uint8List _webImage = Uint8List(8);

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
      final file = await pickedImage.readAsBytes();
      setState(() {
        _webImage = file;
      });
      widget.onImagePick(_webImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: MemoryImage(_webImage),
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
