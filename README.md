# AssocSys

## Table of Contents

- [Firebase Authentication and Storage Service](#firebase-authentication-and-storage-service)
  - [Autenticação](#autenticação)
  - [Manipulação de Imagens](#manipulação-de-imagens)
  - [Firestore](#firestore)
- [Getting Started](#getting-started)
  - [Pré-requisitos](#pré-requisitos)
  - [Instalação](#instalação)
- [Uso](#uso)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Firebase Authentication and Storage Service

Este é um serviço de autenticação e armazenamento baseado no Firebase, utilizado no projeto [Nome do Projeto]. O serviço abrange a autenticação de usuários, manipulação de imagens e interação com o Firestore para armazenamento de dados.

### Autenticação

O serviço utiliza o Firebase Authentication para gerenciar a autenticação de usuários. A autenticação é realizada por meio de e-mail e senha, utilizando a função `login`, `signup` e `logout`.

```dart
// Login
await AuthFirebaseService().login(email, password);

// Signup
await AuthFirebaseService().signup(
    name, email, password, image, registrationNumber, birthDate, registrationDate
);

// Logout
await AuthFirebaseService().logout();
```


### Manipulação de Imagens
A manipulação de imagens é tratada pela função _uploadUserImage, que faz upload de uma imagem para o Firebase Storage e retorna a URL da imagem. Esta função é utilizada durante o processo de signup para adicionar a foto do usuário ao perfil.

```dart
// Upload de imagem do usuário
String? imageUrl = await _uploadUserImage(image, imageName);
```

### Firestore
O serviço interage com o Firestore para salvar e recuperar dados associados aos usuários. A classe AuthFirebaseService possui funções privadas _saveAssociateOnDb e _getAssociateFromDb que são utilizadas para salvar e recuperar informações do usuário no Firestore.

```dart
// Salvar usuário no Firestore
await _saveAssociateOnDb(user);

// Recuperar informações do usuário do Firestore
AssociateModel? user = await _getAssociateFromDb(uid);
```
Certifique-se de configurar corretamente o Firebase no seu projeto e definir as regras de segurança no Firestore para garantir a integridade e segurança dos dados.

Observação: Este README assume que o ambiente do Firebase está configurado corretamente no projeto, e as dependências necessárias estão instaladas. Certifique-se de seguir as orientações de configuração do Firebase para garantir o funcionamento adequado deste serviço.






