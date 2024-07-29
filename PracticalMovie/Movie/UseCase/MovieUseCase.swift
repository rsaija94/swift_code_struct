//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import Foundation

protocol MovieUseCase {
    func fetchMovies(completion: @escaping (MovieModel?, Error?) -> Void)
}


class MovieUseCaseImpl: MovieUseCase {
    
    let repository: MovieRepository
    
    init(repository: MovieRepository) {
        self.repository = repository
    }
    
    func fetchMovies(completion: @escaping (MovieModel?, Error?) -> Void) {
        return repository.fetchMovie { movie, error in
            if error == nil {
                completion(movie,nil)
            } else {
                completion(nil,error)
            }
        }
    }
}
