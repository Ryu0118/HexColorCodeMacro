#if canImport(SwiftCompilerPlugin)
import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct HexColorCodeMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HexColorCodeMacros.self
    ]
}
#endif
