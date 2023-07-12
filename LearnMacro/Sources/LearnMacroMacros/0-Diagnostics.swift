//
//  File.swift
//
//
//  Created by Tam Nguyen on 12/07/2023.
//

import SwiftDiagnostics
import SwiftSyntax

struct DiagnosticDoctor: DiagnosticMessage, FixItMessage {

    var message: String

    var diagnosticID: SwiftDiagnostics.MessageID

    var severity: SwiftDiagnostics.DiagnosticSeverity

    var fixItID: MessageID {
        diagnosticID
    }
}
