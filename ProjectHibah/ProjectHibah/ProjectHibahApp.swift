//
//  ProjectHibahApp.swift
//  ProjectHibah
//
//  Created by Hibah Abdullah Alatawi on 17/01/1445 AH.
//

import SwiftUI

@main
struct ProjectHibahApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}

