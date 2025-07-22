# Flutter Code Extractor CLI

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/Kandil7/flutter-extractor/releases)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-linux%20%7C%20macos%20%7C%20windows-lightgrey.svg)](https://github.com/Kandil7/flutter-extractor)

A powerful CLI tool to extract and recreate Flutter applications. Perfect for backing up, sharing, or migrating Flutter projects.

## ✨ Features

- 🚀 **Global CLI tool** - use from any directory
- 📦 **Complete app extraction** - includes all Dart code and structure
- 🎯 **Smart generation** - creates executable recreation scripts
- 📄 **pubspec.yaml support** - optionally include dependencies
- 🖼️ **Assets support** - include images and other assets
- 🎨 **Beautiful output** - colored terminal interface
- ⚡ **Fast and reliable** - handles projects of any size
- 🔧 **Highly configurable** - many command-line options

## 🚀 Quick Install

### One-line install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/Kandil7/flutter-extractor/main/install.sh | bash
```

### Manual install
```bash
curl -o flutter-extractor https://raw.githubusercontent.com/Kandil7/flutter-extractor/main/flutter-extractor
chmod +x flutter-extractor
./flutter-extractor install
```

### Local install (offline)
```bash
git clone https://github.com/Kandil7/flutter-extractor.git
cd flutter-extractor
./install-local.sh
```

## 📖 Usage

### Basic Commands

```bash
# Extract current Flutter app
flutter-extractor extract

# Show help
flutter-extractor help

# Show version
flutter-extractor version

# Uninstall the CLI
flutter-extractor uninstall
```

### Advanced Extraction Options

```bash
# Include pubspec.yaml and assets
flutter-extractor extract -p -a

# Custom source directory and output file
flutter-extractor extract -s ./packages/my_package -o my_backup.sh

# Default: update existing features (only changed files are written)
./flutter-extractor extract --split-features

# Force full recreation (old behaviour)
./flutter-extractor extract --split-features --recreate

# Custom app name in generated script
flutter-extractor extract -n MyAwesomeApp

# Force overwrite existing output file
flutter-extractor extract -f

# Verbose output for debugging
flutter-extractor extract -v

# Complete extraction with all options
flutter-extractor extract -p -a -v -n MyCompleteApp -o complete_backup.sh
```

## 📋 Full Command Reference

### Extract Command Options

| Option | Description | Default |
|--------|-------------|---------|
| `-s, --source DIR` | Source directory to extract from | `./lib` |
| `-o, --output FILE` | Output script filename | `generate_flutter_app.sh` |
| `-n, --name NAME` | Default app name in generator | `extracted_flutter_app` |
| `-p, --pubspec` | Include pubspec.yaml | `false` |
| `-a, --assets` | Include assets folder | `false` |
| `-f, --force` | Overwrite existing output file | `false` |
| `-v, --verbose` | Enable verbose output | `false` |

### Generated Script Options

When you run the generated script, it supports these options:

```bash
# Basic usage
./generate_flutter_app.sh [app_name]

# Skip dependency installation
./generate_flutter_app.sh my_app --skip-deps

# Skip flutter doctor check
./generate_flutter_app.sh my_app --skip-doctor

# Show help for generated script
./generate_flutter_app.sh --help
```

## 🎯 Examples

### Example 1: Basic Project Backup
```bash
# In your Flutter project root
flutter-extractor extract

# This creates: generate_flutter_app.sh
# To recreate: ./generate_flutter_app.sh my_new_app
```

### Example 2: Complete Project Migration
```bash
# Extract everything including dependencies and assets
flutter-extractor extract -p -a -n ProductionApp -o production_backup.sh

# Recreate on another machine
./production_backup.sh ProductionApp_v2
```

### Example 3: Package Extraction
```bash
# Extract a specific package
flutter-extractor extract -s ./packages/my_package -n MyPackage -o package_backup.sh

# Recreate as standalone app
./package_backup.sh MyPackageApp
```

### Example 4: Team Sharing
```bash
# Create a verbose backup for team sharing
flutter-extractor extract -p -a -v -f -o team_project.sh

# Team members can recreate with
./team_project.sh ProjectName
```

## 🔧 Generated Script Features

The generated scripts include:

- ✅ **Complete Flutter app creation**
- ✅ **Automatic dependency installation**
- ✅ **Flutter doctor health check**
- ✅ **Directory structure recreation**
- ✅ **Asset file restoration (base64 encoded)**
- ✅ **Error handling and validation**
- ✅ **Progress indicators**
- ✅ **Help system**
- ✅ **Configurable options**

## 🛠️ Requirements

- **Flutter SDK** - Latest stable version
- **Bash** - Version 4.0 or higher
- **Operating System** - Linux, macOS, or Windows (with Git Bash/WSL)

### Optional Tools
- `curl` or `wget` - for online installation
- `base64` - for asset encoding (usually pre-installed)

## 📁 Project Structure

When you extract a Flutter app, the tool processes:

```
your_flutter_app/
├── lib/                    # ✅ Always included
│   ├── main.dart
│   ├── models/
│   ├── screens/
│   └── widgets/
├── pubspec.yaml           # ✅ With -p flag
├── assets/                # ✅ With -a flag
│   ├── images/
│   └── fonts/
└── generate_flutter_app.sh  # ✅ Generated script
```

## 🚀 Installation Verification

After installation, verify it works:

```bash
# Check if command is available
which flutter-extractor

# Show version
flutter-extractor version

# Show help
flutter-extractor help
```

## 🔧 Troubleshooting

### Command not found
```bash
# Add to PATH manually
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Permission denied
```bash
# Make sure the script is executable
chmod +x ~/.local/bin/flutter-extractor
```

### Flutter not found in generated script
The generated script requires Flutter SDK. Install from [flutter.dev](https://flutter.dev/docs/get-started/install).

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

- 📫 **Issues**: [GitHub Issues](https://github.com/Kandil7/flutter-extractor/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Kandil7/flutter-extractor/discussions)
- 📖 **Documentation**: This README and `flutter-extractor help`

## 🏷️ Changelog

### v1.0.0
- ✨ Initial release
- 🚀 Global CLI installation
- 📦 Complete Flutter app extraction
- 🎯 Smart script generation
- 📄 pubspec.yaml support
- 🖼️ Assets support
- 🎨 Beautiful terminal interface

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open source community for inspiration
- All contributors and users

---

**Made with ❤️ for the Flutter community**
