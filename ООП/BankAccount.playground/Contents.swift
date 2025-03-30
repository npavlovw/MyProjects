import UIKit

enum TransactionType {
    case deposit
    case withdrawal
}

struct Transaction {
    var amount: Double
    var type: TransactionType
    var date: String
}

class BankAccount {
    var accountNumber: Int
    var balance: Double
    var transactions: [Transaction] = []
    
    init(accountNumber: Int, balance: Double = 0) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func deposit(_ amount: Double) {
        guard amount > 0 else { return }
        balance += amount
        transactions.append(Transaction(amount: amount, type: .deposit, date: Date().description))
        print("Пополнение: \(amount)₽")
    }
    
    func withdraw(_ amount: Double) {
        guard amount > 0, balance >= amount else {
            print("Недостаточно средств")
                  return
                  }
        balance -= amount
        transactions.append(Transaction(amount: amount, type: .withdrawal, date: Date().description))
        print("Снятие \(amount)")
    }
    
    func printStatement() {
        print("История операций:")
        for statement in transactions {
            print("\(statement.type == .deposit ? "Пополнение" : "Снятие"): \(statement.amount)₽ \(statement.date)")
        }
    }
}

class Bank {
    var accounts: [BankAccount] = []
    
    func createAccount(withNumber number: Int) -> BankAccount {
        let newAccount = BankAccount(accountNumber: number)
        accounts.append(newAccount)
        print("Создан аккаунт с номером \(number)")
        return newAccount
    }
    
    func findAccount(byNumber: Int) {
        let account = accounts.first { $0.accountNumber == byNumber }
        if let account {
            print("Аккаунт с указанным номером существует")
        } else {
            print("Аккаунта с указанным номером не существует")
        }
    }
}

let bank = Bank()
let account1 = bank.createAccount(withNumber: 12345)
let account2 = bank.createAccount(withNumber: 67890)

account1.deposit(124.5)
account1.deposit(200)
account1.withdraw(250)
account1.printStatement()

bank.findAccount(byNumber: 12345)
bank.findAccount(byNumber: 67890)
bank.findAccount(byNumber: 11111)
