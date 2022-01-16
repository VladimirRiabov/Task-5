//
//  ViewModel.swift
//  Task 5-8
//
//  Created by Владимир Рябов on 16.01.2022.
//

import Foundation
import SwiftUI

struct Response: Hashable, Codable {
    let results: [User]
}

struct User: Hashable, Codable {
    let id: Int
    let name: String
    let image: String
    let species: String
    
}

@MainActor
class ViewModel: ObservableObject {
    @Published var results: [User] = []
    
    func loadData() async {
        //1. make url
        print("pusk")
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid Url")
            return
        }
        //2. Получаем данные
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedData = try? JSONDecoder().decode(Response.self, from: data) {
                self.results = decodedData.results
                
            }
        } catch {
            print("Invalid data")
        }
        
       
    }
    
}
