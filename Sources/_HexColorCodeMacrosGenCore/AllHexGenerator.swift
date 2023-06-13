import Foundation

enum AllHexGenerator {
    static func generate() -> [String] {
        var results = [String]()

        for i in 0...0xFFFFFF {
            let red = (i >> 16) & 0xFF
            let green = (i >> 8) & 0xFF
            let blue = i & 0xFF
            let hexString = String(format: "%02X%02X%02X", red, green, blue)

            results.append(hexString)
        }

        return results
    }
}
