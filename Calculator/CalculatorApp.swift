//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Azam Jawad on 2022-06-15.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorHome()
                .environmentObject(Calculator())
        }
    }
}
