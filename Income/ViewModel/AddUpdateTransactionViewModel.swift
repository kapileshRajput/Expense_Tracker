//
//  AddUpdateTransactionViewModel.swift
//  Income
//
//  Created by Kapilesh Rajput on 04/05/25.
//

import SwiftUI

class AddUpdateTransactionViewModel: ObservableObject {
    var transactionToEdit: Transaction?
    var transactions: Binding<[Transaction]>
    
    init(transactionToEdit: Transaction? = nil, transactions: Binding<[Transaction]>) {
        self.transactionToEdit = transactionToEdit
        self.transactions = transactions
    }
    
    @Published var amount: Double = 0.0
    @Published var selectedTransactionType: TransactionType = .expense
    @Published var transactionTitle: String = ""
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    @AppStorage("currency") var currency: Currency = .ind_rupee
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
}
