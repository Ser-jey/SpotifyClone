//
//  PlayerControlsView.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 08.06.2023.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControls: PlayerControlsView)
    func playerControlsViewDidTapBackwardButton(_ playerControls: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControls: PlayerControlsView)
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
       let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPausButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(volumeSlider)
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(backButton)
        addSubview(playPausButton)
        addSubview(forwardButton)
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        playPausButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }
    
    @objc
    private func didTapBack() {
        delegate?.playerControlsViewDidTapBackwardButton(self)
    }
    
    @objc
    private func didTapPlayPause() {
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
    }
    
    @objc
    private func didTapNext() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44)
        let buttonSize: CGFloat = 60
        playPausButton.frame = CGRect(x: (width/2-buttonSize/2), y: volumeSlider.bottom+20, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playPausButton.left - 90, y: volumeSlider.bottom+20, width: buttonSize, height: buttonSize)
        forwardButton.frame = CGRect(x: playPausButton.right + 90 - buttonSize, y: volumeSlider.bottom+20, width: buttonSize, height: buttonSize)
    }
    
}
