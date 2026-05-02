# Документация Проекта

## О проекте

Проект: `GlobalStay`

Текущее состояние:
- настроен splash screen с логотипом;
- добавлен onboarding из 3 экранов;
- проект разложен по feature-структуре для дальнейшего роста.

## Структура `lib`

```text
lib/
  app/
    app.dart
  features/
    splash/
      presentation/
        splash_screen.dart
    onboarding/
      presentation/
        onboarding_screen.dart
        widgets/
          page_indicator.dart
          status_bar.dart
    home/
      presentation/
        home_screen.dart
  main.dart
```

## Назначение файлов

### `lib/main.dart`
- точка входа приложения;
- включает `SystemUiMode.immersiveSticky`;
- запускает `GlobalStayApp`.

### `lib/app/app.dart`
- корневой `MaterialApp`;
- хранит базовую тему приложения;
- задает стартовый экран.

### `lib/features/splash/presentation/splash_screen.dart`
- экран сплэша;
- показывает логотип;
- через короткую задержку переводит пользователя на onboarding.

### `lib/features/onboarding/presentation/onboarding_screen.dart`
- основной экран онбординга;
- управляет `PageView`;
- хранит контент 3 onboarding-экранов;
- переключает пользователя по кнопке `Далее` / `Начать`.

### `lib/features/onboarding/presentation/widgets/page_indicator.dart`
- виджет пагинации;
- отображает активную страницу onboarding.

### `lib/features/onboarding/presentation/widgets/status_bar.dart`
- декоративный верхний status bar из дизайна;
- используется на onboarding-экранах как часть макета.

### `lib/features/home/presentation/home_screen.dart`
- временный экран-заглушка после завершения onboarding.

## Assets

Используемые изображения:
- `docs/imgs/logo.png`
- `docs/imgs/onbord1.png`
- `docs/imgs/onbord2.png`
- `docs/imgs/onbord3.png`

Они подключены в `pubspec.yaml`.

## Текущие UI-решения

### Splash
- белый фон;
- логотип по центру;
- переход на onboarding после задержки.

### Onboarding
- фоновые изображения берутся из assets;
- картинки растягиваются через `BoxFit.fill`;
- поверх картинки накладывается затемняющий градиент;
- верхняя строка статуса является частью дизайна;
- пагинация и кнопка выровнены под референс из Figma.

## Что важно помнить

- сейчас `HomeScreen` временный и позже должен быть заменен на реальный главный экран;
- тексты onboarding нужно хранить аккуратно в UTF-8 без сломанной кодировки;
- новые экраны лучше сразу добавлять в `features/<feature_name>/presentation/`.

## Правило ведения документации

Дальше по проекту изменения стоит фиксировать в этом файле:
- новые экраны;
- структура папок;
- важные UI-решения;
- маршруты и навигация;
- подключенные assets;
- технические договоренности по проекту.
