//
//  Calculator.swift
//  Calculator
//
//  Created by Azam Jawad on 2022-06-15.
//

import Foundation

class Calculator: ObservableObject {
    
    // Used to update UI
    @Published var displayValue = "0"
    
    // Stores current operator
    var currentOp: Operator?
    
    // Current number selected
    var currentNumber: Double? = 0
    
    // Previous number selected
    var previousNumber: Double?
    
    // Flag for equal press
    var equaled = false
    
    // How many decimal places have been typed
    var decimalPlace = 0
    
    // Selects appropriate button based on label of button pressed
    func buttonPressed(label: String) {
        
        if label == "CE" {
            displayValue = "0"
            reset()
            
        }
        else if label == "=" {
            equalsClicked()
        }
        else if label == "." {
            decimalClicked()
        }
        else if let value = Double(label) {
            numberPressed(value: value)
        
        }
        else {
            operatorPressed(op: Operator(string: label))
        }
        
    }
    
    func setDisplayValue(number: Double) {
        
        // Dont display a decimal if the number is an integer
        if number == floor(number) {
            displayValue = "\(Int(number))"
        }
        
        // Otherwise, display a decimal
        else {
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(base: 10, exp: decimalPlaces)) / pow(base: 10, exp: decimalPlaces))"
        }
        
        
    }
    
    // Resets state of the calculator
    func reset() {
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
        
    }
    
    //returns true if division by 0 could happen
    func checkForDivision() -> Bool {
        
        if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0) {
            displayValue = "Error"
            reset()
            return true
        }
        else {
            return false
        }
    }
    
    func equalsClicked() {
        
        // Check if we have an operation to perform
        if currentOp != nil {
            
            // Reset the decimal place for current number
            decimalPlace = 0
            
            // Guard for division by 0
            if checkForDivision() {
                return
            }
            
            // Check if we have at least one operand
            if currentNumber != nil || previousNumber != nil {
                
                // Compute total
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                // Update first operand
                if currentNumber ==  nil {
                    currentNumber = previousNumber
                }
                
                // Update second operand
                previousNumber = total
                
                // set the equaled flag
                equaled = true
                
                // Update UI
                setDisplayValue(number: total)
                
                
                
            }
        }
        
    }
    
    func decimalClicked() {
        
        // If equals was pressed, reset current numbers
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        
        // If a "." was typed frst, set current number
        if currentNumber == nil {
            currentNumber = 0
        }
        
        // Set the decimal place
        decimalPlace = 1
        
        // Update the UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    
    func numberPressed(value: Double) {
        
        // If equals was pressed, clear the current nunmbers
        if equaled {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        // If there is no current number, set it to the value
        
        if currentNumber == nil {
            currentNumber = value / pow(base: 10, exp: decimalPlace)
            
        }
        // Otherwise, add value to the current number
        else {
            // If no decimal was typed, add value as last digit of number
            if decimalPlace == 0 {
                currentNumber = currentNumber! * 10 + value
            }
            // Otherwise, add value as last decimal of the number
            else {
                currentNumber = currentNumber! + value / pow(base: 10, exp: decimalPlace)
                decimalPlace += 1
            }
        }
        
        // Update the UI
        setDisplayValue(number: currentNumber!)
        
    }
    
    func operatorPressed(op: Operator) {
        
        // Reset the decimal
        decimalPlace = 0
        
        // If equals was pressed, reset the current number
        if equaled {
            currentNumber = nil
            equaled = false
        }
        
        // If we have two operands, compute them
        if currentNumber != nil && previousNumber != nil {
            if checkForDivision() {
                return
            }
            let total = currentOp!.op(previousNumber!, currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            // Update the UI
            setDisplayValue(number: total)
            
        }
        // If only one number was given, move it into the second operand
        else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
                
        }
        
        currentOp = op
    }
    
}

func pow (base: Int, exp: Int) -> Double {
    return pow(Double(base), Double(exp))
    
    
}
