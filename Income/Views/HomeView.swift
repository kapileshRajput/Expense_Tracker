//
//  ContentView.swift
//  Income
//
//  Created by Kapilesh Rajput on 02/05/25.
//

import SwiftUI

struct HomeView: View {
    @State var transactions: [Transaction] = [
        Transaction(
            title: "Sample One",
            amount: 10,
            type: .expense,
            date: Date()
        ),
        Transaction(
            title: "Sample Two",
            amount: 12,
            type: .income,
            date: Date()
        ),
    ]
    
    fileprivate func floatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink(destination: AddTransactionView()) {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .padding(.bottom, 4)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text("2")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                        Text("22")
                            .font(.system(size: 15, weight: .regular))
                    }
                    .foregroundStyle(.white)
                    
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                        Text("22")
                            .font(.system(size: 15, weight: .regular))
                    }
                    .foregroundStyle(.white)
                }
                
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    
                    List {
                        ForEach(transactions) { transaction in
                            TransactionView(transaction: transaction)
                                .listRowSeparator(.hidden)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                floatingButton()
            }
            
            .navigationTitle("Income")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }

                }
            }
        }
    }
}

#Preview {
    HomeView()
}
