//
//  Converter.swift
//  converter
//
//  Created by paradiseduo on 2021/11/26.
//

import Foundation

public struct Converter {
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        if CommandLine.argc < 2 {
            consoleIO.printUsage()
            return
        }
        
        if CommandLine.arguments.contains(where: { (s) -> Bool in
            return s=="-h" || s=="--help"
        }) {
            consoleIO.printUsage()
        }
        
        let sourceUrl = CommandLine.arguments[1]
        if !sourceUrl.hasSuffix(".ipa") {
            consoleIO.writeMessage("must input an ipa file", to: .error)
        }
        
        let targetUrl = "."
        let temFile = targetUrl + "/tmp"
        consoleIO.writeMessage("Start converter \(sourceUrl)")
        self.run("unzip -o \(sourceUrl) -d \(temFile)") { t2, o2 in
            if t2 == 0 {
                let payload = temFile+"/Payload"
                let wrapper = temFile+"/Wrapper"
                do {
                    let fileList = try FileManager.default.contentsOfDirectory(atPath: payload)
                    var appPath = payload
                    var machOPath = payload
                    var appFileName = ""
                    for item in fileList {
                        if item.hasSuffix(".app") {
                            appFileName = item
                            appPath += "/\(appFileName)"
                            machOPath = appPath+"/\(appFileName.components(separatedBy: ".")[0])"
                            break
                        }
                    }
                    self.run("chmod 0777 \(machOPath)") { t3, o3 in
                        if t3 == 0 {
                            self.run("mv \(payload) \(wrapper)") { t4, o4 in
                                if t4 == 0 {
                                    self.run("cd \(temFile) && ln -s Wrapper/\(appFileName) WrappedBundle") { t5, o5 in
                                        if t5 == 0 {
                                            self.run("mv \(temFile) /Applications/\(appFileName)") { t6, o6 in
                                                if t6 == 0 {
                                                    consoleIO.writeMessage("Finish converter, you can found it in Launchpad(启动台)")
                                                    exit(0)
                                                } else {
                                                    consoleIO.writeMessage("\(t6) \(o6)", to: .error)
                                                }
                                            }
                                        } else {
                                            consoleIO.writeMessage("\(t5) \(o5)", to: .error)
                                        }
                                    }
                                } else {
                                    consoleIO.writeMessage("\(t4) \(o4)", to: .error)
                                }
                            }
                        } else {
                            consoleIO.writeMessage("\(t3) \(o3)", to: .error)
                        }
                    }
                } catch let e {
                    consoleIO.writeMessage("list file error \(e)", to: .error)
                }
            } else {
                consoleIO.writeMessage("\(t2) \(o2)", to: .error)
            }
        }
    }

    public init() {
        
    }
    
    func run(_ command: String, handle:(Int32, String)->()) {
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = ["-c", command]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        
        task.launch()
        
        let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8)
        
        task.waitUntilExit()
        handle(task.terminationStatus, output ?? "")
    }
}
