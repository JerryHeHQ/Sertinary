# Table of Contents
- [Table of Contents](#table-of-contents)
- [Preliminary Message](#preliminary-message)
- [Overview Of The Project](#overview-of-the-project)
- [User Authentication](#user-authentication)
  - [User Registration](#user-registration)
  - [Reset Password](#reset-password)
  - [Log In](#log-in)
- [UI Features](#ui-features)
  - [Bottom Navigation Bar](#bottom-navigation-bar)
    - [Implementation](#implementation)
    - [Routing](#routing)
  - [Floating Action Button](#floating-action-button)
- [Alarms Section](#alarms-section)
  - [Alarms Screen](#alarms-screen)
    - [Add Alarms](#add-alarms)
    - [Edit/Delete Alarms](#editdelete-alarms)
    - [Minigame](#minigame)
  - [Sleep Time Calculator](#sleep-time-calculator)
  - [Theme Changer](#theme-changer)
- [Social Section](#social-section)
  - [Browse Posts](#browse-posts)
    - [View User](#view-user)
      - [Follow](#follow)
    - [View post](#view-post)
    - [Saving](#saving)
    - [Sorting](#sorting)
    - [Search](#search)
  - [Add Posts](#add-posts)
    - [View Your Posts](#view-your-posts)
  - [Profile](#profile)
    - [Edit Profile](#edit-profile)
    - [Log Out](#log-out)
- [Tracker Section](#tracker-section)
  - [Add Meal](#add-meal)
    - [Search & Sorting](#search--sorting)
- [Planner Section](#planner-section)

# Preliminary Message
This is an exploratory cross-platform application that serves as my introduction to Flutter & Dart programming. It's not completed, but its purpose to bring me into the Flutter framework and Dart language has been served. I will create an alternate version of this in the future with better code formatting, widget usage, page routing, database integration, animations, and other changes using the various lessons I learned throughout the process of developing this app.

# Overview Of The Project
Sertinary is a cross-platform lifestyle application designed to help users achieve and maintain a healthier daily routine. This project includes 4 sections: user authentication, alarms, social, and tracker. This README section will be walking through the features of this project and any obstacles worth mentioning.

# User Authentication
User authentication for this project was done through Firebase Authentication for security and compatibility.

## User Registration
The idea is to make registration as simple and linear as possible, which is why each step takes the user to a new screen with only one text box. Although user verification works, this is currently disabled to make testing easier.

<img src="https://user-images.githubusercontent.com/107007274/174561729-a9b5445e-2c81-4c5e-8854-aad080514eae.gif" width="360" />

## Reset Password
Basic reset password function which checks if the user exists and sends a reset password link through the email.

<img src="https://user-images.githubusercontent.com/107007274/174562022-e85a33a4-3e36-4523-beb8-127e933cad57.gif" width="360" />

## Log In
Basic log in functionality. The log in button is reactive to text form field validators for better UI feedback.

*The welcome screen design wasn't made since it was a low priority.*

<img src="https://user-images.githubusercontent.com/107007274/174575539-7e5b0efb-2664-441e-882d-7a371befefc8.gif" width="360" />

# UI Features

## Bottom Navigation Bar
The bottom navigation bar used for this project consists of two separate bottom navigation bars.

The base package used was [google_nav_bar](https://pub.dev/packages/google_nav_bar) for its animation.

<img src="https://user-images.githubusercontent.com/107007274/174575593-64638e6d-1211-474e-8cbc-5a86b0073d51.gif" width="360" />

### Implementation
To make the double navigation bar, different elements had to be added to the google nav bars such as an *is active* boolean, *min index*, dynamic tab margins, parameters for centering each side to their respective locations, overflow prevention, and gradients for design purposes.

*Once I clean up my code for these changes I will be making a pull request to the google nav bar repo to officially add this functionality.*

### Routing
The project used to use the built-in Flutter screen navigator until it was realized that it does not preserve screen state, so the package [auto_route](https://pub.dev/packages/auto_route) was used to streamline the routing process for persistent screens.

## Floating Action Button
The floating action button in the center of the bottom navigation bar was the main reason for using two bottom navigation bars instead. The functionality is that when it is pressed, sub buttons will pop out, allowing the user to easily access sub-menus and extra screens accompanied with a nice animation. 

<img src="https://user-images.githubusercontent.com/107007274/174575622-b1d0ba35-2705-427a-8965-09f8c75e2f88.gif" width="360" />

# Alarms Section

## Alarms Screen
This screen shows the current alarms and their respective attributes.

<img src="https://user-images.githubusercontent.com/107007274/174575652-0731b615-e401-4c0f-90f2-937cb08ac2f9.gif" width="360" />

### Add Alarms
Using the floating action button, the user can add an alarm and choose its attributes.

<img src="https://user-images.githubusercontent.com/107007274/174575678-8101f9ae-2a5f-4d63-be13-a0afc109f98f.gif" width="360" />

### Edit/Delete Alarms
When the user clicks on the cog icon on each alarm, they can edit its attributes or delete the alarm.

<img src="https://user-images.githubusercontent.com/107007274/174575697-c501c8ec-a942-46a1-bdb0-f0e51f19aab5.gif" width="360" />

### Minigame
Although the alarms work as normal, the permissions to allow alarms to ring even when the app is minimized or closed could not be found and the alarm packages available do not seem to support this functionality either. Therefore, the alarm minigame is currently located in the planner section for ease of testing (since the planner section has not been implemented yet).

<img src="https://user-images.githubusercontent.com/107007274/174575715-7aeae852-4397-4238-a7e3-4c81e5624cf7.gif" width="360" />

## Sleep Time Calculator
Using the floating action button, the user can calculate their ideal sleep time using the time it takes for them to fall asleep and the time for each of their sleep cycles.

*Since it is difficult to consistently fall asleep using the same time and the fact that sleep cycles vary in duration, this tool is more so used to prevent the user from waking up during deep sleep.*

<img src="https://user-images.githubusercontent.com/107007274/174575733-7b5976b7-c8b6-4ac9-8f64-b5c2386c9afd.gif" width="360" />

## Theme Changer
This feature has yet to be officially implemented yet, but the base functionality is there. 

Below are some examples of what the alarms screen would look like using different themes.

*Background Image Credits (From Left To Right):*

- [Nengoro(ネんごろぅ)](https://twitter.com/Nengoro2739)
- [Hernan Pauccara](https://www.pexels.com/@hernan-pauccara-466676/)
- [mocha](https://twitter.com/mocha708)

![Image Y2022 M06 D20 H06 M10 S32](https://user-images.githubusercontent.com/107007274/174579768-2b887bdf-229f-4ac1-bfe5-848a92cd09ed.png)

# Social Section

## Browse Posts
Here the user can browse the posts from other users. Each post includes the author, a title, a picture, calories, macro-nutrients, and saved status.

<img src="https://user-images.githubusercontent.com/107007274/174575758-5e509bc7-45f8-4306-9a4d-b909468a13a5.gif" width="360" />

### View User
To get more information on the author of the post, the user can click on the profile picture or the username to open up the author's profile page.

<img src="https://user-images.githubusercontent.com/107007274/174575790-3171d101-5c53-46fc-b0b5-47a4ea777230.gif" width="360" />

#### Follow
To follow the author of the post, the user can click on the follow button. A second click will unfollow the author.

<img src="https://user-images.githubusercontent.com/107007274/174575796-b653bcf4-35e9-40f6-adae-710e7d8e4165.gif" width="360" />

### View Post
To get more information on the post itself, the user can click on the title of the post to bring up the full image of the post which includes the ingredients and instructions. 

*Note: The UI for this section is not completed.*

<img src="https://user-images.githubusercontent.com/107007274/174575817-45e88dfd-7883-47aa-80a2-a3574cd552df.gif" width="360" />

### Saving
To save a post, the user can simply tap on the heart icon which will play an animation from the [like_button](https://pub.dev/packages/like_button) package. To unsave the post, the user can just tap on the heart icon again.

<img src="https://user-images.githubusercontent.com/107007274/174575831-08d1b962-84da-4499-9ee9-3d7397d1e686.gif" width="360" />

### Sorting
The button on the top right sorts the posts listed in three ways.
- All Posts
- Posts From Following
- Saved Posts

<img src="https://user-images.githubusercontent.com/107007274/174575852-fcc218c3-14b7-4fc6-9dbf-ef703a6bdbf7.gif" width="360" />

### Search
The search bar opens up with a clean animation when pressed and functions as a standard search bar.

<img src="https://user-images.githubusercontent.com/107007274/174575885-3f12a857-a1dc-4ded-8598-26439ca1f342.gif" width="360" />

## Add Posts
Using the floating action button, the user can create a post by adding some details, instructions, a picture, etc.

*Multi-image posts will be implemented in the future.*

<img src="https://user-images.githubusercontent.com/107007274/174575954-927af565-a2d3-49d0-a1b8-77e4de9cdb4c.gif" width="360" />

### View Your Posts
Using the floating action button, the user can view their own posts.

*Delete post function will be implemented in the future.*

<img src="https://user-images.githubusercontent.com/107007274/174575974-ced210c8-c13f-4a03-9a60-bda4c21973f6.gif" width="360" />

## Profile
Using the floating action button, the user can view their profile.

<img src="https://user-images.githubusercontent.com/107007274/174575999-8962d919-dee8-42f6-8afb-4e9b89e6224a.gif" width="360" />

### Edit Profile
Clicking on the edit profile button allows the user to edit their username, biography, profile picture, and profile cover image.

<img src="https://user-images.githubusercontent.com/107007274/174576026-d054f3d2-af73-46d5-9ef8-58ab0f4cabb1.gif" width="360" />

### Log Out
Click on the log-out function calls Firebase Authentication to log the user out of the application and redirects the user to the login page.

<img src="https://user-images.githubusercontent.com/107007274/174576043-43a774e7-1786-4dfd-b2d6-b13659c82112.gif" width="360" />

# Tracker Section

## Add Meal
The user can add meals to the tracker using the sub button.

<img src="https://user-images.githubusercontent.com/107007274/174576064-c68710ec-8618-46f7-a2c2-65f503db5303.gif" width="360" />

### Search & Sorting
The search bar functionality is the same as the social section, but the posts shown are posts the user has saved and their own posts (accessed through the toggle button on the top right).

<img src="https://user-images.githubusercontent.com/107007274/174576077-88d820a0-f181-41e6-846b-2ec1ce1e3fc3.gif" width="360" />

# Planner Section
Yet to be implemented.
