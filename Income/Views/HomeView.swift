//
//  ContentView.swift
//  Income
//
//  Created by Kapilesh Rajput on 02/05/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    
                    List {
                        ForEach(viewModel.displayTransactions) { transaction in
                            Button(action: {
                                viewModel.transactionToEdit = transaction
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .listRowSeparator(.hidden)
                                    .foregroundStyle(.black)
                            })
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                
                floatingButton()
            }
            
            .navigationTitle("Income")
            .navigationDestination(
                item: $viewModel.transactionToEdit,
                destination: { transaction in
                    AddUpdateTransactionView(
                        transactionToEdit: transaction,
                        transactions: $viewModel.transactions
                    )
                })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showSettingsView = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
            .sheet(isPresented: $viewModel.showSettingsView) {
                SettingsView()
            }
        }
    }
    
    fileprivate func floatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink(
                destination: AddUpdateTransactionView(transactions: $viewModel.transactions)
            ) {
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
                        Text(viewModel.total)
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
                        Text(viewModel.expenses)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .foregroundStyle(.white)
                    
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                        Text(viewModel.income)
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
}

#Preview {
    HomeView()
}
