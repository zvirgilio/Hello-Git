# Pre-work - *tips*

**tips** is a tip calculator application for iOS.

Submitted by: **Zach Virgilio**

Time spent: **~18** hours spent in total (6 for the additional modifications)

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins) 
* [x] Using locale-specific currency and currency thousands separators.
* [ ] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Store your previously tipped value permanently (This is a precursor to the bill amount saving).
- [x] The keyboard opens and the bill amount is always the first responded, but the keyboard can be hidden by tapping elsewhere.
- [x] App tracks the users current location, to help format itself and provide helpful information
- [x] Change currency based on your geographic location.  Currency format is not the cleanest, and many symbols are replaced by with their text codes ("GBP" instead of the pound symbol for instance).
- [x] A notification that tipping may not be appropriate in this country pops up when the users opens the app in such a country, with the option to follow a link to a webpage with detailed information (Only implemented for Great Britain, but easy to expand).

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

![alt tag](https://raw.github.com/zvirgilio/Hello-Git/master/tipWalkthrough2Loc.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I had no idea how Swift, Xcode, or apps worked in general.  I spent a lot of my time searching for answers to questions so simple that most peopel didn't feel the need to post tutorials. Once I got through that, I had to learn how to use protocols and get comfortable with spending a lot of time reading Apple's documentation for all the goodies in UIKit.

Implementing the map took most of the extra time.  I had plans to also edit the tip and total labels so that all currency symbols appeared using their unicode hex encodings, but ran out of time.
## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
