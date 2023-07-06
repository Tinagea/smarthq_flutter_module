echo "> Prepare flutter framework"
flutter clean
flutter pub upgrade
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs

echo "> Copy build.gradle for build test - android"
cp -f build_test_env/build.gradle .android/app/
