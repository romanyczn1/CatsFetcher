//
//  FavoritesViewController.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit
import Combine

class FavoritesViewController: UIViewController {
    
    var viewModel: FavoritesViewControllerViewModelType = FavoritesViewControllerViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var favoriteCatsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.allowsSelection = false
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        tv.register(FavoriteCatCell.self, forCellReuseIdentifier: FavoriteCatCell.reuseIdentifier)
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchCats()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(favoriteCatsTableView)
        
        NSLayoutConstraint.activate([
            favoriteCatsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteCatsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteCatsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteCatsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.catsItem
            .handleEvents( receiveOutput: { [weak self] (cats) in
                self?.favoriteCatsTableView.reloadData()
            })
            .sink { _ in }
            .store(in: &subscriptions)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCatsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCatCell.reuseIdentifier, for: indexPath) as? FavoriteCatCell {
            cell.viewModel = viewModel.getCatCellViewModel(for: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
}
