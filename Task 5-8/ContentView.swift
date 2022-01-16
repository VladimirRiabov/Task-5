//
//  ContentView.swift
//  Task 5-8
//
//  Created by Владимир Рябов on 16.01.2022.
//

import SwiftUI



struct ContentView: View {

    @State private var searchText = ""
    @StateObject var viewModel  = ViewModel()
    @State private var isSearching = false
    
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(red: 0.22, green: 0.23, blue: 0.30, alpha: 1)
    }
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
//
                    Text(searchText.isEmpty ? "Рекомендации" : "Найденные")
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
                    
                    if searchText.isEmpty == false {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white)
                            .opacity(0.5)
                            
                            .padding(.vertical)
                            .padding(.vertical)
                        Text("Рекомендации")
                            .font(.headline)
                            .padding()
                        List(viewModel.results.filter {!$0.name.contains(searchText) } , id: \.id) { user in
                            
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
            }
            .preferredColorScheme(.dark)
            .background(Color(red: 0.22, green: 0.23, blue: 0.30))
            .navigationTitle("Найти нового собеседника")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .searchable(text: $searchText)
            
    //
            .task {
                await viewModel.loadData()
            }
            
            
        }
        
    }
      
    
    var searchResults: [User] {
            if searchText.isEmpty {
                
                return viewModel.results
            } else {
                
                return viewModel.results.filter { $0.name.contains(searchText) }
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
