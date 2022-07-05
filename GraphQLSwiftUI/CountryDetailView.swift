//
//  CountryDetailView.swift
//  GraphQLSwiftUI
//
//  Created by Manuel Duarte on 4/7/22.
//

import SwiftUI

struct CountryDetailView: View {
    
    let country: GetAllCountriesQuery.Data.Country
    @State private var countryInfo: GetAllCountriesDetailQuery.Data.Country?
    
    var body: some View {
        
        VStack {
            Text(countryInfo?.emoji ?? "")
                .font(.largeTitle)
            HStack{
                Text(countryInfo?.name ?? "")
                    .font(.title)
                    .bold()
                Text(countryInfo?.continent.name ?? "America")
                    .font(.title2)
            }
            
            
            List(countryInfo?.states ?? [], id: \.name) { state in
                Text(state.name)
            }
            
            List(countryInfo?.languages ?? [], id: \.name) { language in
                Text(language.name ?? "Miskito")
            }
            
            
        }.onAppear(perform: {
            Network.shared.apollo.fetch(query: GetAllCountriesDetailQuery(code: country.code)) { result in
                switch result {
                    case .success(let graphQLResult):
                        DispatchQueue.main.async {
                            self.countryInfo = graphQLResult.data?.country
                        }
                    case .failure(let error):
                        print(error)
                }
            }
        })
    }
}


struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: GetAllCountriesQuery.Data.Country(code: "", name: "", emoji: ""))
    }
}

