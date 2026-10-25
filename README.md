# Places To Go

A Flutter mobile application that helps people choose restaurants and cafes through search and successive rounds of elimination.

## Group Information

| Group Member | Student ID |
| --- | --- |
| Yusuf Ali Matyar | 34128 |
| Hande Ünaldı | 35617 |
| Tuna Genç | 34506 |

## App Overview

Places To Go helps users choose a place to visit through search and successive rounds of elimination. Users enter a location and venue type, such as "Kadıköy restaurants" or "Bağdat Caddesi sushi." The app presents matching places one at a time. Users swipe left to like a place and right to dismiss it, then review their shortlist or start another round using only the places they liked.

The app addresses the difficulty of narrowing down many venue options when planning an outing. Its intended users are students, young adults, and anyone choosing somewhere to eat or meet friends. Our initial testing will focus on restaurants and cafes across Istanbul. The semester goal is a complete search and selection flow with real place data.

## Planned Core Features

- **Place search:** Search by area and venue category using Google Places API text search.
- **Single place cards:** Show a name, address, rating, photo, and a limited selection of reviews when available, with appropriate source attribution.
- **Swipe selection:** Swipe left to like and right to dismiss, with equivalent buttons and an option to finish a round early.
- **Shortlist and repeated elimination:** Display liked places and let users repeat the process until they select a final venue.
- **Saved favorites:** Store favorite place IDs locally so users can revisit selected places after restarting the app.
- **Final place action:** Open the selected venue in Google Maps for location information and directions.

## Optional Features

If time permits, we may add the following features:

- Price and opening status filters.
- Additional venue categories.
- Links to menus or business websites when available.
- User accounts.
- Shared group voting.
- Personalized recommendations.

Automatic menu extraction is outside the core scope.

## Data Requirements and Implementation

We will develop the application in **Flutter and Dart**. **Google Places API** will supply matching places and available details, photos, ratings, and reviews. We will request only the fields needed for each screen.

Google provides a limited selection of reviews, so the app will not promise access to all Google Maps reviews or complete restaurant menus. See the [Google Places API data reference](https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places).

A small local database will store:

- Favorite place IDs.
- User selection records.
- Search preferences.

The active candidate list and round progress will be managed in application state.

We will retrieve Google place content when needed and follow the applicable storage and attribution rules, rather than treating Google content as our own permanent venue database. See the [Google Places API policies and attribution requirements](https://developers.google.com/maps/documentation/places/web-service/policies).

A small backend proxy will protect the API key and apply request limits. Core functionality does not require user accounts.

## Potential Challenges and Scope Control

- **API access and cost:** Billing setup, quotas, and photo requests require care. We will limit result batches and fetch detailed content only when needed.
- **Data quality and search relevance:** Some venues have missing photos, ratings, or reviews. We will provide placeholders, explain empty results, and test representative Turkish queries.
- **Selection state and usability:** Repeated rounds must preserve the correct shortlist. We will test swipe directions, early completion, and empty selections, and provide clear loading and error states.
- **External service dependency:** We will use labeled mock data to develop and test the interface before completing live API integration. We will validate API access early and keep advanced features optional.

## Team Responsibilities

The Step 1 coordinator will organize meetings, track task assignments, and communicate with the assigned TA. Every member will review the final proposal and be able to explain their contribution.

| Assigned Member | Step 1 Tasks |
| --- | --- |
| Yusuf Ali Matyar | Draft the app overview, intended users, core features, and optional scope. |
| Tuna Genç | Check API feasibility, data requirements, and technical challenges; review the proposal. |
| Hande Ünaldı | Coordinate Step 1 and TA communication; prepare GitHub access, README, Flutter `.gitignore`, and initial commit. |

## GitHub Repository Plan

The team repository is linked in the Group Information section. Before submission, we will ensure that:

- The repository is public.
- All group members have collaborator access.
- The instructor and assigned TA can access the repository.
- The README includes the project title, overview, and group details.
- A Flutter `.gitignore` file and an initial commit are present.

## Technical References

1. [Google Places API Data Reference](https://developers.google.com/maps/documentation/places/web-service/reference/rest/v1/places)
2. [Google Places API Policies and Attributions](https://developers.google.com/maps/documentation/places/web-service/policies)
