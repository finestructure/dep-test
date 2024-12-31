import Dependencies
import DependenciesMacros


@DependencyClient
struct GithubClient2 {
    var fetchMetadata: @Sendable (_ owner: String, _ repository: String) async throws(Github2.Error) -> Github2.Metadata = { _, _ in XCTFail("fetchMetadata"); return .init() }
}


extension GithubClient2: DependencyKey {
    static var liveValue: Self {
        .init(
            fetchMetadata: { _, _ in .init() }
        )
    }
}


enum Github2 {
    struct Metadata { }
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
