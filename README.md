# Movie Database Management System

A comprehensive database application designed to manage and explore movies, artists, directors, and streaming platforms. This project was developed for the CSE302 course, focusing on relational database design, complex queries, and user interaction.

## 📖 Project Overview

This application serves as a central hub for movie enthusiasts to discover content, manage watchlists, and leave reviews. It features a robust backend schema that links movies to their respective metadata (genres, artists, directors) and streaming availability.

### Key Features
* **Authentication System:** Custom authentication with distinct roles for Administrators and Users.
* **Content Management:** Full CRUD (Create, Read, Update, Delete) capabilities for Movies, Artists, Directors, and Genres.
* **User Interaction:**
    * **Watchlists:** Users can add movies to their personal watchlists.
    * **Reviews & Ratings:** Users can rate movies and leave detailed comments.
    * **Recommendations:** System to track and display movie recommendations.
* **Advanced Reporting:**
    * **Watchlist Comparison:** Compare watchlists between different users to find common interests.
    * **Aggregated Data:** Reports for "Movies by Genre," "Top Rated," and "Most Active Users".
    * **Streaming Availability:** Links to platforms (Netflix, Hulu, etc.) where movies are available.
* **Unique Functionality:** A unified view that aggregates complete movie descriptions by joining the movie, artist, and director tables into a single interface.

## 🛠 Tech Stack & Implementation
* **Platform:** Oracle APEX (Workspace: PROJECT302MRJ).
* **Database:** SQL (Relational Schema).
* **Automation:** Database triggers were used to auto-fill Primary Keys (IDs) for seamless data entry.

## 🗄️ Database Schema
The project is built on a normalized Relational Schema including the following core entities:
* **Users:** `AUTH`, `MY_USER`
* **Content:** `MOVIE`, `ARTIST`, `DIRECTOR`, `GENRE`
* **Relationships:** `MOVIE_ARTISTS`, `MOVIE_DIRECTORS`, `MOVIE_STREAMING`
* **User Data:** `USERWATCHLIST`, `REVIEW`, `RECOMMENDATION`

## 🚀 Access & Credentials

**Workspace Details:**
| Setting | Value |
| :--- | :--- |
| **Workspace Name** | `PROJECT302MR` |
| **Workspace Email** | `AXLOLIGHT@GMAIL.COM` |
| **Project ID** | `11` |

**User Login Credentials:**
The system supports multiple user roles. Use the following credentials to test the application:

| Role | Username | Password | Notes |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `****` | Full access to all forms and reports |
| **User** | `jane` | `1234` | Standard user access |
| **User** | `lajim` | `1234` | Standard user access |
| **User** | `BobBuilder`| `builderpass`| Standard user access |

## 📊 Reports & Analytics
The application includes 16 reports based on aggregate queries, including:
1.  **Movies With Highest Reviews:** Aggregates review scores to rank content.
2.  **Genre Analysis:** Shows total movies and average rating per genre.
3.  **Popular Actors:** Identifies trending artists.
4.  **Latest Movies:** Displays the most recently released or added content.
5.  **Most Active User:** Calculates activity based on added movies and reviews.

## 📝 Conclusion
This project demonstrates the practical application of database concepts, including Entity-Relationship modeling, schema normalization, and complex SQL querying within a web-based interface.
