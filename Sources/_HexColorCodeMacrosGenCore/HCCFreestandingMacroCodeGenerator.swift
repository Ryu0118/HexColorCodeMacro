enum HCCFreestandingMacroCodeGenerator {
    static func generate(_ macroName: String) -> String {
        let underlineIfNeeded = Int("\(macroName.first!)") != nil ? "_" : ""
        return """
        @freestanding(expression) public macro \(underlineIfNeeded)\(macroName)(alpha: Double) -> Color = #hexColorCode("\(macroName)", alpha: alpha)
        @freestanding(expression) public macro \(underlineIfNeeded)\(macroName)() -> Color = #hexColorCode("\(macroName)", alpha: 1)
        """
    }
}

enum HCCAllFreestandingMacrosGenerator {
    static func generateMacros(_ macroNames: [String]) -> [String] {
        let imports = "import SwiftUI\n"
        let hexColorCode = "@freestanding(expression) private macro hexColorCode(_ hex: String, alpha: Double) -> Color = #externalMacro(module: \"HexColorCodeMacrosPlugin\", type: \"HexColorCodeMacros\")\n"

        return macroNames
            .map { HCCFreestandingMacroCodeGenerator.generate($0) }
            .chunked(into: 50_000)
            .map { imports + hexColorCode + $0.joined(separator: "\n") }
    }
}

extension Array {
    func chunked(into chunkSize: Int) -> [[Element]] {
        var chunks: [[Element]] = []

        for i in stride(from: 0, to: self.count, by: chunkSize) {
            let endIndex = Swift.min(i + chunkSize, self.count)
            let chunk = Array(self[i..<endIndex])
            chunks.append(chunk)
        }

        return chunks
    }
}
