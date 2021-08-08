//
//  FavoriteCatCell.swift
//  targSoft
//
//  Created by Roman Bukh on 8.08.21.
//

import UIKit

final class FavoriteCatCell: UITableViewCell {
    
    static let reuseIdentifier = "FavoriteCatCell"
    var viewModel: FavoriteCatCellViewModelType? {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        
    }
    
    private func setUpViews() {
        contentView.addSubview(emptyBackgroundView)
        emptyBackgroundView.addSubview(postImageView)
        
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
        postImageView.bottomAnchor.constraint(equalTo: emptyBackgroundView.bottomAnchor).isActive = true

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.image = nil
        postImageView.cancelLoadingImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
