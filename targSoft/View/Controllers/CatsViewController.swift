//
//  ViewController.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit
import Combine

class CatsViewController: UIViewController {
    
    var viewModel: CatsViewControllerViewModelType = CatsViewControllerViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    private lazy var catsTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        tv.allowsSelection = false
        tv.tableFooterView = footerView
        tv.separatorStyle = .none
        tv.register(CatCell.self, forCellReuseIdentifier: CatCell.reuseIdentifier)
        return tv
    }()
    
    private let footerView = FooterView()
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(catsTableView)
        
        NSLayoutConstraint.activate([
            catsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            catsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            catsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.catsItem
            .handleEvents( receiveOutput: { [weak self] (cats) in
                self?.footerView.hideLoader()
                self?.catsTableView.reloadData()
            })
            .sink { _ in }
            .store(in: &subscriptions)
    }
    
}

//MARK: -DataSource

extension CatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCatsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CatCell.reuseIdentifier, for: indexPath) as? CatCell {
            cell.viewModel = viewModel.getCatCellViewModel(for: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK: -Delegate

extension CatsViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = self.catsTableView.bounds.height
        if scrollView.contentOffset.y > (scrollView.contentSize.height - height) * 0.9 && footerView.isShown == false {
            footerView.showLoader()
            
            viewModel.catsEndReached()
        }
    }
}
