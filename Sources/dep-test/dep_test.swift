import Dependencies
import DependenciesMacros


@DependencyClient
struct GithubClient2 {
    var fetchLicense: @Sendable (_ owner: String, _ repository: String) async -> Github2.License?
    var fetchMetadata: @Sendable (_ owner: String, _ repository: String) async throws(Github2.Error) -> Github2.Metadata = { _, _ in XCTFail("fetchMetadata"); return .init() }
}


enum Github2 {
    struct Metadata { }
    struct License { }
    enum Error: Swift.Error { }
}
