cd ../example
flutter build appbundle
cp example/build/app/outputs/bundle/release/app-release.aab app-release.aab

# Check the existence of the app-release.aab file
if [ -f app-release.aab ]; then
  echo "app-release.aab file exists"

  # Check and print the size of the app-release.aab file in megabytes
  filesize_bytes=$(stat -f%z "app-release.aab")
  filesize_megabytes=$(echo "scale=2; $filesize_bytes / 1024 / 1024" | bc)
  echo "Size of app-release.aab: $filesize_megabytes MB"
else
  echo "app-release.aab file does not exist"
fi