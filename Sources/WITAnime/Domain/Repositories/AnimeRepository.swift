import Foundation

public struct AnimeRepository {
    public let search: @Sendable (_ query: String) async throws -> [Anime]
    public let seasonalAnime: @Sendable () async throws -> [Anime]
    public let animeSchedule: @Sendable () async throws -> [Anime]
    public let info: @Sendable (_ animeId: Anime.ID) async throws -> Info
    public let episodes: @Sendable (_ animeId: Anime.ID) async throws -> [Episode]
    public let latestEpisodes: @Sendable () async throws -> [Episode]
    public let videoLinks: @Sendable (_ episodeId: Episode.ID) async throws -> [VideoLink]
}
