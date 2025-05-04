//
//  AddTransactionView.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//
import SwiftUI

struct AddUpdateTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: AddUpdateTransactionViewModel
    
    init(
        transactionToEdit: Transaction? = nil,
        transactions: Binding<[Transaction]>
    ) {
        _viewModel = StateObject(
            wrappedValue: AddUpdateTransactionViewModel(
                transactionToEdit: transactionToEdit,
                transactions: transactions
            )
        )
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $viewModel.amount, formatter: viewModel.numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Divider()
                .padding(.horizontal, 30)
            
            Picker(
                "Choose Type",
                selection: $viewModel.selectedTransactionType) {
                    ForEach(TransactionType.allCases) { transactionType in
                        Text(transactionType.title)
                            .tag(transactionType) // adding tag so, SwiftUI can map the "selectedTransactionType" which is of type "TransactionType" correctly.
                    }
                }
            
            TextField("Title", text: $viewModel.transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button {
                guard viewModel.transactionTitle.count >= 2 else {
                    viewModel.alertTitle = "Invalid Title"
                    viewModel.alertMessage = "Title must be 2 or more characters long."
                    viewModel.showAlert = true
                    return
                }
                
                let transaction = Transaction(
                    title: viewModel.transactionTitle,
                    amount: viewModel.amount,
                    type: viewModel.selectedTransactionType,
                    date: Date()
                )
                
                
                if let transactionToEdit = viewModel.transactionToEdit {
                    // Update Transaction
                    guard let indexOfTransaction = viewModel.transactions.wrappedValue.firstIndex(of: transactionToEdit) else {
                        viewModel.alertTitle = "Something went wrong"
                        viewModel.alertMessage = "Cannot update this transaction right now."
                        viewModel.showAlert = true
                        return
                    }
                    viewModel.transactions
                        .wrappedValue[indexOfTransaction] = transaction
                    
                    print("Came in here!!, index: \(indexOfTransaction)")
                } else {
                    // Create Transaction
                    viewModel.transactions.wrappedValue.append(transaction)
                    print("Came in here 1!!")
                }
                
                dismiss()
            } label: {
                Text(viewModel.transactionToEdit == nil ? "Create" : "Update")
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
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button {
                // Doing nothing results in dissmissing the alert. (That is the default behaviour"
            } label: {
                Text("OK")
            }
            
        } message: {
            Text(viewModel.alertMessage)
        }
        .onAppear {
            if let transaction = viewModel.transactionToEdit {
                viewModel.amount = transaction.amount
                viewModel.selectedTransactionType = transaction.type
                viewModel.transactionTitle = transaction.title
            }
        }
    }
}

#Preview {
    AddUpdateTransactionView(transactions: .constant([]))
}
