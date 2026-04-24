# 🚀 SwiftFeed – High Performance Feed App

A high-performance infinite scrolling social feed built using Flutter, Riverpod, and Supabase. The app focuses on performance optimization, memory efficiency, and robust handling of real-world edge cases like offline mode and rapid user interactions.

---

## 📱 Features

* Infinite scrolling feed with pagination
* Pull-to-refresh support
* Optimistic UI for likes
* Spam click protection (debouncing)
* Hero animations for smooth transitions
* Offline error handling with rollback
* 3-tier image loading (thumbnail → mobile → raw)

---

## ⚙️ Tech Stack

* Flutter
* Riverpod (State Management)
* Supabase (Database + Storage + RPC)

---

## 🧠 Architecture

The app follows a clean separation of concerns:

* **UI Layer** → Handles rendering and user interactions
* **State Layer (Riverpod)** → Manages feed state and API calls
* **Backend (Supabase)** → Handles data storage and concurrency-safe operations

---

## 🧠 State Management (Riverpod Approach)

The app uses Riverpod with a `StateNotifier` to manage the feed state.

* The `feedProvider` is responsible for:

  * Fetching paginated posts from Supabase
  * Merging user-specific like state (`isLiked`)
  * Updating UI reactively

### Key Design Decisions:

* Clear separation between UI and business logic
* Optimistic UI updates for instant feedback
* Error handling with rollback on failure
* Prevention of duplicate API calls during rapid scrolling

---

## ⚡ Performance Optimizations

### 🎨 GPU Optimization (RepaintBoundary)

* Each feed card is wrapped with `RepaintBoundary`
* Prevents unnecessary re-rasterization of heavy UI (images + shadows)

#### Verification:

* Enabled `showPerformanceOverlay: true`
* Observed stable frame rendering during fast scrolling
* No noticeable jank or GPU spikes

---

### 🧠 Memory Optimization (cacheWidth)

* Images are loaded using `cacheWidth` to match display size

#### Example:

* UI image height ≈ 400px
* Device pixel ratio ≈ 3
  → `cacheWidth ≈ 1200`

#### Verification:

* Tested using Flutter DevTools
* Observed stable memory usage during scrolling
* No crashes or memory spikes (OOM prevention)

---

### 🌐 Network Optimization

* Pagination (10 items per request)
* Debounced API calls to prevent spam requests

---

## ❤️ Like System (Optimistic UI)

* UI updates instantly when user taps like
* Backend sync happens asynchronously via Supabase RPC
* Race condition handled using SQL function
* On failure:

  * UI state is reverted
  * Error shown via SnackBar

---

## 🌐 Offline Handling

* Internet connectivity is checked before API calls
* When offline:

  * API calls are prevented
  * "You're offline" message is shown
* Optimistic updates automatically rollback on failure

---

## ⚠️ Edge Case Handling

* **Spam Clicking** → Prevented duplicate API calls
* **Offline Mode** → Safe fallback + UI rollback
* **Widget Lifecycle Safety** → Used `mounted` checks to avoid setState after dispose

---

## 🎯 UI/UX Enhancements

* Skeleton loaders for better perceived performance
* Graceful image fallback using `errorBuilder`
* Smooth Hero animations between feed and detail screen

---

## 🎬 Demo Video

👉 https://drive.google.com/file/d/1j8XabA9jwHZQRlSacrPSD8-Wtl3m2juL/view?usp=sharing

---

## 🛠 Setup Instructions

1. Create a Supabase project
2. Run the provided SQL schema
3. Create a public storage bucket named `media`
4. Run the Python seeding script to upload images
5. Add your Supabase **Project URL** and **publishable (anon) key** in Flutter

---

## 🎯 Conclusion

This project demonstrates:

* Efficient state management using Riverpod
* GPU optimization using RepaintBoundary
* Memory optimization using cacheWidth
* Robust handling of real-world edge cases

---
