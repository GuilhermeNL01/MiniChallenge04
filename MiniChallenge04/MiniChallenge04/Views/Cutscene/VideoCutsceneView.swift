//
//  VideoCutsceneView.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 21/03/24.
//


import UIKit
import SwiftUI
import SpriteKit
import AVFoundation

class VideoCutsceneScene: SKScene {
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var skipButton: UIButton?
    var isPlayingInBackground = false
    var nextScene: SKScene?
    
    override func didMove(to view: SKView) {
        initializeView()


        //Observadores para os estados do dispositivos
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func initializeView() {
        backgroundColor = .black
        loadVideo()
    }
    
    private func loadVideo() {
        // Execução assíncrona do processamento do vídeo
        DispatchQueue.global().async {
            guard let videoURL = Bundle.main.url(forResource: "P", withExtension: "mp4") else {
                print("Vídeo não encontrado")
                return
            }
            
            DispatchQueue.main.async {
                self.videoPlayer = AVPlayer(url: videoURL)
                self.videoPlayerLayer = AVPlayerLayer(player: self.videoPlayer)
                
                if let viewBounds = self.view?.bounds {
                    // Tamanho do player
                    let videoPlayerSize = CGSize(width: viewBounds.width * 1.1, height: viewBounds.height * 0.7)
                    self.videoPlayerLayer?.frame = CGRect(origin: .zero, size: videoPlayerSize)
                    // Centraliza o player na view
                    self.videoPlayerLayer?.position = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
                }
                
                let borderLayer = CALayer()
                borderLayer.frame = self.view?.bounds ?? CGRect.zero
             //   borderLayer.backgroundColor = UIColor.black.cgColor
                self.view?.layer.addSublayer(borderLayer)
                self.view?.layer.insertSublayer(self.videoPlayerLayer!, above: borderLayer)
                
                self.videoPlayerLayer?.videoGravity = .resizeAspectFill
                
                if !self.isPlayingInBackground {
                    self.videoPlayer?.play()
                }
                
                // Botão de Skip
                self.skipButton = UIButton(type: .custom)
                let skipImage = UIImage(named: "Skip")
                self.skipButton?.setImage(skipImage, for: .normal)
                self.skipButton?.addTarget(self, action: #selector(self.skipButtonTapped), for: .touchUpInside)
                self.view?.addSubview(self.skipButton!)
                
                //Posição Botão de Skip
                self.skipButton?.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    self.skipButton!.topAnchor.constraint(equalTo: self.view!.safeAreaLayoutGuide.topAnchor, constant: 20),
                    self.skipButton!.trailingAnchor.constraint(equalTo: self.view!.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    self.skipButton!.widthAnchor.constraint(equalToConstant: skipImage?.size.width ?? 0),
                    self.skipButton!.heightAnchor.constraint(equalToConstant: skipImage?.size.height ?? 0)
                ])
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem)
            }
        }
    }
    
    private func goToNextScene() {
            nextScene = ContextGameScene(size: CGSize(width: larguraTela, height: alturaTela))
            if let nextScene = nextScene {
                self.view?.presentScene(nextScene)
                // Parar o vídeo antes de mudar de cena
                videoPlayer?.pause()
                // Remover a camada do player de vídeo
                videoPlayerLayer?.removeFromSuperlayer()
            }
        }


    

    
}

extension VideoCutsceneScene{
    // Função para realizar alguma ação quando o vídeo acabar
    @objc func videoDidEnd() {
        goToNextScene()
    }
    
    // Função para ação do botão de Skip
    @objc func skipButtonTapped() {
        goToNextScene()
    }
    
    // Função para lidar com o aplicativo em segundo plano
    @objc func appDidEnterBackground() {
        isPlayingInBackground = true
        videoPlayer?.pause()
    }
    
    // Função para lidar com o aplicativo em primeiro plano
    @objc func appWillEnterForeground() {
        if scene?.isFocused ?? false {
            isPlayingInBackground = false
            videoPlayer?.play()
        } else {
            videoPlayer?.pause()
        }
    }
}
