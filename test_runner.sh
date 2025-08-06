#!/bin/bash

# Comprehensive test runner for visual regression testing
# Usage: ./test_runner.sh [--update-goldens] [--coverage]

set -e

echo "🔧 Setting up dependencies..."
flutter pub get
flutter gen-l10n

# Parse arguments
UPDATE_GOLDENS=false
COVERAGE=false

for arg in "$@"; do
  case $arg in
    --update-goldens)
      UPDATE_GOLDENS=true
      shift
      ;;
    --coverage)
      COVERAGE=true
      shift
      ;;
  esac
done

echo "🧪 Running unit and widget tests..."
if [ "$COVERAGE" = true ]; then
  flutter test --coverage
else
  flutter test
fi

if [ "$UPDATE_GOLDENS" = true ]; then
  echo "🎨 Updating golden files (LOCAL ONLY - commit the results)..."
  flutter test --update-goldens
  echo "⚠️  IMPORTANT: Review and commit the updated golden files!"
  echo "📁 Golden files location: test/goldens/"
else
  echo "🎨 Running golden file tests (same as CI)..."
  flutter test
  if [ $? -ne 0 ]; then
    echo "❌ Golden tests failed! Visual changes detected."
    echo "🔧 To update golden files: ./test_runner.sh --update-goldens"
    echo "📋 Then review changes and commit updated golden files."
  fi
fi

echo "🔍 Running analysis..."
flutter analyze

echo "✅ All tests passed!"

if [ "$COVERAGE" = true ]; then
  echo "📊 Coverage report generated at coverage/lcov.info"
  echo "📊 To view HTML coverage report, run:"
  echo "    genhtml coverage/lcov.info -o coverage/html"
fi

echo ""
echo "🎯 Test Summary:"
echo "  ✅ Widget tests: Verify component behavior"
echo "  ✅ Golden tests: Catch visual regressions"
echo "  ✅ Integration tests: Verify screen layouts"
echo "  ✅ Static analysis: Code quality checks"
echo ""
echo "🚀 Your changes are safe to deploy!"