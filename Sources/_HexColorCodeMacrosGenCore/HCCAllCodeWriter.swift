import Foundation

public struct HCCAllCodeWriter {
    private let projectDirectoryPath: String

    // relative path
    private let freestandingMacroGeneratePath: String = "Sources/HexColorCodeMacros/Macros_%d.swift"

    public init(projectDirectoryPath: String) {
        self.projectDirectoryPath = projectDirectoryPath
    }

    public func generate() async throws {
        let hexes = AllHexGenerator.generate()

        try HCCAllFreestandingMacrosGenerator
            .generateMacros(hexes)
            .enumerated()
            .forEach {
                let freestandingMacroGenerateURL = URL(fileURLWithPath: projectDirectoryPath)
                    .appendingPathComponent(
                        String(format: freestandingMacroGeneratePath, $0)
                    )

                try $1.write(
                    to: freestandingMacroGenerateURL,
                    atomically: true,
                    encoding: .utf8
                )
            }
    }
}
