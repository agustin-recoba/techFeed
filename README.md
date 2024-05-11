# techfeed

Simple flutter app to read tech related news with RSS.

![alt text](https://github.com/agustin-recoba/techFeed/blob/main/README%20media/showcase%20animation.gif?raw=true)

# Features:
- Add new sources and delete existing ones
- Re-order sources on main menu
- Sources added and deleated persist between sessions (Shared Preferences)
- List news from all sources or one
- Search by news title
- Long press on news card to get more details
	
# Known issues:
- Sources that work on a server with CORS wont work in the web version (FIX: use a proxy to add CORS headers to each request)
