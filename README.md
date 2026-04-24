# swift_feed_app

🚀 SwiftFeed – High Performance Feed App
A high-performance infinite scrolling social feed built using Flutter, Riverpod, and Supabase.
________________________________________
📱 Features
•	Infinite scrolling feed with pagination 
•	Pull-to-refresh support 
•	Optimistic UI for likes 
•	Spam click protection (debouncing) 
•	Hero animations for smooth transitions 
•	Offline error handling with rollback 
•	3-tier image loading (thumb → mobile → raw) 
________________________________________
⚙️ Tech Stack
•	Flutter 
•	Riverpod (State Management) 
•	Supabase (Database + Storage + RPC) 
________________________________________
🧠 Architecture
The app follows a clean separation:
•	UI Layer → Handles rendering & user interaction 
•	State Layer (Riverpod) → Manages feed state & API calls 
•	Backend (Supabase) → Handles data + concurrency-safe RPC 
________________________________________
⚡ Performance Optimizations
1. GPU Optimization
•	Used RepaintBoundary to isolate heavy UI cards 
•	Prevents unnecessary re-rasterization during scrolling 
________________________________________
2. Memory Optimization
•	Used cacheWidth in images 
•	Ensures decoded image size matches display size 
•	Prevents OOM (Out Of Memory) 
________________________________________
3. Network Optimization
•	Pagination (10 items per request) 
•	Debounced like API calls to prevent spamming 
________________________________________
❤️ Like System
•	Instant UI update (Optimistic UI) 
•	Backend sync using Supabase RPC 
•	Race condition safe using SQL function 
•	Proper rollback on failure (offline mode) 
________________________________________
🌐 Offline Handling
•	UI updates instantly 
•	If API fails: 
o	State is reverted 
o	Error shown via SnackBar 
________________________________________
🎬 Demo
👉 (Add your screen recording link here)
________________________________________
🛠 Setup Instructions
1.	Create Supabase project 
2.	Run SQL schema 
3.	Create storage bucket media 
4.	Run Python seeder script 
5.	Add Supabase URL + key in Flutter


