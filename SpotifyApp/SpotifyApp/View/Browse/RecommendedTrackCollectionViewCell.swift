//
//  RecommendedTrackCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 30.04.2023.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let trackCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .light)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(trackCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        trackCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        trackCoverImageView.sd_setImage(with: viewModel.artWorkURL)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackCoverImageView.frame = CGRect(
            x: 5,
            y: 2,
            width: contentView.height - 4,
            height: contentView.height - 4
        )
        
        trackNameLabel.frame = CGRect(
            x: trackCoverImageView.right + 10,
            y: 0,
            width: contentView.width - trackCoverImageView.right + 15,
            height: contentView.height / 2
        )
        
        artistNameLabel.frame = CGRect(
            x: trackCoverImageView.right + 10,
            y: contentView.height / 2,
            width: contentView.width - trackCoverImageView.right + 15,
            height: contentView.height / 2
        )
        
        }
    
    
}
