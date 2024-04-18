# WITAnime
A Swift package that scrapes Anime data from witanime.com

## Use Cases 
- SearchUseCase
- DebouncedSearchUseCase
- SeasonalAnimeUseCase
- AnimeScheduleUseCase
- InfoUseCase
- EpisodesUseCase
- LatestEpisodesUseCase
- VideoLinksUseCase

## Example 

```swift
// Step 1: Import `WITAnime` package.
import WITAnime

// Step 2: Create UseCases for specific feature in your application.
let debouncedSearchUseCase: DebouncedSearchUseCase = .debouncedSearchUseCase()
let episodesUseCase: EpisodesUseCase = .episodesUseCase()
let videoLinksUseCase: VideoLinksUseCase = .videoLinksUseCase()

// Step 3: Now you are ready to use it
// Search for an anime        
let query = "Mushoku Tensei"
let results = try await debouncedSearchUseCase(input: query)

// Fetch Anime episodes
let anime: Anime = try XCTUnwrap(results.first)
let episodes = try await episodesUseCase(input: anime.id)

// Fetch episode video links
let episode1 = try XCTUnwrap(episodes.first)
let videoLinks = try await videoLinksUseCase(input: episode1.id)

// Step 4: Load the video using `WKWebView`        
webView.load(request: URLRequest(url: videoLink.url))
```

## Installation
### Swift Package Manager

```swift
"https://github.com/AnasAlhasani/WITAnime.git"
```
