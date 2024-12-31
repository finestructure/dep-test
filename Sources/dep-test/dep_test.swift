import Dependencies
import DependenciesMacros


enum CallSite {
    func f() async throws {
        @Dependency(\.github2) var github
        _ = try await github.fetchMetadata(owner: "foo", repository: "bar")
    }
}


@DependencyClient
struct GithubClient2 {
    var fetchLicense: @Sendable (_ owner: String, _ repository: String) async -> Github2.License?
    var fetchMetadata: @Sendable (_ owner: String, _ repository: String) async throws(Github2.Error) -> Github2.Metadata = { _, _ in XCTFail("fetchMetadata"); return .init() }
}


extension GithubClient2: DependencyKey {
    static var liveValue: Self {
        .init(
            fetchLicense: { owner, repo in .init() },
            fetchMetadata: { _, _ in .init() }
        )
    }
}


enum Github2 {
    struct Metadata { }
    struct License { }
    enum Error: Swift.Error { }
}


extension GithubClient2: TestDependencyKey {
    static var testValue: Self { Self() }
}


extension DependencyValues {
    var github2: GithubClient2 {
        get { self[GithubClient2.self] }
        set { self[GithubClient2.self] = newValue }
    }
}
