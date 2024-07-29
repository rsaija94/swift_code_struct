//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import Foundation

class KeyMovieModel  {
    let key:Character?
    let value:[Entry]?
    
    init(key: Character?, value: [Entry]?) {
        self.key = key
        self.value = value
    }
}
