import Dependencies
import DependenciesMacros


enum Github {
    struct Metadata { }
    enum Error: Swift.Error { }
}

@DependencyClient
struct GithubClient {
    var fetchMetadata: @Sendable (_ owner: String, _ repository: String) async throws(Github.Error) -> Github.Metadata
}


extension GithubClient: DependencyKey {
    static var liveValue: Self {
        .init(
            fetchMetadata: { owner, repo throws(Github.Error) in try await Github.fetchMetadata(owner: owner, repository: repo) }
        )
    }
}


extension GithubClient: TestDependencyKey {
    static var testValue: Self { Self() }
}


extension DependencyValues {
    var github: GithubClient {
        get { self[GithubClient.self] }
        set { self[GithubClient.self] = newValue }
    }
}
