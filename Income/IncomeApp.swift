//
//  IncomeApp.swift
//  Income
//
//  Created by Kapilesh Rajput on 02/05/25.
//

import SwiftUI

@main
struct IncomeApp: App {
    let dataManger: DataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataManger.container.viewContext)
        }
    }
}
