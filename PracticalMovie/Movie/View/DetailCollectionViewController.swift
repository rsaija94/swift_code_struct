//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//

import UIKit

class DetailCollectionViewController: UIViewController {
    
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Rights: UILabel!
    @IBOutlet weak var lbl_Summary: UILabel!
    @IBOutlet weak var lbl_RentalPrice: UILabel!
    @IBOutlet weak var lbl_ContentType: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var entry:Entry? = nil

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func onClickLink(_ sender: Any) {
        guard let url = URL(string: entry?.link?[0].attributes?.href ?? ""
        ) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }

    }
    
    func setupView() {
        pageController.pageIndicatorTintColor = .gray.withAlphaComponent(0.3)
        pageController.currentPageIndicatorTintColor = .gray
        lbl_Name.text = "Name: \(entry?.name?.label ?? "")"
        lbl_Rights.text = "Rights: \(entry?.rights?.label ?? "")"
        lbl_Summary.text = "Summary:     \(entry?.summary?.label ?? "")"
        lbl_RentalPrice.text = "Rental Price: \(entry?.rentalPrice?.label ?? "")"
        lbl_ContentType.text = "Content Type: \(entry?.contentType?.attributes?.label ?? "")"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(
            (collectionView.contentOffset.x / collectionView.frame.width)
                .rounded(.toNearestOrAwayFromZero)
            )
      
    }

    
}


extension DetailCollectionViewController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let k = entry?.arrImage?.count
        pageController.numberOfPages = k ?? 0
        return k ?? 0

        entry?.arrImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionView", for:indexPath) as? DetailCollectionView
        
        ImageDownloader.shared.loadImageUsingCache(withUrl: entry?.arrImage?[indexPath.item].label ?? "") { image in
            cell?.imgView.image = image
        }
        
        return cell ?? UICollectionViewCell()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
