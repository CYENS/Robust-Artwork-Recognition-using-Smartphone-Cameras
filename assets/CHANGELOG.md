## Version 1.0.0 (2021-12-21)
- App migrated to null-safety
- Many UI improvements and bug fixes

## Version 0.12.2 (2021-02-17)
- Minor UI improvements
- New tile in settings with link to the Gallery's website
- More bug fixes

## Version 0.12.1 (2021-02-15)
- Bug fixes

## Version 0.12.0 (2021-02-15)
- Preparations for app evaluation
- Added message in camera view informing the user if no artworks are identified
- CNN inferences are paused properly if the app is closed or put in the background, and resume once 
  the user returns to the app
- More consistent use of fonts, font sizes and paddings throughout the app 
- Complete localization of app UI to Greek
- Moved non-user related settings to expandable tile
- Many bug fixes

## Version 0.11.1 (2021-02-12)
- Rearranged the details presented in camera view, added ability to hide them altogether
- Fixed issue with app pushing 2 artwork detail pages into navigator
- Fixed crash on devices with Android version <= 6.0

## Version 0.11.0 (2021-02-12)
- Much improved Explore page with animations
- Added vibration when the app recognises an artwork
- Only 1 CNN is now included in the app
- Added library for error reporting
- Fixed displaying this changelog
- More localisations

## Version 0.10.0 (2021-02-10)
- App navigation completely redesigned, using a new NavBar with a prominent "Identify artwork" 
  button
- Artwork identification is now more reliable 

## Version 0.9.1 (2021-02-01)
- Added new app icon, based on the painting by Vera Hadjida "Untitled" (1973)
- Added missing artist photos
- Removed unneeded request for microphone permission on Android
- Remove all but 3 CNNs, MobileNetV2 based CNN is now the default
- Library updates

## Version 0.9.0 (2021-01-05)
- Multiple changes in included CNNs
- Many bug fixes

## Version 0.8.2 (2020-11-04)
- Added 3 more CNNs for testing
- Bug fixes

## Version 0.8.1 (2020-11-02)
- Added option to automatically navigate to a recognised artwork's
  details
- New setting for exporting list of recognitions and the timings of each

## Version 0.8.0 (2020-10-29)
- Implementation of a total of 4 algorithms that allow the selection of
  the correct artwork from the stream of CNN predictions; these will be
  used for testing the optimal combination of model/algorithm that gives
  the most reliable results
- Major changes to the underlying structure of the app's database
)
## Version 0.7.1 (2020-10-23)
- Fixed bug that caused Tensorflow models to be re-loaded after every
  inference
- Implementation of one more algorithm that allows the selection of the
  correct artwork from the stream of CNN predictions; more to follow

## Version 0.7.0 (2020-10-19)
- First implementation of algorithm that allows the selection of the
  correct artwork from the stream of CNN predictions (averaging the
  predictions for 5 frames in a row); more implementations of algorithms
  will follow, so their potential for use in the app can be evaluated
- New settings option for setting the sensitivity of the CNN currently
  used by the app, again mostly for testing purposes
- Massive re-structuring of the Python scripts used in the training of
  the CNNs

## Version 0.6.2 (2020-10-14)
- The selection of the CNN type being used was moved to Settings,
  instead of as a list of buttons in the "Identify artwork" screen
- Preparation for implementing artwork auto-detection logic (i.e. how to
  decide which of the CNN inferred artworks is the correct one)

## Version 0.6.1 (2020-10-13)
- Added new artwork recognition CNNs based on MobileNet, they are much
  faster, smaller in size, and have comparable accuracy with the
  previous VGG19 based CNNs
- Settings screen was reorganised and translated to Greek
- Improved Artwork/Artist detail pages

## Version 0.6.0 (2020-10-12)
- All artwork and artist entries updated with actual descriptions and
  biographies
- High resolution images of the artworks added
- Incorporated CNN now has the ability to detect if _no artworks_ are
  present in the frame
- New experimental neural network incorporated into the app, able to
  detect if 0, 1 or 1+ artworks are present in the frame

## Version 0.5.0 (2020-09-29)
- The app's database is now fully internationalised for both Greek and
  English

## Version 0.4.4 (2020-09-25)
- App now shows small images of the recognised artworks next to the
  Tensorflow inferences
- Preparation for internationalisation of the app's database schema
- Bug fixes

## Version 0.4.3 (2020-09-23)
- Added ability to navigate from Tensorflow inferences to artwork detail
  pages
- Updated artwork/artist detail pages
- Added more translations to Greek

## Version 0.4.2 (2020-09-22)
- Updated app database with actual artworks from the Gallery (13
  paintings and 3 sculptures)
- Removed older placeholder artworks

## Version 0.4.1 (2020-09-17)
- The Convolutional Neural Network can now detect an additional 3
  sculptures in the Gallery

## Version 0.4.0 (2020-09-15)
- The app now incorporates a Convolutional Neural Network (based on VGG19) capable of detecting 13 
  artworks in the Gallery; more artworks will be added in future updates

## Version 0.3.0 (2020-09-11)
- Translated app to Greek
- Bug fixes

## Version 0.2.0 (2020-09-07)
- Added Settings page
- New tile in Explore page showing featured artwork

## Version 0.1.1 (2020-09-04)
- The app's database is now auto-populated on first app launch

## Version 0.1.0 (2020-09-02)
- First minor version
- Overhaul of pages showing details for Artists and Artworks
  - Artist detail page now includes a list of all artworks by Artist
- Standardisation of all app widgets (e.g. tiles, rows, lists)
- More database improvements

## Version 0.0.10 (2020-09-01)
- Added new page showing artist details
- General database improvements

## Version 0.0.9 (2020-08-27)
- App database now fully functional
- App is able to update it's database from a remote backend
- UI updates

## Version 0.0.8 (2020-08-25)
- Incorporated database into app
- More UI tweaks

## Version 0.0.7 (2020-08-24)
- Added Bottom Navigation Bar to Home page
- Removed AppBar in Home page

## Version 0.0.6 (2020-08-20)
- Added widget with list of painters on main screen
- UI redesign
- Major codebase restructuring

## Version 0.0.5 (2020-08-19)
- Added widget with list of paintings on main screen
- Bug fixes

## Version 0.0.4 (2020-08-17)
- Added widget with list of paintings, as well as widget showing individual painting details
- Initial stages of incorporating a database into the app

## Version 0.0.3 (2020-08-11)
- Added Tensorflow integration and demo widget showing its use

## Version 0.0.2 (2020-08-10)
- Added painting details screen
- New home screen

## Version 0.0.1 (2020-08-08)
- First version, adds support for accessing and using the camera to take and display photos
