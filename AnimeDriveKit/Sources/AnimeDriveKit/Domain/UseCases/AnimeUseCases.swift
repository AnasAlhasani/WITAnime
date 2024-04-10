import Foundation

public typealias SearchUseCase = AsyncUseCase<String, [Anime]>
public typealias InfoUseCase = AsyncUseCase<Anime.ID, Info>
public typealias EpisodesUseCase = AsyncUseCase<Anime.ID, [Episode]>
public typealias LatestEpisodesUseCase = AsyncUseCase<Void, [Episode]>
public typealias VideoLinksUseCase = AsyncUseCase<Episode.ID, [VideoLink]>

extension AsyncUseCase {
    public static func resolve(repository: AnimeRepository = .resolve()) -> SearchUseCase {
        .init(repository.search)
    }

    public static func resolve(repository: AnimeRepository = .resolve()) -> InfoUseCase {
        .init(repository.info)
    }
    
    public static func resolve(repository: AnimeRepository = .resolve()) -> EpisodesUseCase {
        .init(repository.episodes)
    }
    
    public static func resolve(repository: AnimeRepository = .resolve()) -> LatestEpisodesUseCase {
        .init(repository.latestEpisodes)
    }
    
    public static func resolve(repository: AnimeRepository = .resolve()) -> VideoLinksUseCase {
        .init(repository.videoLinks)
    }
}
