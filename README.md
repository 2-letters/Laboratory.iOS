![alt laboratory](cover1.png)

![Language](https://img.shields.io/badge/language-Swift%205-orange.svg)
![Swift](https://github.com/2-letters/Laboratory.iOS/workflows/Swift/badge.svg)
![last commit](https://img.shields.io/github/last-commit/2-letters/Laboratory.iOS)
[![codecov](https://codecov.io/gh/2-letters/Laboratory.iOS/branch/master/graph/badge.svg)](https://codecov.io/gh/2-letters/Laboratory.iOS)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

An iOS application that helps scientific professionals manage laboratory sections and equipment more collaboratively.
## Publications
There are 2 publications about the projects: [Project Proposal] and [Project Poster].

## Technologies
[Xcode], [Swift], [MVVM], [Google Firebase SDKs].

## Main features:
<img align="right" src="https://media.giphy.com/media/U3yF1DsaNMy1GtStU4/giphy.gif" width="250">

***1. Users***

Users can sign up and log in using their emails.

There are two types of users, **normal users**, and **moderators**. And they have different roles.
should have different roles, as described in this [diagram](#more-information).
1. Both moderators and normal users can sign up and log in.
2. Normal users can manage their laboratory sections, meaning viewing, creating, and editing the sections that they are in charge
of.
3. Moderators can manage laboratory sections of their departmental members.
4. Normal users can view equipment that is available in their department.
5. Moderators can manage the equipment, meaning creating, viewing, and edit equipment of the department.

</br>

***2.Lab sections***

Users can create, view, edit, and delete lab sections.
1. Create a new lab section with helpful information such as name, description, and the list of equipment
2. View and search by keywords lab sections that the users are in charge of.
3. Edit the name, description, or the list of equipment by changing the quantity of the equipment being used.
4. Delete the unwanted sections.

</br>

***3.Equipment***

Moderators can create, view, edit, and delete equipment in their department.
Normal users can view equipment and request an edit from the department.
1. View and search by keywords equipment that is available at the department.
2. Equipment info includes information such as name, description, location, a preview picture, and **a list of users**
3. The list of users is an important piece of information and can be used to collaborate and share the available equipment in a better manner.

## Demos
In progress.

## Screenshots

<p float="left">
  <img src="Screenshots/equipmentList.png" width="215" />
  <img src="Screenshots/addNewLab.png" width="215" />
  <img src="Screenshots/labInfo.png" width="215" />
  <img src="Screenshots/addLabEquipment.png" width="215" />
</p>

## Extras
Use case diagram

[Project Proposal]: https://drive.google.com/file/d/1MCzDw_U9_WsVgIXtvqrS8UXya_c9Lw3B/view?usp=sharing
[Project Poster]: https://drive.google.com/file/d/1XkFxiIdr9Jf-WzJl3VLbwwOGRJkKqm9e/view?usp=sharing
[Xcode]: https://developer.apple.com/xcode
[Swift]: https://developer.apple.com/swift
[MVVM]: https://cocoacasts.com/model-view-viewmodel-in-swift
[Google Firebase SDKs]: https://firebase.google.com/docs/storage/ios/start
