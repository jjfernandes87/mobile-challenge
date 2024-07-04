# Mobile Challenge
<p align="center">
<a href=''><img src='https://badgen.net/badge/iOS/17.0/:color?icon=apple'/></a>
<a href=''><img src='https://badgen.net/badge/Swift/5.9/orange'/></a>
<a href=''><img src='https://badgen.net/badge/Xcode/15.4/blue'/></a>
<a href=''><img src='https://badgen.net/badge/cocoapods/1.15.2/red?icon=cocoapods'/></a>
<a href=''><img src='https://badgen.net/badge/Ruby/3.1.4/red?icon=ruby'/></a>
</p>

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
        ├── DependencyInjector
        ├── NetworkClient
    ├── domain
        ├── Lightning
└── apps
    └── Challenge
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

### External iOS Frameworks

- **Swinject**: Swinject is a lightweight dependency injection framework for Swift. Dependency injection (DI) is a software design pattern that implements Inversion of Control (IoC) for resolving dependencies. Swinject helps your app split into loosely-coupled components, making development, testing, and maintenance easier. Swinject leverages Swift's generic type system and first-class functions to define app dependencies simply and fluently.

### Internal Modules

- **Dependency Injector**: Wrapper for the Swinject external library, providing a reusable DI solution for the entire application.
- **NetworkClient**: Standard HTTP client service using URLSession as a native framework.
- **Lightning**: Handles business rules.
- **Challenge**: Contains all user interface components.

## Steps to run the app

### Step 1: Install Auxiliary Tools

Run the `tools.sh` script to install all necessary tools.

```sh
./tools.sh
```

### Step 2: Automation with Rake

Use Rake for various automation tasks defined in the Rakefile. For example:

#### Generate Xcode Project

To generate the Xcode project and install Cocoapods dependencies:

```sh
rake xcode:generate
```

#### Run the App

Select the `Challenge` scheme and click run.

## What areas of the app did you focus on?

The focus was divided into three areas:
- Establishing a large-scale project structure with predefined scripts and design patterns.
- Implementing a Service Layer for integrating with external layers like URLSession and DI.
- Creating a Domain Layer to ensure code reuse across different areas and enhance test coverage.

## What was the reason for your focus? What problems were you trying to solve?

The goal was to demonstrate my accumulated knowledge from leading Platform teams over the past few years. My main focus is on organizing a scalable project structure that allows for business rule modifications without impacting other parts of the application.

## How long did you spend on this project?

First commit at 13:00 and last commit at 21:00, with breaks totaling 6 hours.

## Did you make any trade-offs for this project? What would you have done differently with more time?

Given the focus on showcasing a project structure, with more time, I would have created separate UIKit and SwiftUI libraries and implemented a Composable architecture in the Challenge App. This would enable switching between different UI libraries seamlessly.

Additionally, I would have added other Core Libraries, such as:
- **CacheService**: For offline data handling (based on my previous Comitando course).
- **FeatureFlag**: To test different app integrations.
- **LogService**: For simulating service logs.

## What do you think is the weakest part of your project?

Certainly, the SwiftUI part. I haven't had enough dedicated study time as my recent projects have been 100% UIKit-based. However, I have been experimenting with SwiftUI and SwiftData in personal projects [here](https://github.com/comitando/trainer/tree/wip/introScreen-ui).

## Is there any other information you’d like us to know?

I didn't include UI testing due to insufficient experience in SwiftUI projects.