import Foundation

public struct AnimeRepository {
    public let search: (_ query: String) async throws -> [Anime]
    public let info: (_ animeId: Anime.ID) async throws -> Info
    public let episodes: (_ animeId: Anime.ID) async throws -> [Episode]
    public let latestEpisodes: () async throws -> [Episode]
    public let videoLinks: (_ episodeId: Episode.ID) async throws -> [VideoLink]
}
