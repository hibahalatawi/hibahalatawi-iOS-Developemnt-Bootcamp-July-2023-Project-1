//
//  ListRowView.swift
//  ProjectHibah
//
//  Created by Hibah Abdullah Alatawi on 17/01/1445 AH.
//

import SwiftUI

struct ListRowView: View {
    
    let item : TaskModel
    
    var body: some View {
        HStack {
            Image (systemName: item.status == .done ? "checkmark.circle" : "circle" )
                .foregroundColor(item.status == .done ? .green : .red)
            Text(item.title)
            Spacer ()
        }
        .font(.title2)
        .padding(.vertical,8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListRowView(item: TaskModel.sample)
        }
    }
}
