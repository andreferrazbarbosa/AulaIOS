import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private weak var digit0Button: UIButton!
    @IBOutlet private weak var digit1Button: UIButton!
    @IBOutlet private weak var digit2Button: UIButton!
    @IBOutlet private weak var digit3Button: UIButton!
    @IBOutlet private weak var digit4Button: UIButton!
    @IBOutlet private weak var digit5Button: UIButton!
    @IBOutlet private weak var digit6Button: UIButton!
    @IBOutlet private weak var digit7Button: UIButton!
    @IBOutlet private weak var digit8Button: UIButton!
    @IBOutlet private weak var digit9Button: UIButton!
    @IBOutlet private weak var cleanButton: UIButton!
    @IBOutlet private weak var sumOpButton: UIButton!
    @IBOutlet private weak var subtractOpButton: UIButton!
    @IBOutlet private weak var timesOpButton: UIButton!
    @IBOutlet private weak var divideOpButton: UIButton!
    @IBOutlet private weak var equalButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    // MARK: - Stored Properties

    private var digitos = [Int]()
    private var op = [String]()

    private let calculator = Calculator()

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTouchEvents()
        resultLabel.text = ""
    }

    // MARK: -

    /// Registra o método que será acionado ao tocar em cada um dos eventos.
    private func registerTouchEvents() {
        let digitButtons = [digit0Button, digit9Button, digit8Button,
                            digit7Button, digit6Button, digit5Button,
                            digit4Button, digit3Button, digit2Button,
                            digit1Button]

        let operationButtons = [sumOpButton, subtractOpButton, timesOpButton, divideOpButton]

        digitButtons.forEach { $0?.addTarget(self, action: #selector(digitTap), for: .touchUpInside) }
        operationButtons.forEach { $0?.addTarget(self, action: #selector(operationTap(sender:)), for: .touchUpInside) }
        cleanButton.addTarget(self, action: #selector(clearTap), for: .touchUpInside)
        equalButton.addTarget(self, action: #selector(makeOperation), for: .touchUpInside)
    }

    /// Esse método é responsável por adicionar um dígito na calculadora
    /// - Parameter sender: Referência do botão que está executando a ação
    @objc func digitTap(sender: UIButton) {
        var sValor = resultLabel.text ?? ""
        switch sender {
        case digit0Button:
            sValor = sValor + "0"
        case digit1Button:
            sValor = sValor + "1"
        case digit2Button:
            sValor = sValor + "2"
        case digit3Button:
            sValor = sValor + "3"
        case digit4Button:
            sValor = sValor + "4"
        case digit5Button:
            sValor = sValor + "5"
        case digit6Button:
            sValor = sValor + "6"
        case digit7Button:
            sValor = sValor + "7"
        case digit8Button:
            sValor = sValor + "8"
        default:
            sValor = sValor + "9"
        }
        
        resultLabel.text = sValor
    }

    /// Método acionado quando o botão AC é tocado.
    @objc func clearTap() {
        resultLabel.text = ""
        op.removeAll()
        digitos.removeAll()
    }

    /// Metódo responsável por escolhe qual a operação será realizada.
    /// - Parameter sender: Referência do botão de operação que foi tocado
    @objc func operationTap(sender: UIButton) {
        if resultLabel.text!.count > 0 {
            
            let valLabel = Int(resultLabel.text ?? "0")
            digitos.append(valLabel!)
            switch sender {
            case sumOpButton:
                op.append("+")
            case subtractOpButton:
                op.append("-")
            case timesOpButton:
                op.append("*")
            default:
                op.append("/")
            }
            
            resultLabel.text = ""
        }
    }
    
    /// Método acionado quando o botão = é tocado.
    @objc func makeOperation() {
        if resultLabel.text!.count > 0 {
            let valLabel = Int(resultLabel.text ?? "0")
            digitos.append(valLabel!)
        }
        
        //Só pode fazer alguma conta, se tiver pelo mnos 2 parcelas
        if (digitos.count > 1) {
            var resultado = digitos[0]
            digitos.remove(at: 0)
            while digitos.count > 0 {
                switch op[0] {
                case "+":
                    resultado = resultado + digitos[0]
                case "-":
                    resultado = resultado - digitos[0]
                case "*":
                    resultado = resultado * digitos[0]
                default:
                    resultado = resultado / digitos[0]
                }
                
                digitos.remove(at: 0)
                op.remove(at: 0)
            }
            
            resultLabel.text = String(resultado)
            digitos.removeAll()
            op.removeAll()
        }
    }
}

