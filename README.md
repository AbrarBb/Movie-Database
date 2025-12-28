# Movie Database Management System

A comprehensive database application designed to manage and explore movies, artists, directors, and streaming platforms. This project was developed for the CSE302 course, focusing on relational database design, complex queries, and user interaction.

## 📖 Project Overview

This application serves as a central hub for movie enthusiasts to discover content, manage watchlists, and leave reviews. It features a robust backend schema that links movies to their respective metadata (genres, artists, directors) and streaming availability.

### Key Features
* [cite_start]**Authentication System:** Custom authentication with distinct roles for Administrators and Users[cite: 137, 688].
* **Content Management:** Full CRUD capabilities for Movies, Artists, Directors, and Genres.
* **User Interaction:**
    * [cite_start]**Watchlists:** Users can add movies to their personal watchlists[cite: 140].
    * [cite_start]**Reviews & Ratings:** Users can rate movies and leave detailed comments[cite: 304].
    * [cite_start]**Recommendations:** System to track and display movie recommendations[cite: 95].
* **Advanced Reporting:**
    * [cite_start]**Watchlist Comparison:** Compare watchlists between different users[cite: 383].
    * [cite_start]**Aggregated Data:** Reports for "Movies by Genre," "Top Rated," and "Most Active Users"[cite: 383].
    * [cite_start]**Streaming Availability:** Links to platforms (Netflix, Hulu, etc.) where movies are available[cite: 486].
* [cite_start]**Unique Functionality:** A unified view that aggregates complete movie descriptions by joining movie, artist, and director tables into a single interface[cite: 137].

## 🛠 Tech Stack & Implementation
* [cite_start]**Platform:** Oracle APEX (Workspace: PROJECT302MRJ)[cite: 137].
* **Database:** SQL (Relational Schema).
* [cite_start]**Automation:** Database triggers used to auto-fill Primary Keys (IDs) for seamless data entry[cite: 137].

## 🗄️ Database Schema
[cite_start]The project is built on a normalized Relational Schema including the following core entities[cite: 1, 68]:
* **Users:** `AUTH`, `MY_USER`
* **Content:** `MOVIE`, `ARTIST`, `DIRECTOR`, `GENRE`
* **Relationships:** `MOVIE_ARTISTS`, `MOVIE_DIRECTORS`, `MOVIE_STREAMING`
* **User Data:** `USERWATCHLIST`, `REVIEW`, `RECOMMENDATION`

## 🚀 Access & Credentials

**Workspace Details:**
| Setting | Value |
| :--- | :--- |
| **Workspace Name** | [cite_start]`PROJECT302MRJ` [cite: 137] |
| **Workspace Email** | [cite_start]`AXLOLIGHT@GMAIL.COM` [cite: 137] |
| **Project ID** | [cite_start]`11` [cite: 137] |

**User Login Credentials:**
The system supports multiple user roles. [cite_start]Use the following credentials to test the application[cite: 137, 688]:

| Role | Username | Password | Notes |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `1234` | Full access to all forms and reports |
| **User** | `jane` | `1234` | Standard user access |
| **User** | `lajim` | `1234` | Standard user access |
| **User** | `BobBuilder`| `builderpass`| Standard user access |

## 📊 Reports & Analytics
[cite_start]The application includes 16 reports based on aggregate queries, including[cite: 383]:
1.  **Movies With Highest Reviews:** Aggregates review scores to rank content.
2.  **Genre Analysis:** Shows total movies and average rating per genre.
3.  **Popular Actors:** Identifies trending artists.
4.  **Latest Movies:** Displays the most recently released or added content.

## 📝 Conclusion
This project demonstrates the practical application of database concepts, including Entity-Relationship modeling, schema normalization, and complex SQL querying within a web-based interface.
