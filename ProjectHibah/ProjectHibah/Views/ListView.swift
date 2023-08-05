//
//  ContentView.swift
//  ProjectHibah
//
//  Created by Hibah Abdullah Alatawi on 17/01/1445 AH.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var showAddView: Bool = false
    
    
    var body: some View {
        List {
            ForEach(listViewModel.listItems) { item in
                
                NavigationLink(destination: DetailsView(item: item)) {
                    ListRowView(item: item)
                }
            }
            .onDelete(perform: listViewModel.deleteItem)
        }
        .listStyle(.plain)
        .searchable(text: $listViewModel.searchText)
        .onChange(of: listViewModel.searchText, perform: listViewModel.filterItems)
        
        .navigationTitle("Todo List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Picker("Status", selection: $listViewModel.selectedStatus) {
                        Text("Backlog").tag(TaskStatus.backlog as TaskStatus?)
                        Text("Todo").tag(TaskStatus.todo as TaskStatus?)
                        Text("In-Progress").tag(TaskStatus.inProgress as TaskStatus?)
                        Text("Done").tag(TaskStatus.done as TaskStatus?)
                    }
                    .onChange(of: listViewModel.selectedStatus, perform: listViewModel.filterItems)
                    
                    Divider()
                    
                    Button(role: .destructive) {
                        listViewModel.selectedStatus = nil
                    } label: {
                        Label("Clear", systemImage: "trash")
                    }
                    .disabled(listViewModel.selectedStatus == nil)
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showAddView) {
            AddView()
        }
        .scrollContentBackground(.hidden)
            .background {
                Image("background")
                
            }
    }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ListView()
            
        }
        .environmentObject(ListViewModel())
    }
    
}
