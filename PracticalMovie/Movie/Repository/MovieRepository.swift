//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import Foundation
protocol MovieRepository {
    func fetchMovie(completion: @escaping (MovieModel?, Error?) -> Void)
}

class MovieRepositoryImpl:MovieRepository {
    
    func fetchMovie(completion: @escaping (MovieModel?, Error?) -> Void) {
        APIManager.shared.request(modelType: MovieModel.self, type: MovieListEndPoint.movieList) { response in
            switch response {
            case .success(let movies):
                completion(movies, nil)
            case .failure(let error):
                print("Error fetching products: \(error)")
                completion(nil, error)
            }
        }
    }

}

