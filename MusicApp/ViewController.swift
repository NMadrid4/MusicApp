//
//  ViewController.swift
//  MusicApp
//
//  Created by Nicolas on 26/07/18.
//  Copyright © 2018 Nicolas. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    //esto es una instancia de AVAudioPlayer
    var audio: AVAudioPlayer!
    //coleccion de canciones
    var canciones: [String] = ["Fito Paez - Mariposa Technicolor (letra)","Starboy - The Weeknd (lyrics)","Soda Stereo - Fue"]
    var cont: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isHidden = true
        
        previousButton.isEnabled = false
        playSound(fileName: canciones[cont], fileExtension: "mp3")
        print(cont)
    }
    
    
    func playSound(fileName: String, fileExtension: String) {
        let audioSourceURL: URL!
        audioSourceURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if audioSourceURL == nil {
            print("Audio no compatible")
        }else {
            do{
                audio = try AVAudioPlayer.init(contentsOf: audioSourceURL!)
                audio.prepareToPlay()
            }catch{
                print(error)
            }
            
        }
    }

    @IBAction func playSound(_ sender: Any) {
        titleLabel.text = canciones[cont]
        playButton.isHidden = true
        pauseButton.isHidden = false
        audio.play()
    }

    @IBAction func pauseSound(_ sender: Any) {
        if audio.isPlaying {
                audio.pause()
            
        }
        pauseButton.isHidden = true
        playButton.isHidden = false
    }
    @IBAction func previousSound(_ sender: Any) {
        if !audio.isPlaying {
            playButton.isHidden = true
            pauseButton.isHidden = false
        }
        if cont > 0 {
            previousButton.isEnabled = true
            cont-=1
            playSound(fileName: canciones[cont], fileExtension: "mp3")
            audio.play()
            titleLabel.text = canciones[cont]
            print(cont)
        }
        if cont == 0{
            previousButton.isEnabled = false
        }
    }
    
    @IBAction func nextSound(_ sender: Any) {
        previousButton.isEnabled = true
        if !audio.isPlaying {
            playButton.isHidden = true
            pauseButton.isHidden = false
        }
        if cont == canciones.count-1 {
            cont=0
            playSound(fileName: canciones[cont], fileExtension: "mp3")
            audio.play()
            titleLabel.text = canciones[cont]
            return
        }
        cont+=1
        playSound(fileName: canciones[cont], fileExtension: "mp3")
        audio.play()
        titleLabel.text = canciones[cont]
    }
}

