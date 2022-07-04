//
//  ApolloNetwork.swift
//  GraphQLSwiftUI
//
//  Created by Manuel Duarte on 4/7/22.
//

import Foundation
import Apollo


class Network {
    
    static let shared = Network()
    private init() {}
    
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    
    
    
}
