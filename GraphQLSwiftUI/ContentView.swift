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
                    
                    NavigationLink (destination: CountryDetailView(country: country), label: {
                        HStack(alignment: .center) {
                            
                            Text(country.emoji)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(country.name)
                                    .font(.system(size: 26, weight: .bold, design: .default))
                                    .foregroundColor(.black)
                                Text(country.capital ?? "Managua")
                                    .font(.system(size: 16, weight: .bold, design: .default))
                                    .foregroundColor(.gray)
                            }
                            
                        }
                    })
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
