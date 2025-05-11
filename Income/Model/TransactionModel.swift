//
//  Transaction.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//


import Foundation

struct Transaction: Identifiable {
    var id: UUID
    let title: String
    let amount: Double
    let type: TransactionType
    let date: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        amount: Double,
        type: TransactionType,
        date: Date
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.type = type
        self.date = date
    }
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
  
    func displayAmount(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? ""
    }
}


extension Transaction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
