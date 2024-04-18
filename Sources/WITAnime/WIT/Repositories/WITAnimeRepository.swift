import Foundation

public extension AnimeRepository {
    static func repository(apiClient: APIClient = .apiClient()) -> Self {
        .init(
            search: { query in
                try await apiClient
                    .data("https://witanime.cyou?search_param=animes&s=\(query)")
                    .decode(using: .animeDecoder)
            }, 
            seasonalAnime: {
                let url = try await apiClient.data("https://witanime.cyou").decode(using: .urlDecoder(ofType: .seasonal))
                return try await apiClient.data(url.absoluteString).decode(using: .animeDecoder)
            },
            animeSchedule: {
                let url = try await apiClient.data("https://witanime.cyou").decode(using: .urlDecoder(ofType: .schedule))
                return try await apiClient.data(url.absoluteString).decode(using: .scheduleDecoder())
            },
            info: { animeId in
                try await apiClient
                    .data("https://witanime.cyou/anime/\(animeId)")
                    .decode(using: .infoDecoder)
            },
            episodes: { animeId in
                try await apiClient
                    .data("https://witanime.cyou/anime/\(animeId)")
                    .decode(using: .episodesDecoder(ofType: .all))
            },
            latestEpisodes: {
                try await apiClient
                    .data("https://witanime.cyou/episode")
                    .decode(using: .episodesDecoder(ofType: .latest))
            },
            videoLinks: { episodeId in
                try await apiClient
                    .data("https://witanime.cyou/episode/\(episodeId)")
                    .decode(using: .videoLinksDecoder)
            }
        )
    }
}
