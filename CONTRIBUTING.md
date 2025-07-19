# Contributing to Flutter Code Extractor CLI

Thank you for your interest in contributing to Flutter Code Extractor CLI! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites
- Bash 4.0 or higher
- Git
- Flutter SDK (for testing)
- Basic understanding of shell scripting

### Development Setup

1. **Fork and clone the repository:**
```bash
git clone https://github.com/Kandil7/flutter-extractor.git
cd flutter-extractor
```

2. **Set up development environment:**
```bash
make dev-setup
```

3. **Install locally for testing:**
```bash
make install-local
```

## 🛠️ Development Workflow

### Making Changes

1. **Create a feature branch:**
```bash
git checkout -b feature/your-feature-name
```

2. **Make your changes:**
   - Edit `flutter-extractor` for CLI functionality
   - Update documentation in `README.md`
   - Add tests if applicable

3. **Test your changes:**
```bash
make dev-test          # Check syntax
make test             # Run basic tests
flutter-extractor help  # Test CLI
```

4. **Commit your changes:**
```bash
git add .
git commit -m "feat: add your feature description"
```

### Commit Message Format

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

Examples:
```bash
git commit -m "feat: add support for custom asset directories"
git commit -m "fix: handle spaces in file names correctly"
git commit -m "docs: update installation instructions"
```

## 🧪 Testing

### Manual Testing

1. **Create a test Flutter project:**
```bash
flutter create test_app
cd test_app
```

2. **Test extraction:**
```bash
flutter-extractor extract -v
```

3. **Test generated script:**
```bash
./generate_flutter_app.sh test_recreation
cd test_recreation
flutter run  # Should work without errors
```

### Automated Testing

Run the test suite:
```bash
make test
```

### Testing Different Scenarios

Please test these scenarios when making changes:

- **Basic extraction** - Simple app with just main.dart
- **Complex projects** - Multiple directories and files
- **With assets** - Including images, fonts, etc.
- **With pubspec** - Custom dependencies
- **Edge cases** - Special characters in filenames, empty directories
- **Different platforms** - Linux, macOS, Windows (Git Bash)

## 📋 Code Style Guidelines

### Shell Script Best Practices

1. **Use strict error handling:**
```bash
set -e  # Exit on error
```

2. **Quote variables:**
```bash
# Good
echo "$variable"
cp "$source" "$destination"

# Bad
echo $variable
cp $source $destination
```

3. **Use functions for reusable code:**
```bash
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}
```

4. **Handle edge cases:**
```bash
if [ ! -d "$directory" ]; then
    print_error "Directory not found: $directory"
    exit 1
fi
```

5. **Use meaningful variable names:**
```bash
# Good
SOURCE_DIR="./lib"
DART_FILES_COUNT=0

# Bad
DIR="./lib"
CNT=0
```

### Documentation

- Update `README.md` for new features
- Add inline comments for complex logic
- Include usage examples
- Update help text in the CLI

## 🐛 Bug Reports

When reporting bugs, please include:

1. **System information:**
   - OS and version
   - Bash version (`bash --version`)
   - Flutter version (`flutter --version`)

2. **Steps to reproduce:**
   - Exact commands run
   - Project structure
   - Expected vs actual behavior

3. **Logs and output:**
   - Full command output
   - Error messages
   - Use `-v` flag for verbose output

## 💡 Feature Requests

For new features, please:

1. Check existing issues first
2. Describe the use case
3. Provide examples of how it would work
4. Consider implementation complexity

## 📝 Documentation Updates

Documentation improvements are always welcome:

- Fix typos or unclear instructions
- Add more examples
- Improve formatting
- Translate to other languages

## 🔍 Code Review Process

1. **All changes require review:**
   - Submit a pull request
   - Describe changes clearly
   - Link related issues

2. **Review criteria:**
   - Code quality and style
   - Test coverage
   - Documentation updates
   - Backward compatibility

3. **Addressing feedback:**
   - Make requested changes
   - Push updates to your branch
   - Respond to reviewer comments

## 📦 Release Process

Releases are managed by maintainers:

1. Version bumps follow [Semantic Versioning](https://semver.org/)
2. Create release notes
3. Tag releases in Git
4. Update installation scripts

## 🆘 Getting Help

If you need help:

- 📫 Open an [issue](https://github.com/Kandil7/flutter-extractor/issues)
- 💬 Join [discussions](https://github.com/Kandil7/flutter-extractor/discussions)
- 📧 Contact maintainers

## 🙏 Recognition

Contributors are recognized in:
- README.md contributors section
- Release notes
- GitHub contributors page

Thank you for contributing to Flutter Code Extractor CLI! 🚀
