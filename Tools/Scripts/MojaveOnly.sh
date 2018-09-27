if [ -z "$SELF_PATH" ]; then
    echo "Use Build.sh, aborting..."
    exit 1
fi

# Paths
MOJAVE_ONLY_PATH="$SELF_PATH/MojaveOnly"

# Copy mojave2core tool
cp -v "$MOJAVE_ONLY_PATH/Tools/mojave2core" "$BUILD_PATH/"
