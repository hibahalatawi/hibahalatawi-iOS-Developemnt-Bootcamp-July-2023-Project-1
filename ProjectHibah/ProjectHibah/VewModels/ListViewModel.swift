//
//  ListViewModel.swift
//  ProjectHibah
//
//  Created by Hibah Abdullah Alatawi on 17/01/1445 AH.
//

import SwiftUI

class ListViewModel: ObservableObject {
    
    @AppStorage("items") var items: [TaskModel] = []
    
    @Published var filteredItems: [TaskModel] = []
    
    var listItems: [TaskModel] {
        if searchText.isEmpty && selectedStatus == nil {
            return items
        } else {
            return filteredItems
        }
    }
    
    @Published var searchText: String = ""
    @Published var selectedStatus: TaskStatus? = nil
    
    func filterItems(text: String) {
        filteredItems = items.filter {
            $0.title.lowercased().contains(text.lowercased())
        }
    }
    
    func filterItems(status: TaskStatus?) {
        filteredItems = items.filter {
            $0.status == status
        }
    }
    
    func deleteItem(indexSet:IndexSet){
        items.remove(atOffsets :indexSet)
    }
    
    func addItem(item: TaskModel) {
        items.append(item)
    }
    
    func updateItem(item: TaskModel) {
        print("updating")
        if let index = items.firstIndex (where: { $0.id.uuidString == item.id.uuidString }) {
            items[index] = item
            print("update")
        } else {
            print("index not found")
        }
    }
    
    
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode([Element].self, from: data)
            print("Init from result: \(result)")
            self = result
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        print("Returning \(result)")
        return result
    }
}
