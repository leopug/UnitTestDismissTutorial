//
//  LoggerManager.swift
//  UnitTestDismissTutorial
//
//  Created by Leonardo on 22/12/2021.
//

import Foundation

protocol LoggingManager {
    func log(text: String)
}

struct LogManager: LoggingManager {
    func log(text: String) {
        print(text)
    }
}
