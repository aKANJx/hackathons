//
//  DashboardViewController.swift
//  HackathonMetropolitana
//
//  Created by Jean Paul Marinho on 19/03/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit

class HUDCollectViewController: UIViewController {
   
    @IBOutlet weak var hudView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectDistanceLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    var seconds = 300
    var timer = Timer()
    var isTimerRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hudView.layer.shadowColor = UIColor.black.cgColor
        self.hudView.layer.shadowOpacity = 1
        self.hudView.layer.shadowOffset = CGSize.zero
        self.hudView.layer.shadowRadius = 5
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSStrokeWidthAttributeName : -0.5,
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 21)
            ] as [String : Any]
        
        self.headerLabel.attributedText = NSMutableAttributedString(string: "Vá para o ponto indicado no mapa para o embarque", attributes: strokeTextAttributes)
        self.runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i min", minutes, seconds)
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            self.countdownLabel.text = "Viagem cancelada..."
        } else {
            seconds -= 1
            self.countdownLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
}



//@IBAction func notificationPressed(_ sender: UIButton) {
//    let localNotification = UILocalNotification()
//    localNotification.fireDate = Date.init(timeIntervalSinceNow: 10)
//    localNotification.alertBody = "O seu veículo já está próximo! Toque para mais detalhes..."
//    UIApplication.shared.scheduleLocalNotification(localNotification)
//}
