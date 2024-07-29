//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import Foundation


enum MovieListEndPoint {
    case movieList
    
}

extension MovieListEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .movieList:
            return "WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json"
        }
    }
    
    var baseURL: String {
        switch self {
            
        case .movieList:
            return "http://ax.itunes.apple.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")

    }
    
    var method: HTTPMethods {
        switch self {
            
        case .movieList:
                .get
        }
    }
    
    var body: Encodable? {
        switch self {
            
        case .movieList:
            return nil
        }
    }
    
    var headers: [String : String]? {
        APIManager.commonHeaders
    }
    
    var parameters: [String : Any]? {
        switch self {
            
        case .movieList:
            return nil
        }
    }
}
