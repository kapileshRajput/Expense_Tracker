//
//  AddTransactionView.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//
import SwiftUI

struct AddTransactionView: View {
    
    var transactionToEdit: Transaction?
    @Binding var transactions: [Transaction]
    
    @Environment(\.dismiss) var dismiss
    
    @State private var amount: Double = 0.0
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var transactionTitle: String = ""
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Divider()
                .padding(.horizontal, 30)
            
            Picker(
                "Choose Type",
                selection: $selectedTransactionType) {
                    ForEach(TransactionType.allCases) { transactionType in
                        Text(transactionType.title)
                            .tag(transactionType) // adding tag so, SwiftUI can map the "selectedTransactionType" which is of type "TransactionType" correctly.
                    }
                }
            
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more characters long."
                    showAlert = true
                    return
                }
                
                let transaction = Transaction(
                    title: self.transactionTitle,
                    amount: self.amount,
                    type: self.selectedTransactionType,
                    date: Date()
                )
                
                
                if let transactionToEdit = transactionToEdit {
                    // Update Transaction
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                } else {
                    // Create Transaction
                    transactions.append(transaction)
                }
                
                dismiss()
            } label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top)
            .padding(.horizontal, 30)
            
            
            Spacer()
        }
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                // Doing nothing results in dissmissing the alert. (That is the default behaviour"
            } label: {
                Text("OK")
            }
            
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            if let transaction = transactionToEdit {
                self.amount = transaction.amount
                self.selectedTransactionType = transaction.type
                self.transactionTitle = transaction.title
            }
        }
    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
