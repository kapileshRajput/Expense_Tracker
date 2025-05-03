//
//  AddTransactionView.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//
import SwiftUI

struct AddTransactionView: View {
    @State private var amount: Double = 0.0
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var transactionTitle: String = ""
    
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
            
            TextField("Transaction Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button {
                
            } label: {
                Text("Create")
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
    }
}

#Preview {
    AddTransactionView()
}
