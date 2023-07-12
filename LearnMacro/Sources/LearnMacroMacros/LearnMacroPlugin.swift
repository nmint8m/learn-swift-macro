//
//  File.swift
//  
//
//  Created by Tam Nguyen on 12/07/2023.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct LearnMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        ThrowWarningMacro.self,
    ]
}
