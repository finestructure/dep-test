import Dependencies
import DependenciesMacros


enum CallSite {
    func f() async throws {
        @Dependency(\.github) var github
        _ = try await github.fetchMetadata(owner: "foo", repository: "bar")
    }
}


@DependencyClient
struct GithubClient {
    var fetchLicense: @Sendable (_ owner: String, _ repository: String) async -> Github.License?
    var fetchMetadata: @Sendable (_ owner: String, _ repository: String) async throws(Github.Error) -> Github.Metadata = { _, _ in XCTFail("fetchMetadata"); return .init() }
}


extension GithubClient: DependencyKey {
    static var liveValue: Self {
        .init(
            fetchLicense: { owner, repo in .init() },
            fetchMetadata: { _, _ in .init() }
        )
    }
}


enum Github {
    struct Metadata { }
    struct License { }
    enum Error: Swift.Error { }
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
