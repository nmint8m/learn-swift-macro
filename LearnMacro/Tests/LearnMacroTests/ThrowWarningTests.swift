//
//  File.swift
//
//
//  Created by Tam Nguyen on 12/07/2023.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import LearnMacroMacros

final class ThrowWarningTests: XCTestCase {

    let testMacros: [String: Macro.Type] = [
        "throwWarning": ThrowWarningMacro.self,
    ]

    func testMacro() {
        assertMacroExpansion(
            """
            #throwWarning("This is the throw warning message")
            """,
            expandedSource: """
            ()
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "This is the throw warning message",
                    line: 1,
                    column: 1,
                    severity: .warning
                )
            ],
            macros: testMacros
        )
    }

    /* NOTE: No need to test the following cases:
     - With no arguments. Eg: #throwWarning()
     - With wrong data type. Eg: #throwWarning(1)
     Because Swift macro has its own type checking
    */

    func testMacroWithWrongInput() {
        assertMacroExpansion(
            """
            #throwWarning("This is the throw warning message" + "!")
            """,
            expandedSource: """
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "The macro ThrowWarningMacro requires static String literal",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: testMacros
        )
    }
}

