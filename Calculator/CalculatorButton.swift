//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Azam Jawad on 2022-06-15.
//

import SwiftUI

struct CalculatorButton: View {
    
    @EnvironmentObject var Calculator: Calculator
    var label: String
    var color: Color
    
    var body: some View {
        
        Button(action: {
            
            // Inform model of button press
            Calculator.buttonPressed(label: label)
            
        }, label: {
            
            
            ZStack {
                Circle()
                    .fill(color)
                Text(label)
                    .font(.title)
            }
            
        })
        // We want white color text
        .accentColor(.white)
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButton(label: "1", color: .gray)
            .previewLayout(.fixed(width: 100, height: 100))
            .environmentObject(Calculator())
    }
}
