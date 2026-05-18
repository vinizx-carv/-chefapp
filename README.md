# 🍽️ ChefApp

Aplicativo mobile de receitas desenvolvido em **Flutter/Dart** como projeto final da disciplina de Desenvolvimento Mobile — ICEV.

---

## 📱 Sobre o Projeto

O **ChefApp** é um app de descoberta e gerenciamento de receitas culinárias. O usuário pode explorar receitas aleatórias, buscar por categorias, visualizar detalhes de preparo e salvar suas favoritas localmente.

---

## ✅ Funcionalidades Implementadas

- 🏠 **Tela Home** — Destaques, categorias e receitas aleatórias
- 🔍 **Tela de Busca** — Pesquisa de receitas com resultados em tempo real
- 📄 **Tela de Detalhes** — Informações completas da receita selecionada
- ❤️ **Favoritos** — Salvamento local de receitas favoritas (SQLite)
- 🔄 **Consumo de API REST** — Integração com API pública de receitas
- 📦 **Armazenamento Local** — CRUD completo de favoritos persistido no dispositivo
- 🧭 **Navegação com rotas nomeadas** entre todas as telas

---

## 🏗️ Arquitetura do Projeto

```
lib/
├── controllers/          # Gerenciamento de estado (stores)
│   ├── home_controller.dart
│   ├── meal_detail_store.dart
│   ├── notes_store.dart
│   ├── random_meal_store.dart
│   └── search_store.dart
├── core/
│   ├── constants/
│   │   └── enums.dart
│   ├── database/
│   │   └── database_service.dart  # SQLite — operações CRUD
│   ├── http/
│   │   └── http_client.dart       # Cliente HTTP para requisições à API
│   ├── listeners/
│   │   ├── favorite_listener.dart
│   │   └── favorite_notifier.dart
│   ├── repositories/
│   │   └── meal_repository.dart   # Camada de acesso a dados
│   └── models/                    # Classes de dados
│       ├── category_model.dart
│       ├── meal_model.dart
│       ├── meal_summary_model.dart
│       └── receita_model.dart
│   
└── views/                     # Telas e widgets
    ├── busca/
    │   ├── widget/
    │   │   ├── search_header.dart
    │   │   └── search_results.dart
    │   └── buscar_screen.dart
    ├── favorites/
    │   └── favorits_screen.dart
    ├── home/
    │   ├── widget/
    │   │   ├── categoria_section.dart
    │   │   ├── category_card.dart
    │   │   ├── destaque_hero_card.dart
    │   │   ├── destaque_section.dart
    │   │   ├── home_header.dart
    │   │   ├── meal_list_item.dart
    │   │   ├── random_meal_card.dart
    │   │   └── sugestion.dart
    │   └── home_screen.dart
    ├── receita/
    │   ├── widget/
    │   │   └── recipe_details_page.dart
    └── shared/
        ├── bottonNavigationBar.dart
        ├── cook_mode.dart
        └── receita_card.dart
```

---

## 🌐 API Utilizada

**TheMealDB** — API pública e gratuita de receitas culinárias.

- Base URL: `https://www.themealdb.com/api/json/v1/1/`
- Endpoints utilizados:
  - `random.php` — receita aleatória
  - `categories.php` — listagem de categorias
  - `search.php?s={nome}` — busca por nome
  - `lookup.php?i={id}` — detalhes de uma receita 
  - `filter.php?c={categoria}` — receitas por categoria

Não é necessária autenticação.

---

## 🛠️ Tecnologias e Dependências

| Tecnologia | Uso |
|---|---|
| Flutter | Framework principal |
| Dart | Linguagem de programação |
| HTTP | Requisições à API REST |
| SQLite / sqflite | Armazenamento local (favoritos) |
| setState | Gerenciamento de estado |

---

## ▶️ Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.x ou superior)
- Dart SDK (incluso no Flutter)
- Android Studio ou VS Code com extensão Flutter
- Emulador Android/iOS ou dispositivo físico conectado

### Passo a passo

```bash
# 1. Clone o repositório
git clone hhttps://github.com/Vinizx-carv/-ChefApp.git

# 2. Acesse a pasta do projeto
cd chefapp

# 3. Instale as dependências
flutter pub get

# 4. Execute o aplicativo
flutter run
```

> 💡 Para rodar em um dispositivo específico, use `flutter run -d <device_id>`.  
> Liste os dispositivos disponíveis com `flutter devices`.

### Build para produção

```bash
# Android (APK)
flutter build apk --release

# Android (App Bundle para Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release
```

---

## 📋 Requisitos Atendidos

| Requisito | Status |
|---|---|
| Interface com layout responsivo | ✅ |
| Formulário com validação e componente interativo | ✅ |
| Navegação entre ≥ 3 telas com rotas nomeadas | ✅ |
| Consumo de API REST com async/await | ✅ |
| Armazenamento local com CRUD completo | ✅ |
| Gerenciamento de estado (StatefulWidget + store) | ✅ |
| Tratamento de erros e feedback ao usuário | ✅ |

---

## 👥 Integrantes do Grupo

- Vinicius de Carvalho
- Gustavo Wilson
- Eike

---

## 📅 Informações da Disciplina

- **Disciplina:** Desenvolvimento Mobile
- **Instituição:** ICEV — Instituto de Ensino Superior