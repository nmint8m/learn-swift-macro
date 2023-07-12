import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

enum ThrowWarningMacroError: CustomStringConvertible, Error {
    case agrumentRequired
    case stringAgrumentRequired

    var description: String {
        switch self {
        case .agrumentRequired:
            return "The macro \(ThrowWarningMacro.self) requires input argument"
        case .stringAgrumentRequired:
            return "The macro \(ThrowWarningMacro.self) requires static String literal"
        }
    }
}

public struct ThrowWarningMacro: ExpressionMacro {

    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.argumentList.first else {
            throw ThrowWarningMacroError.agrumentRequired
        }

        guard
            let expression = argument.expression.as(StringLiteralExprSyntax.self),
            expression.segments.count == 1,
            let segment = expression.segments.first,
            case .stringSegment(let message) = segment
        else {
            throw ThrowWarningMacroError.stringAgrumentRequired
        }

        context.diagnose(
            Diagnostic(
                node: Syntax(node),
                message: DiagnosticDoctor(
                    message: message.content.description,
                    diagnosticID: MessageID(domain: "ThrowWarningMacro", id: ""),
                    severity: .warning
                )
            )
        )

        return "()"
    }
}

