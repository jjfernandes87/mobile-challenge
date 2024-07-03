# Mobile Challenge

## Tools Used

This repository contains the base structure for a large-scale iOS application. We use tools such as xcodegen, cocoapods, Rakefile, and SPM scripts to generate modules in a standardized way.

- **Xcodegen**: Automatic generation of Xcode project files.
- **Cocoapods**: Dependency management for Swift and Objective-C projects.
- **Rakefile**: Task automation using Rake.
- **Swift Package Manager (SPM)**: Dependency management and script automation.

### Folder Structure

The project folder structure is as follows:

```
├── tools.sh
├── Rakefile
├── project.yml
├── Podfile
├── Gemfile
├── scripts
    ├── podfile
    ├── rakefile
    ├── spm
    └── xcodegen
└── libraries
    ├── core
    ├── domain
    └── ui
└── apps
    └── iOS
```

### Description of Folders and Files

- **tools.sh**: Utility script for environment configurations.
- **Rakefile**: Configuration file for task automation with Rake.
- **project.yml**: Configuration file for xcodegen.
- **Podfile**: Configuration file for Cocoapods.
- **Gemfile**: Configuration file for managing Ruby gems.
- **scripts**: Directory containing specific automation scripts:
  - **podfile**: Scripts related to Cocoapods.
  - **rakefile**: Scripts related to Rake.
  - **spm**: Scripts related to Swift Package Manager.
  - **xcodegen**: Scripts related to xcodegen.
- **libraries**: Directory containing reusable modules:
  - **core**: Core code and utilities.
  - **domain**: Business logic and data models.
  - **ui**: User interface components.
- **apps**: Directory containing the main application:
  - **iOS**: Main iOS application.
