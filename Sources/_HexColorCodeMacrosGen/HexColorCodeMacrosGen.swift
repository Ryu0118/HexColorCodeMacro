import ArgumentParser
import _HexColorCodeMacrosGenCore

@main
struct HexColorCodeMacrosGen: AsyncParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "_hccmacrogen"
    )

    @Argument var projectPath: String

    mutating func run() async throws {
        try await HCCAllCodeWriter(projectDirectoryPath: projectPath).generate()
    }
}
