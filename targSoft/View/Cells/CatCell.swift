//
//  CatCell.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

final class CatCell: UITableViewCell {
    
    static let reuseIdentifier = "CatCell"
    var viewModel: CatCellViewModelType? {
        didSet {
            if viewModel != nil {
                postImageView.set(imageURL: viewModel!.imageURL)
            }
        }
    }
    
    let emptyBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.down")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        
    }
    
    private func setUpViews() {
        contentView.addSubview(emptyBackgroundView)
        emptyBackgroundView.addSubview(postImageView)
        emptyBackgroundView.addSubview(bottomView)
        bottomView.addSubview(favoriteButton)
        bottomView.addSubview(downloadButton)
        
        emptyBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        emptyBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        emptyBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        emptyBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        postImageView.topAnchor.constraint(equalTo: emptyBackgroundView.topAnchor).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: emptyBackgroundView.leadingAnchor, constant: 0).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: emptyBackgroundView.trailingAnchor, constant: -0).isActive = true
        let newsImageViewHeightAnchor = postImageView.heightAnchor.constraint(equalToConstant: 200)
        newsImageViewHeightAnchor.priority = UILayoutPriority(rawValue: 999)
        newsImageViewHeightAnchor.isActive = true
        
        bottomView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: emptyBackgroundView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: emptyBackgroundView.trailingAnchor, constant: -0).isActive = true
        let bottomViewHeightAnchor = bottomView.heightAnchor.constraint(equalToConstant: 50)
        bottomViewHeightAnchor.priority = UILayoutPriority(rawValue: 999)
        bottomViewHeightAnchor.isActive = true
        bottomView.bottomAnchor.constraint(equalTo: emptyBackgroundView.bottomAnchor, constant: -5).isActive = true
        
        favoriteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -100).isActive = true
        
        downloadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        downloadButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        downloadButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 100).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.image = nil
        postImageView.cancelLoadingImage()
    }
    
    @objc func favButtonTapped() {
        viewModel?.favButtonTapped()
    }
    
    @objc private func downloadButtonTapped() {
        viewModel?.downloadButtonTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
