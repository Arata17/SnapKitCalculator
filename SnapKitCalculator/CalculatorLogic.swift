import Foundation

struct CalculatorLogic{
    
    private var number: Double?
    
    private var intermediateCalc: ( n1: Double, operation: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    
    mutating func calculate(_ symbol: String) -> Double? {
        
        if let n = number{
            switch symbol{
            case "+/-":
                return n * -1
            case"AC":
                return 0
            case"%":
                return n * 0.01
            case "=":
                return performCalculation(n2: n)
            default:
                intermediateCalc = (n1: n, operation: symbol)
            }
        }
        
        return nil
    }
    
    private func performCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalc?.n1, let operation = intermediateCalc?.operation{
            
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "×":
                return n1 * n2
            case "÷":
                return n1 / n2
            default:
                fatalError("No such operation")
            }
        }
        return nil
    }
}
