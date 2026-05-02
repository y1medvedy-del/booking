
# 1. Запустить эмулятор отдельно от Android Studio
 Эту команду запускать в отдельном терминале Windows PowerShell или CMD
 После запуска этот терминал будет занят эмулятором
& "$env:LOCALAPPDATA\Android\Sdk\emulator\emulator.exe" -avd "Pixel_6_API_34" -no-snapshot-load -gpu swiftshader_indirect -no-boot-anim


# 2. Проверить, что Flutter видит эмулятор. Эту команду запускать в другом терминале
flutter devices

# 3. Перейти в папку проекта
cd C:\Users\User\Desktop\booking

# 4. Запустить приложение на эмуляторе
 Эту команду запускать в терминале проекта
 После запуска откроется живая сессия Flutter, и в этом же терминале работают команды ниже
flutter run -d emulator-5554

# 5. Нажать маленькую английскую букву r
 Работает только после flutter run в том же терминале
 Hot reload: быстро применяет изменения в коде без полного перезапуска приложения
r

# 6. Нажать большую английскую букву R
Работает только после flutter run в том же терминале
Hot restart: перезапускает приложение целиком, но быстрее, чем новый flutter run
R

# 7. Нажать английскую букву q
# Работает только после flutter run в том же терминале
# Останавливает запущенное приложение и завершает текущую Flutter-сессию
q

# 8. Если завис Gradle
# Сначала проверить, нет ли процессов java или gradle
Get-Process | Where-Object { $_.ProcessName -match 'java|gradle' }

# Если процессов нет, удалить lock-файл
Remove-Item -LiteralPath "C:\Users\User\Desktop\booking\android\.gradle\noVersion\buildLogic.lock" -Force

# Потом снова запустить приложение
flutter run -d emulator-5554

# 9. Если эмулятор закрывается вместе с Android Studio
# Android Studio -> Settings -> Tools -> Emulator
# Снять галочку: Launch in the Running Devices tool window
