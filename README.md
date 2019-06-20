## Persistence Demo

Project created as demo app for a tech company.

## Prerequisites

- macOS 10.10+
- Xcode 10.0+
- CocoaPods 1.6.0+

## Technical decisions

### Architecture

The application based on MVVM + C architecture. 

<p align="center">
<img width="100%" src="/Images/architecture.png">
</p>
<p style="text-align: center;">  </p>

<p align="center">
  Application architecture diagram.
</p>

### Database
For persistance **Core Data** with base setup - two contexts connected to same persistent store. *Private context* is used for importing data from API. *Main context* is used for UI related work.

<p align="center">
<img width="33%" src="/Images/core-data-setup.png">
<p>

<p align="center">
  Core Data setup.
</p>


