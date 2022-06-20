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
## Reset Password
Basic reset password function which checks if the user exists and sends a reset password link through the email.
## Log In
Basic log in functionality. The log in button is reactive to text form field validators for better UI feedback.
The welcome screen design wasn't made since it was a low priority.
# UI Features
## Bottom Navigation Bar
The bottom navigation bar used for this project consists of two separate bottom navigation bars.
The base package used was [google_nav_bar](https://pub.dev/packages/google_nav_bar) for its animation.
### Implementation
To make the double navigation bar, different elements had to be added to the google nav bars such as an *is active* boolean, *min index*, dynamic tab margins, parameters for centering each side to their respective locations, overflow prevention, and gradients for design purposes.
*Once I clean up my code for these changes I will be making a pull request to the google nav bar repo to officially add this functionality.*
### Routing
The project used to use the built-in Flutter screen navigator until it was realized that it does not preserve screen state, so the package [auto_route](https://pub.dev/packages/auto_route) was used to streamline the routing process for persistent screens.
## Floating Action Button
The floating action button in the center of the bottom navigation bar was the main reason for using two bottom navigation bars instead. The functionality is that when it is pressed, sub buttons will pop out, allowing the user to easily access sub-menus and extra screens accompanied with a nice animation. 
# Alarms Section
## Alarms Screen
This screen shows the current alarms and their respective attributes.
### Add Alarms
Using the floating action button, the user can add an alarm and choose its attributes.
### Edit/Delete Alarms
When the user clicks on the cog icon on each alarm, they can edit its attributes or delete the alarm.
### Minigame
Although the alarms work as normal, the permissions to allow alarms to ring even when the app is minimized or closed could not be found and the alarm packages available do not seem to support this functionality either. Therefore, the alarm minigame is currently located in the planner section for ease of testing (since the planner section has not been implemented yet).
## Sleep Time Calculator
Using the floating action button, the user can calculate their ideal sleep time using the time it takes for them to fall asleep and the time for each of their sleep cycles.
*Since it is difficult to consistently fall asleep using the same time and the fact that sleep cycles vary in duration, this tool is more so used to prevent the user from waking up during deep sleep.*
## Theme Changer
This feature has yet to be officially implemented yet, but the base functionality is there. 
Below are some examples of what the alarms screen would look like using different themes.
*Background Image Credits:*
# Social Section
## Browse Posts
Here the user can browse the posts from other users. Each post includes the author, a title, a picture, calories, macro-nutrients, and saved status.
### View User
To get more information on the author of the post, the user can click on the profile picture or the username to open up the author's profile page.
#### Follow
To follow the author of the post, the user can click on the follow button. A second click will unfollow the author.
### View post
To get more information on the post itself, the user can click on the title of the post to bring up the full image of the post which includes the ingredients and instructions. 
*Note: The UI for this section is not completed.*
### Saving
To save a post, the user can simply tap on the heart icon which will play an animation from the [like_button](https://pub.dev/packages/like_button) package. To unsave the post, the user can just tap on the heart icon again.
### Sorting
The button on the top right sorts the posts listed in three ways.
- All Posts
- Posts From Following
- Saved Posts
### Search
The search bar opens up with a clean animation when pressed and functions as a standard search bar.
## Add Posts
Using the floating action button, the user can create a post by adding some details, instructions, a picture, etc.
*Multi-image posts will be implemented in the future.*
### View Your Posts
Using the floating action button, the user can view their own posts.
*Delete post function will be implemented in the future.*
## Profile
Using the floating action button, the user can view their profile.
### Edit Profile
Clicking on the edit profile button allows the user to edit their username, biography, profile picture, and profile cover image.
### Log Out
Click on the log-out function calls Firebase Authentication to log the user out of the application and redirects the user to the login page.
# Tracker Section
## Add Meal
The user can add meals to the tracker using the sub button.
### Search & Sorting
The search bar functionality is the same as the social section, but the posts shown are posts the user has saved and their own posts (accessed through the toggle button on the top right).
# Planner Section
Yet to be implemented.