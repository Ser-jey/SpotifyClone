//
//  PlaybackPresenter.swift
//  SpotifyApp
//
//  Created by Сергей Кривошеев on 08.06.2023.
//

import Foundation
import UIKit

final class PlaybackPresenter {
    
    static func startPlayback(
        from viewController: UIViewController,
        track: AudioTrack
    ) {
        let vc = PlayerViewController()
        vc.title = track.name
        vc.configure(with: track)
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    static func startPlayback(
        from viewController: UIViewController,
        tracks: [AudioTrack]
    ) {
        let vc = PlayerViewController()
        viewController.present(vc, animated: true)
    }
    
}
