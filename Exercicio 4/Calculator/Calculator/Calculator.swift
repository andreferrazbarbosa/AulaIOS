import Foundation

struct Calculator {
    enum Operation {
        case sum
        case times
        case divide
        case subtract
    }

    /// Realiza uma operação matemática.
    /// - Parameter operation: Enum com a operação a ser realizada.
    /// - Parameter firstValue: Primeiro valor.
    /// - Parameter secondValue: Segundo valor.
    /// - Returns: Resultado do calculo.
    func perform(operation: Calculator.Operation,
                 firstValue: Int,
                 secondValue: Int) -> Int {
        return 0
    }
}
