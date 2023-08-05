//
//  AddView.swift
//  ProjectHibah
//
//  Created by Hibah Abdullah Alatawi on 17/01/1445 AH.
//

import SwiftUI

struct AddView: View {
    
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var title: String = ""
    @State var description: String = ""
    @State var priority: TaskPriority = .low
    @State var status: TaskStatus = .backlog
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Task Title", text: $title)
                        TextField("Task Description", text: $description, axis: .vertical)
                            .lineLimit(4, reservesSpace: true)
                    } header: {
                        Text("Title And Description")
                            .foregroundColor(.black)
                            .bold()
                    }
                    
                    Section {
                        Picker("", selection: $priority) {
                            Text("Low")
                                .tag(TaskPriority.low)
                            Text("Medium")
                                .tag(TaskPriority.medium)
                            Text("High")
                                .tag(TaskPriority.high)
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Priority")
                            .foregroundColor(.black)
                            .bold()
                    }
                    
                    Section {
                        Picker("", selection: $status) {
                            Text("Backlog")
                                .tag(TaskStatus.backlog)
                            Text("Todo")
                                .tag(TaskStatus.todo)
                            Text("In-Progress")
                                .tag(TaskStatus.inProgress)
                            Text("Done")
                                .tag(TaskStatus.done)
                        }
                        .pickerStyle(.inline)
                        .labelsHidden()
                    } header: {
                        Text("Status")
                            .foregroundColor(.black)
                            .bold()
                    }
                    
                }
                .scrollContentBackground(.hidden)
                
                Button {
                    saveItem()
                } label: {
                    Text("SAVE")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(12)
                        .padding()
                }
            }
            .background {
                Image("background")
            }
            .navigationTitle("Add an Item")
        }
        
        
        
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    
    func saveItem() {
        if isValidForm() {
            print("valid ")
            let item = TaskModel(id: UUID(),
                                 title: title,
                                 description: description,
                                 status: status,
                                 priority: priority
            )
            listViewModel.addItem(item: item)
            dismiss()
        }
    }
    
    func isValidForm() -> Bool {
        alertTitle = ""
        if title.count < 3 {
            alertTitle = "Your title should be at least 3 characters long!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
