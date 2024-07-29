//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import Foundation
import Combine

class MovieViewModel {
    @Published var reloadTable = false
    var arrMovie:[KeyMovieModel] = []
    let movieUseCaseImpl = MovieUseCaseImpl(repository: MovieRepositoryImpl())
    private var cancellables = Set<AnyCancellable>()

    init(arrMovie:[KeyMovieModel]? = nil) {
        self.arrMovie = arrMovie ?? []
    }
    
    func fetchMovies() {
        movieUseCaseImpl.fetchMovies { [self] (movieModel, error) in
            if error == nil {
                let data = movieModel?.feed?.entry
                var groupedMovie = [Character: [Entry]]()
                if let data = data {
                    for movie in data {
                        let firstLetter = movie.name?.label?.uppercased().first ?? "A"
                        if groupedMovie[firstLetter] == nil {
                            groupedMovie[firstLetter] = [movie]
                        } else {
                            groupedMovie[firstLetter]?.append(movie)
                        }
                    }
                }
                arrMovie  = []
                groupedMovie.forEach { (key: Character, value: [Entry]) in
                    self.arrMovie.append(KeyMovieModel(key: key, value: value))
                }
                self.arrMovie = self.arrMovie.sorted(by: { $0.key ?? "K" < $1.key ?? "K"})
               reloadTable.toggle()
            }
            else {
                print("error is:\(error?.localizedDescription ?? "")")
                
            }
        }
    }
}
