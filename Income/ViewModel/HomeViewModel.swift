//
//  HomeViewModel.swift
//  Income
//
//  Created by Kapilesh Rajput on 04/05/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var transactionToEdit: Transaction?
    @Published var showSettingsView: Bool = false
    
    @AppStorage("orderDecending") var orderDecending: Bool = false
    @AppStorage("currency") var currency: Currency = .ind_rupee
    @AppStorage("filterMinimum") var filterMinimum: Double = 0.0
    
    var displayTransactions: [Transaction] {
        let sortedTransactions = orderDecending ?  transactions.sorted(by: { $0.date < $1.date
        }) : transactions.sorted(by: { $0.date > $1.date })
        let filteredTransactions = sortedTransactions.filter({ $0.amount > filterMinimum })
        return filteredTransactions
    }
    
    var expenses: String {
        let sumExpenses: Double = transactions.filter({ $0.type == .expense }).reduce(
            0,
            {$0 + $1.amount
            })
        
        return format(amount: sumExpenses)
    }
    
    var income: String {
        let sumIncome: Double = transactions.filter({ $0.type == .income }).reduce(0, {$0 + $1.amount})
        
        return format(amount: sumIncome)
    }
    
    var total: String {
        let sumExpenses: Double = transactions.filter({ $0.type == .expense}).reduce(0, {$0 + $1.amount})
        let sumIncome: Double = transactions.filter({ $0.type == .income }).reduce(0, {$0 + $1.amount})
        let total: Double = sumIncome - sumExpenses
        
        return format(amount: total)
    }
    
    func format(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let transaction = transactions[index]
            CoreDataManager.shared.delete(transaction: transaction)
        }
        fetchTransactions()
    }
    
    func fetchTransactions() {
        transactions = CoreDataManager.shared.fetch().map({
             Transaction(
                id: $0.wrappedId,
                title: $0.wrappedTitle,
                amount: $0.amount,
                type: $0.wrappedTransactionType,
                date: $0.wrappedDate
            )
        })
    }
}
