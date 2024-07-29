//
//  DetailCollectionViewController.swift
//  PracticalMovie
//
//  Created by Raj's Mac on 04/05/24.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var networkUnavailableView: UIView!
    @IBOutlet weak var movieTableView: UITableView!
    let movieViewModel = MovieViewModel()
    private var cancellables = Set<AnyCancellable>()
    let reachability = Reachability()


    override func viewDidLoad() {
        super.viewDidLoad()
        reachability.$isConnected.sink { value in
            if value {
                    self.movieTableView.isHidden = false
                    self.networkUnavailableView.isHidden = true
            } else {
                    self.movieTableView.isHidden = true
                    self.networkUnavailableView.isHidden = false
            }
        }.store(in: &cancellables)
        setupView()
    }

    func setupView() {
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieTableView.register(nib, forCellReuseIdentifier: "MovieTableViewCell")
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.separatorStyle = .none
        
        movieViewModel.$reloadTable
            .sink { [weak self] _ in
                if self?.movieViewModel.arrMovie.count ?? 0 > 0 {
                    DispatchQueue.main.async {
                        self?.movieTableView.reloadData()

                    }
                    
                }
            }
            .store(in: &cancellables)
        movieViewModel.fetchMovies()

    }

}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.movieViewModel.arrMovie.count 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1

    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.movieViewModel.arrMovie.map({"\($0.key ?? "K")"})
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.green
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 5, width: tableView.frame.width - 30, height: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.text = "\(self.movieViewModel.arrMovie[section].key ?? "K")"
        headerView.addSubview(titleLabel)
        
        return headerView
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell
        cell?.movieData = (movieViewModel.arrMovie[indexPath.section].value ?? [])
        cell?.movieCollection.tag = indexPath.section
        cell?.closureMovieData = { [weak self] data in
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailCollectionViewController") as? DetailCollectionViewController
            vc?.entry = data
            self?.navigationController?.pushViewController(vc!, animated: true)

        }
        cell?.movieCollection.reloadData()
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}
