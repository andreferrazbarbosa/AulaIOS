enum bankOperation{
    case withdrawl	(value: Double)
    case deposit (from: String, value: Double)
}

enum BankAccountError: Error {
    case insuficientFunds(currentBallance : Double)
}

protocol BankAccountProtocol {
    init(number: String, holder :String)

    var balance: Double {get}
    var statement : [bankOperation] {get}

    func withdrawl (value : Double) throws
    func deposit (value : Double, from account : String)
    func formatedStatement() -> String
}

class MyBank : BankAccountProtocol {
    private let number: String
    private let holder: String
    private(set) var balance: Double
    private(set) var statement: [bankOperation]

    required init(number: String, holder: String) {
        self.number = number
        self.holder = holder
        self.balance = 0.0
        self.statement = []
    }

    func withdrawl(value: Double) throws {
        if self.balance >= value{
            self.balance = self.balance - value

            self.statement.append(.withdrawl(value: value))
        }
        else{
            throw BankAccountError.insuficientFunds(currentBallance: self.balance)
        }
    }

    func deposit(value: Double, from account: String) {
        self.balance = self.balance + value

        self.statement.append(.deposit(from: account, value: value))
    }

    func formatedStatement() -> String {
        var stringRetorno = "OPR    VALUE    FROM\n"
        for stat in self.statement{
            switch 	stat {
            case let .deposit(from, value):
                stringRetorno += "DEP    " + String(value) + "    " + from + "\n"
            case let .withdrawl(value):
                stringRetorno += "WTH    " + String(value) + "\n"
            }
        }

        return stringRetorno
    }
}


var bankAndre = MyBank(number: "1234", holder: "ABCDE")


bankAndre.deposit(value: 100, from: "5648")
try bankAndre.withdrawl(value: 10)
bankAndre.deposit(value: 180, from: "7659")
try bankAndre.withdrawl(value: 150)
try bankAndre.withdrawl(value: 12)

print(bankAndre.formatedStatement())
