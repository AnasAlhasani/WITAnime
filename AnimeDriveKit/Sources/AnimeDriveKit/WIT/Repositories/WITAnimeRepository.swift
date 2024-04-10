import Foundation

public extension AnimeRepository {
    static func resolve(apiClient: APIClient = .resolve()) -> Self {
        .init(
            search: { query in
                try await apiClient
                    .data(URL(string: "https://witanime.art?search_param=animes&s=\(query)").unwrap())
                    .decode(using: .animeDecoder)
            },
            info: { animeId in
                try await apiClient
                    .data(URL(string: "https://witanime.art/anime/\(animeId)").unwrap())
                    .decode(using: .infoDecoder)
            },
            episodes: { animeId in
                try await apiClient
                    .data(URL(string: "https://witanime.art/anime/\(animeId)").unwrap())
                    .decode(using: .episodesDecoder(ofType: .episodes))
            },
            latestEpisodes: {
                try await apiClient
                    .data(URL(string: "https://witanime.art/episode").unwrap())
                    .decode(using: .episodesDecoder(ofType: .latest))
            },
            videoLinks: { episodeId in
                try await apiClient
                    .data(URL(string: "https://witanime.art/episode/\(episodeId)").unwrap())
                    .decode(using: .videoLinksDecoder)
            }
        )
    }
}
