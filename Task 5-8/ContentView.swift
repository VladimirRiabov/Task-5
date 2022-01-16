//
//  ContentView.swift
//  Task 5-8
//
//  Created by Владимир Рябов on 16.01.2022.
//

import SwiftUI

struct Response: Codable {
    var results: [User]
}

struct User: Codable {
    let id: Int
    let name: String
    let image: String
    let species: String
    
}

struct ContentView: View {
    @State private var results = [User]()
    @State private var searchText = ""
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(red: 0.22, green: 0.23, blue: 0.30, alpha: 1)
    }
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    Text("Рекомендации")
                        .font(.headline)
                        .padding()
                    List(searchResults, id: \.id) { user in
                        
                        HStack {

                            AsyncImage(url: URL(string: user.image)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 100, height: 90)
                            .clipShape(Circle())

                            Text(user.name)
                
                        }
                        
                        .listRowBackground(Color(red: 0.22, green: 0.23, blue: 0.30))
                    }
                    .listStyle(.grouped)

                }
            }
            .preferredColorScheme(.dark)
            .background(Color(red: 0.22, green: 0.23, blue: 0.30))
            .navigationTitle("Найти нового собеседника")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .searchable(text: $searchText)
            
    //
            .task {
                await loadData()
            }
            
            
        }
        
    }
      
    func loadData() async {
        //1. make url
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid Url")
            return
        }
        //2. Получаем данные
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
                print("dfdfdf")
            }
        } catch {
            print("Invalid data")
        }
        
       
    }
    
    var searchResults: [User] {
            if searchText.isEmpty {
                return results
            } else {
                return results.filter { $0.name.contains(searchText) }
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
