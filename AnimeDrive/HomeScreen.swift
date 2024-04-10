import AnimeDriveKit
import AVKit
import SwiftUI

// MARK: - HomeScreen

struct HomeScreen {
    enum ViewState {
        case idle
        case loading
        case success([Episode])
        case failure(Error)
    }
    
    @EnvironmentObject private var router: Router
    @State private var state: ViewState = .loading
    
    private let latestEpisodesUseCase: LatestEpisodesUseCase
    
    init(latestEpisodesUseCase: LatestEpisodesUseCase) {
        self.latestEpisodesUseCase = latestEpisodesUseCase
    }
    
    func loadData() async {
        do {
            state = .loading
            let episodes = try await latestEpisodesUseCase()
            state = .success(episodes)
        } catch {
            state = .failure(error)
        }
    }
    
    func showEpisode(_ episode: Episode) {
        router.navigate(to: Route.episode(episode))
    }
}

extension HomeScreen: View {
    var body: some View {
        contentView
            .task {
                await loadData()
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case let .success(episodes):
            latestEpisodesList(episodes: episodes)
        case let .failure(error):
            Text("Error: \(error.localizedDescription)")
        }
    }
    
    @ViewBuilder
    private func latestEpisodesList(episodes: [Episode]) -> some View {
        List(episodes) { episode in
            Button {
                showEpisode(episode)
            } label: {
                HStack {
                    AsyncImage(url: episode.imageURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(episode.imageText)
                            .font(.subheadline)
                        Text(episode.name)
                            .font(.headline)
                    }
                    .padding(.leading, 8)
                }
            }
        }
        .listStyle(.plain)
        .toolbarRole(.editor)
        .navigationTitle("Latest Episodes")
    }
}

// MARK: - EpisodeScreen

struct EpisodeScreen {
    enum ViewState {
        case idle
        case loading
        case success([VideoLink])
        case failure(Error)
    }
    
    @EnvironmentObject private var router: Router
    @State private var state: ViewState = .loading
    
    private let episode: Episode
    private let videoLinksUseCase: VideoLinksUseCase
    
    init(episode: Episode, videoLinksUseCase: VideoLinksUseCase) {
        self.episode = episode
        self.videoLinksUseCase = videoLinksUseCase
    }
    
    func loadLinks() async {
        do {
            state = .loading
            let links = try await videoLinksUseCase(input: episode.id)
            state = .success(links)
        } catch {
            state = .failure(error)
        }
    }
    
    func showVideo(with link: VideoLink) {
        router.navigate(to: Route.video(link))
    }
}

extension EpisodeScreen: View {
    var body: some View {
        contentView
            .task {
                await loadLinks()
            }
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch state {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case let .success(links):
            videosListView(links: links)
        case let .failure(error):
            Text("Failed to load video links: \(error.localizedDescription)")
        }
    }
    
    @ViewBuilder
    private func videosListView(links: [VideoLink]) -> some View {
        List(links) { link in
            Button {
                showVideo(with: link)
            } label: {
                VStack(alignment: .leading) {
                    Text(link.server)
                        .font(.headline)
                    
                    Text(link.url.absoluteString)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .toolbarRole(.editor)
        .navigationTitle("Servers")
    }
}
