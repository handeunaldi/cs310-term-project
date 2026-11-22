# Places To Go

A Flutter mobile application that helps people choose restaurants and cafés through search and successive rounds of elimination.

## Group Information

**CS310 Mobile Application Development · Group 6**

| Group Member | Student ID |
| --- | --- |
| Yusuf Ali Matyar | 34128 |
| Hande Ünaldı | 35617 |
| Tuna Genç | 34506 |

Repository links and the implementation reviewed for this README are listed below.

- [Team repository](https://github.com/handeunaldi/cs310-term-project)
- [Step 2.2 implementation commit](https://github.com/handeunaldi/cs310-term-project/commit/feda6250e838f157525cdb5511d4005dba94aa28)

## App Overview

Places To Go addresses the difficulty of narrowing down many venue options when planning an outing. Its intended users are students, young adults, and anyone choosing somewhere to eat or meet friends. Our initial testing focuses on restaurants and cafés across Istanbul.

The semester goal is a complete search and selection flow with real place data. Users will enter an area and venue type, review matching places one at a time, and narrow their shortlist through successive rounds of elimination.

The Step 2.2 implementation provides the Flutter interface and working navigation using sample data. Users can browse spot cards, keep or skip places, remove items from their shortlist, discover saved spots from sample profiles, and create or join demo crews.

## Planned Core Features

| Feature | Semester goal | Step 2.2 implementation |
| --- | --- | --- |
| Place search | Search by area and venue category using Google Places API text search. | Home accepts a query or suggestion and opens a fixed sample spot list. |
| Single place cards | Show a name, address, rating, photo and available review content, with source attribution. | Sample cards show the place name, area, rating and review, with a photo placeholder. |
| Swipe selection | Select or dismiss places through gestures and equivalent buttons, with an option to finish early. | Like and Skip advance through the cards. Done opens the current shortlist. |
| Shortlist and repeated elimination | Repeat rounds using liked places until a final venue is selected. | Your Picks shows the current round's selections and supports removal. |
| Saved favorites | Store favorite place IDs locally for later visits. | Profile screens display sample saved spots with local cover images. |
| Final place action | Open the selected venue in Google Maps. | Planned for later development. |

## Step 2.2 Screens and Interactions

### Sign Up and Log In

Sign Up contains name, email and password fields. The form checks for a non-empty name, an email containing an `@` character, and a password of at least eight characters. Field errors appear beneath the corresponding input.

Users must accept the Terms and Privacy Policy checkbox. A valid submission opens an **Account created** confirmation dialog. **Continue** then opens Home. Log In checks the email and password inputs and also opens Home.

These screens demonstrate form validation and navigation. Account creation and credential verification are planned for Firebase integration in Step 3.

### Home

Home contains a search field, a submit button and suggestion chips such as **Brunch in Moda**. Empty searches produce a message. A non-empty query or suggestion opens **Pick Your Spots** with sample places.

The profile avatar opens Profile. The shared bottom bar links Home, Explore and Profile.

### Pick Your Spots

Each card shows a sample venue's name, area, rating and review. **Like** adds the current place to the round's shortlist. **Skip** advances without selecting it. The progress indicator tracks the displayed card.

**Done** opens Your Picks, including when the user finishes early. After the final card, the screen opens Your Picks automatically. This stage uses button-based selection.

### Your Picks

The shortlist is displayed as model objects using reusable **Card** widgets. Each item contains its place name, area, network image and heart button. Tapping the heart removes that item from the current screen's list. An empty state appears when all picks have been removed.

**Share with the crew** opens Crews and prompts for a new crew name. The newly created crew records the number of selected spots.

### Profile and Demo Profiles

The main Profile displays the sample user Deniz Yılmaz, activity counts, crew memberships and saved-spot covers. **See all** opens the sample picks list. Crew rows open Crews.

Explore also opens profiles for ten sample users. Each demo profile has a name, username, avatar initials, activity counts, example memberships and three saved spots. **See all** on a demo profile opens that person's saved-spot list.

### Explore

Explore shows **Saved by others** as a photo grid. It includes all 30 saved-spot entries from the ten sample profiles. Entries are shown independently of location. A venue saved by several people appears for each person who saved it.

The search field filters profiles by name or username. It accepts usernames with an `@` prefix and supports common Turkish character substitutions, such as searching `genc` for Genç. Opening a search result or a photo card displays the associated profile.

**See crews** opens the user's crew list.

### Crews and the Five-Digit Code Sheet

Crews starts with **Weekend Brunch Club** and **Office Lunch Crew** as example memberships. Two buttons appear above the list.

- **Create crew** opens a name form. Empty names and existing crew names produce validation errors. A valid name creates a crew and opens the five-digit invitation code sheet.
- **Join crew** opens a five-digit code field. Entering the demo code `24680` joins **Moda Coffee Walk**. Unknown codes and duplicate membership produce messages.

The code sheet implements the **7a Digit Code** design. **Copy** copies the code. **Share** requests the platform's share interface and uses a clipboard fallback when sharing is unavailable. **Done** closes the sheet.

Created crews and the demo joined membership are stored locally. They remain available after reopening the app on the same device or browser profile. Cross-device invitation lookup and synchronized membership are planned for later development.

## Changes Made During Step 2.2

The initial proposal has developed into a connected Flutter interface with the following additions.

- Added Sign Up, Log In, Home, Pick Your Spots, Your Picks, Profile, Explore and Crews.
- Added a shared light and dark theme, reusable spacing and text styles, and the Plus Jakarta Sans custom font.
- Added sample profile data, local venue cover images and clickable saved-spot previews.
- Expanded Explore from a nearby-spot mockup to a location-independent feed and profile search.
- Added a **See crews** entry point and explicit **Create crew** and **Join crew** buttons.
- Added crew names, five-digit invitation codes, copy and share actions, and local membership storage.
- Connected Your Picks to crew creation and adapted Profile to display both the main user and demo users.

## Data Requirements and Implementation

The app is developed in **Flutter and Dart**. Current interface data is represented by the following classes and store.

| Component | Purpose |
| --- | --- |
| `Place` | Stores a sample venue's name, area, image URL, optional local cover asset, rating and review. |
| `Crew` | Stores a crew name, initial, member count, spot count and optional invitation code. |
| `DemoProfile` | Groups a sample user's identity, saved spots, memberships and visited count. |
| `CrewStore` | Loads and saves local crews, creates invitation codes and handles demo joins. |

The active candidate list and round progress are held in screen state. The shortlist screen receives a copy of the selected places. Crew data is serialized as JSON and stored with `shared_preferences`.

The semester plan uses **Google Places API** to supply matching places and available details, photos, ratings and reviews. We will request only the fields needed by each screen. Google provides a limited selection of reviews, which shapes the venue details the app can display. [Google Places API data reference](https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places)

Future storage work includes favorite place IDs, selection records and search preferences. Google place content will be retrieved when needed, following applicable storage and attribution requirements. The planned backend proxy will protect API access and apply request limits. [Google Places API policies](https://developers.google.com/maps/documentation/places/web-service/policies)

## Project Organization

| Path | Contents |
| --- | --- |
| `lib/main.dart` | Application entry point, theme setup, shared crew store and screen routes. |
| `lib/screens/` | Screen layouts, form handling and user interactions. |
| `lib/models/` | Place, crew and profile models, sample data and crew storage. |
| `lib/widgets/` | Shared navigation, headers, place cards, photos, crew rows and the code sheet. |
| `lib/theme/` | Shared colors, text styles, spacing and light/dark theme definitions. |
| `assets/fonts/` | Plus Jakarta Sans font files. |
| `assets/spots/` | Cover photos for the sample venues. |
| `pubspec.yaml` | Flutter SDK constraint, dependencies, font configuration and asset registration. |

The project uses `share_plus` for platform sharing and `shared_preferences` for local crew storage. Venue images include local assets and network images. The local covers illustrate fictional demo venues. [Photo sources](assets/spot-photo-sources.md)

## Run the App

The Step 2.2 code was verified with **Flutter 3.47.8** and **Dart 3.13.7**. The declared Dart SDK constraint is `^3.13.7`.

Install Flutter and configure the Android toolchain for an Android emulator, or Xcode and an iOS simulator on macOS. Check the local setup before running.

```sh
flutter --version
flutter doctor
```

Clone the repository and install its dependencies.

```sh
git clone https://github.com/handeunaldi/cs310-term-project.git
cd cs310-term-project
flutter pub get
```

Start an emulator or simulator, list the available devices and run the app.

```sh
flutter devices
flutter run
```

To select a particular device, use its ID from `flutter devices`.

```sh
flutter run -d <device-id>
```

For a browser preview, select Chrome.

```sh
flutter run -d chrome
```

Internet access is used to install dependencies and load the network images in Your Picks.

## Demo Walkthrough and Verification

1. Open Sign Up, enter a name, email and password, accept the terms and continue to Home.
2. Tap **Brunch in Moda**, then use **Like** and **Skip** before selecting **Done**.
3. In Your Picks, tap a heart to remove a venue.
4. Open Explore from Home or Profile. Search for `tuna` or `@tunagenc` and open the profile.
5. Return to Explore, tap **See crews**, then **Create crew**. Enter a unique name to obtain a code.
6. Use **Join crew** with `24680` and confirm that Moda Coffee Walk appears.
7. Reopen the app and check that the locally stored crew memberships remain visible.

The reviewed code passed `flutter analyze` and a release web build. Review-time widget checks covered form validation, navigation, card removal, profile search and crew persistence at 320 × 568 and 430 × 932 portrait sizes. Browser checks covered login, profile search, crew creation and demo joining. Android and iOS runtime verification should be performed on the team's target emulator or simulator.

```sh
flutter analyze
flutter build web --release
```

## Team Responsibilities

### Step 1 Tasks

| Assigned Member | Contribution |
| --- | --- |
| Yusuf Ali Matyar | App overview, intended users, core features and optional scope. |
| Tuna Genç | API feasibility, data requirements, technical challenges and proposal review. |
| Hande Ünaldı | Step 1 coordination and TA communication, GitHub access, README, Flutter `.gitignore` and initial commit. |

### Step 2.2 Member Contributions

| Member | Implemented work |
| --- | --- |
| Hande Ünaldı | Flutter project setup, shared themes and custom font, Sign Up and Log In forms, and the initial Your Picks screen with reusable model-based cards and removal. |
| Yusuf Ali Matyar | Home, Pick Your Spots and the original Profile screen, sample crew data, bottom navigation and the routes connecting those screens. |
| Tuna Genç | Explore, ten sample profiles and their saved spots, profile search, local cover images, Crews, five-digit invitation codes, demo joining, local storage and integration with Profile and Your Picks. |

## Potential Challenges and Scope Control

- **API access and cost** require billing setup, quota control and careful photo requests. We plan to limit result batches and request details only when needed.
- **Data quality and search relevance** require handling venues with missing photos, ratings or reviews, along with empty search results and representative Turkish queries.
- **Selection state and usability** require preserving the correct shortlist across repeated rounds, early completion and empty selections.
- **Crew synchronization** requires a backend to share invitations and memberships between devices.
- **External service dependencies** require clear loading and failure states. The current sample data supports interface development while these integrations are completed.

## Optional Features

If time permits, we may add price and opening-status filters, additional venue categories, links to menus or business websites, shared group voting and personalized recommendations.

The account forms and crew interfaces provide starting points for further backend work. Automatic menu extraction remains outside the planned semester scope.

## GitHub Repository and Submission

The shared repository contains the Flutter source, local assets and a Flutter `.gitignore`. Each member contributes through their own GitHub account. The group manages collaborator access and TA access through the repository settings.

The Step 2.2 submission PDF is named **CS310_Group6_Step2.2.pdf**. It contains the repository link, selected submission commit ID, labeled core-screen screenshots and member contributions. The selected commit in the PDF should match the version submitted for assessment.

## Technical References

- [Google Places API Data Reference](https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places)
- [Google Places API Policies and Attributions](https://developers.google.com/maps/documentation/places/web-service/policies)
- [Demo photo sources](assets/spot-photo-sources.md)
