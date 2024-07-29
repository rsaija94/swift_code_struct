//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//


import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieCollection: UICollectionView!
    var movieData:[Entry] = []
    var closureMovieData:((_ movieData:Entry) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        movieCollection.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        movieCollection.dataSource = self
        movieCollection.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MovieTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        cell?.lbnNameMovie.text = movieData[indexPath.item].name?.label
        ImageDownloader.shared.loadImageUsingCache(withUrl: movieData[indexPath.item].arrImage?.first?.label ?? "") { image in
            cell?.imageMovie.image = image
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        closureMovieData!(movieData[indexPath.row])
        
    }
    
    
}
