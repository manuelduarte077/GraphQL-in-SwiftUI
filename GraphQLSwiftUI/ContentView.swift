//
//  ContentView.swift
//  GraphQLSwiftUI
//
//  Created by Manuel Duarte on 4/7/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries: [GetAllCountriesQuery.Data.Country] = []
    
    var body: some View {
        
        NavigationView {
            VStack {
                List(countries, id: \.code) { country in
                    
                    HStack {
                        
                        Text(country.emoji)
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text(country.name)
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text(country.capital ?? "Managua")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
            }
            
            .onAppear(perform: {
                Network.shared.apollo.fetch(query: GetAllCountriesQuery()) { result in
                    
                    switch result {
                        case .success(let graphQLResult):
                            if let countries = graphQLResult.data?.countries {
                                DispatchQueue.main.async {
                                    self.countries = countries
                                }
                            }
                            
                        case .failure(let error):
                            print(error)
                    }
                    
                }
            })
            .navigationTitle("Countries")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
