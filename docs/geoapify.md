# Geoapify

## API key

Для карты используется Geoapify API key.

Сам ключ не храним в документации и не коммитим в репозиторий.
Он лежит только локально в файле:

```text
.env.geoapify.json
```

Файл добавлен в `.gitignore`.

## Запуск приложения

```zsh
flutter run --dart-define-from-file=.env.geoapify.json
```

В коде Flutter ключ читается так:

```dart
const geoapifyApiKey = String.fromEnvironment('GEOAPIFY_API_KEY');
```

## Важно

- не вставлять Geoapify key в публичные файлы;
- не добавлять key в `README.md`, `docs/*.md`, `pubspec.yaml`;
- если ключ случайно попал в git, лучше создать новый ключ в Geoapify.
