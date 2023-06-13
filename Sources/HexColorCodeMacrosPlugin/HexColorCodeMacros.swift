import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
public struct HexColorCodeMacros: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let firstArgument = node.argumentList.first?.expression,
              let secondArgument = Array(node.argumentList)[safe: 1]?.expression,
              node.argumentList.count == 2
        else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "Color(0x\(firstArgument), alpha: \(secondArgument))"
    }
}
