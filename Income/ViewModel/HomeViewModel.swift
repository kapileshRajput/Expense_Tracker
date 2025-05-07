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
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}
