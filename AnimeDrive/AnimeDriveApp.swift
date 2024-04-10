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
    private let repository = AnimeRepository.live()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                HomeScreen(repository: repository)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case let .episode(episode):
                            EpisodeScreen(episode: episode, repository: repository)
                        case let .video(link):
                            VideoPlayer(player: .init(url: link.url))
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
