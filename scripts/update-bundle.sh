if [ ! -z "$INFO_PLIST" ]; then
  /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $TRAVIS_BUILD_NUMBER" "$INFO_PLIST"
fi

if [ ! -z "$BUNDLE_IDENTIFIER" ]; then
  /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BUNDLE_IDENTIFIER" "$INFO_PLIST"
fi

if [ ! -z "$BUNDLE_DISPLAY_NAME" ]; then
  /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $BUNDLE_DISPLAY_NAME" "$INFO_PLIST"
fi
