//
//  ConsleIO.swift
//  converter
//
//  Created by paradiseduo on 2021/11/26.
//

import Foundation

let version = "1.0"

enum OutputType {
  case error
  case standard
}

struct ConsoleIO {
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
            case .standard:
                print("\(message)")
            case .error:
                fputs("Error: \(message)\n", stderr)
                exit(-10)
        }
    }
    
    func printUsage() {
        writeMessage("""
        Version \(version)
        
        converter is a tool to conver iOS application to macOS application and run with M1.
        
        Examples:
            mac:
                converter Test.ipa
        
        USAGE: converter ipa_path
        
        ARGUMENTS:
          <ipa_path>        The ipa file path.
        
        OPTIONS:
          -h, --help              Show help information.
        """)
        exit(10)
    }
}
