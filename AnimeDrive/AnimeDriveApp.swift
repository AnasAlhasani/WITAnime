import AnimeDriveKit
import AVKit
import SwiftUI

enum Route: Hashable {
    case episode(Episode)
    case video(VideoLink)
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: some Hashable) {
        path.append(route)
    }

    func navigateBack() {
        path.removeLast()
    }

    func navigateToRoot() {
        path.removeLast(path.count)
    }
}

@main
struct AnimeDriveApp: App {
    @StateObject 
    private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                HomeScreen(latestEpisodesUseCase: .resolve())
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case let .episode(episode):
                            EpisodeScreen(episode: episode, videoLinksUseCase: .resolve())
                        case let .video(link):
                            VideoPlayer(player: .init(url: link.url))
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
