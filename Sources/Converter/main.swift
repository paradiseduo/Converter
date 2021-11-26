//
//  main.swift
//  converter
//
//  Created by paradiseduo on 2021/11/26.
//

import Foundation

Converter().staticMode()

let runLoop = RunLoop.current
let distantFuture = Date.distantFuture
while true && runLoop.run(mode: RunLoop.Mode.default, before: distantFuture) {
    
}
