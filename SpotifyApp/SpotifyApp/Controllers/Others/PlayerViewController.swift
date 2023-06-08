//
//  PlayerViewController.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 08.06.2023.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController {

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    var track: AudioTrack?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
        controlsView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.width
        )
        controlsView.frame = CGRect(
            x: 10,
            y: imageView.bottom+10,
            width: view.width-20,
            height: view.height-imageView.height-view.safeAreaInsets.bottom-view.safeAreaInsets.top-10
        )
    }
    
    func configure(with track: AudioTrack) {
        DispatchQueue.main.async { [self] in
            imageView.sd_setImage(with: URL(string: track.album?.images.first?.url ?? ""))
        }
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc
    private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapAction() {
        
    }
    
    
}

// MARK: - PlayerControlsViewDelegate

extension PlayerViewController: PlayerControlsViewDelegate {
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControls: PlayerControlsView) {
        print("Play Pause")
    }
    
    func playerControlsViewDidTapBackwardButton(_ playerControls: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControls: PlayerControlsView) {
        
    }
    
    
}

