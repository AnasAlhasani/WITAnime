import Foundation

public typealias SearchUseCase = AsyncUseCase<String, [Anime]>
public typealias DebouncedSearchUseCase = AsyncUseCase<String, [Anime]>
public typealias SeasonalAnimeUseCase = AsyncUseCase<Void, [Anime]>
public typealias AnimeScheduleUseCase = AsyncUseCase<Void, [Anime]>
public typealias InfoUseCase = AsyncUseCase<Anime.ID, Info>
public typealias EpisodesUseCase = AsyncUseCase<Anime.ID, [Episode]>
public typealias LatestEpisodesUseCase = AsyncUseCase<Void, [Episode]>
public typealias VideoLinksUseCase = AsyncUseCase<Episode.ID, [VideoLink]>

enum AnimeError: LocalizedError {
    case noSearchResults(query: String)
    case noEpisodes
    case noVideoLinks
    
    var errorDescription: String? {
        switch self {
        case let .noSearchResults(query):
            return "No results found for '\(query)'"
        case .noEpisodes:
            return "No episodes found"
        case .noVideoLinks:
            return "No servers found"
        }
    }
}

extension SearchUseCase {
    public static func searchUseCase(repository: AnimeRepository = .repository()) -> SearchUseCase {
        .init { query in
            do {
                guard query.isNotEmpty else { return [] }
                let results = try await repository.search(query)
                guard results.isNotEmpty else { throw AnimeError.noSearchResults(query: query) }
                return results
            } catch {
                throw AnimeError.noSearchResults(query: query)
            }
        }
    }
}

extension DebouncedSearchUseCase {
    public static func debouncedSearchUseCase(searchUseCase: SearchUseCase = .searchUseCase()) -> DebouncedSearchUseCase {
        .init { query in
            try await Task.sleep(nanoseconds: 500_000_000)
            return try await searchUseCase(input: query)
        }
    }
}

extension SeasonalAnimeUseCase {
    public static func seasonalAnimeUseCase(repository: AnimeRepository = .repository()) -> SeasonalAnimeUseCase {
        .init(repository.seasonalAnime)
    }
}

extension AnimeScheduleUseCase {
    public static func animeScheduleUseCase(repository: AnimeRepository = .repository()) -> AnimeScheduleUseCase {
        .init(repository.animeSchedule)
    }
}

extension InfoUseCase {
    public static func infoUseCase(repository: AnimeRepository = .repository()) -> InfoUseCase {
        .init(repository.info)
    }
}
 
extension EpisodesUseCase {
    public static func episodesUseCase(repository: AnimeRepository = .repository()) -> EpisodesUseCase {
        .init { animeId in
            let episodes = try await repository.episodes(animeId)
            guard episodes.isNotEmpty else { throw AnimeError.noEpisodes }
            return episodes.reversed()
        }
    }
}

extension LatestEpisodesUseCase {
    public static func latestEpisodesUseCase(repository: AnimeRepository = .repository()) -> LatestEpisodesUseCase {
        .init(repository.latestEpisodes)
    }
}

extension VideoLinksUseCase {
    public static func videoLinksUseCase(repository: AnimeRepository = .repository()) -> VideoLinksUseCase {
        .init { episodeId in
            let links = try await repository.videoLinks(episodeId)
            guard links.isNotEmpty else { throw AnimeError.noVideoLinks }
            return links
        }
    }
}
