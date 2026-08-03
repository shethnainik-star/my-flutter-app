# VetResources App (Flutter)

Starter app with 4 tabs: Blogs (from WordPress), News, Videos, Notifications.
Right now Blogs pulls live from `vetresources.com.au`'s public REST API.
News/Videos/Notifications point at a placeholder Laravel API URL and will
show demo data until that backend exists — see `lib/services/api_service.dart`.

## Get a real, installable APK (no local setup needed)

1. Create a new GitHub repository (public or private).
2. Upload everything in this folder to that repo (keep the folder structure,
   including the hidden `.github/workflows/build-apk.yml` file).
3. Go to the repo's **Actions** tab. The "Build APK" workflow runs
   automatically on push (or click "Run workflow" to trigger it manually).
4. Wait a few minutes for it to finish (green checkmark).
5. Open the finished run → scroll to **Artifacts** → download
   `vetresources-app-apk`. Unzip it — that's your `app-release.apk`.
6. Transfer that `.apk` to your phone (email it to yourself, Google Drive,
   USB, etc.) and tap it to install. You'll need to allow
   "install from unknown sources" the first time.

## Build locally instead (if you have Flutter installed)

```
flutter pub get
flutter build apk --release
```
The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

## Before this is production-ready

- Update `ApiConfig.laravelBaseUrl` in `lib/services/api_service.dart` once
  your Laravel API has a real domain.
- Once Laravel caches WordPress blog content (per the sync plan discussed),
  switch `getBlogs()` to call `laravelBaseUrl` instead of WordPress directly.
- Add an app icon, splash screen, and proper `applicationId` in
  `android/app/build.gradle` before publishing.
- Add authentication (Sanctum tokens) once login is needed.
