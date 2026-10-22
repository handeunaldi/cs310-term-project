# cs310-term-project

# A Supportive App For People To Choose Restaurants/Cafes

A Flutter mobile application that helps people choose restaurants and cafes through search and successive rounds of elimination.

## Group Information

- **Group number:** [Group number]
- **Step 1 coordinator:** Hande Ünaldı
- **GitHub repository:** [cs310-term-project](https://github.com/handeunaldi/cs310-term-project)

| Group Member | Student ID |
| --- | --- |
| Yusuf Ali Matyar | [Student ID] |
| Hande Ünaldı | [Student ID] |
| Tuna Genç | [Student ID] |

## App Overview

Mekan Seç helps users choose a place to visit through search and successive rounds of elimination. Users enter a location and venue type, such as "Kadıköy restaurants" or "Bağdat Caddesi sushi." The app presents matching places one at a time. Users swipe left to like a place and right to dismiss it, then review their shortlist or start another round using only the places they liked.

The app addresses the difficulty of narrowing down many venue options when planning an outing. Its intended users are students, young adults, and anyone choosing somewhere to eat or meet friends. Our initial testing will focus on restaurants and cafes across Istanbul. The semester goal is a complete search and selection flow with real place data.

## Planned Core Features

- **Place search:** Search by area and venue category using Google Places API text search.
- **Single place cards:** Show a name, address, rating, photo, and a limited selection of reviews when available, with appropriate source attribution.
- **Swipe selection:** Swipe left to like and right to dismiss, with equivalent buttons and an option to finish a round early.
- **Shortlist and repeated elimination:** Display liked places and let users repeat the process until they select a final venue.
- **Saved favorites:** Store favorite place IDs locally so users can revisit selected places after restarting the app.
- **Final place action:** Open the selected venue in Google Maps for location information and directions.
