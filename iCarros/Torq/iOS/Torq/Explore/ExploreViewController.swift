//
//  ExploreViewController.swift
//  Torq
//
//  Created by Jean Paul Marinho on 20/10/18.
//  Copyright © 2018 aKANJ. All rights reserved.
//

import UIKit
import Koloda
import Alamofire

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var outCardView: UIView!
    @IBOutlet weak var btnReverse: UIButton!
    @IBOutlet weak var bankOfferView: UIView!
    
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
        reloadCarsFromServer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ReviewViewController
        vc.car = sender as? Car
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bankOfferView.layer.cornerRadius = 10
        bankOfferView.layer.borderColor = UIColor.lightGray.cgColor
        bankOfferView.layer.borderWidth = 2
    }

    func reloadCarsFromServer() {
        URLSession.shared.dataTask(with: URL(string: "http://ec2-52-201-246-29.compute-1.amazonaws.com/api/ListarCarrosMatch")!) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.cars = try decoder.decode([Car].self, from: data)
                DispatchQueue.main.async{
                    self.btnReverse.isHidden = false
                    self.outCardView.isHidden = true
                    self.kolodaView.reloadData()
                }
            } catch let err {
                print("Err", err)
            }
        }.resume()
    }
    
    
    
    
    @IBAction func reloadCards(_ sender: Any) {
        reloadCarsFromServer()
    }
    
    @IBAction func changeProfile(_ sender: Any) {
        
    }
    
    @IBAction func reverse(_ sender: Any) {
        kolodaView.revertAction()
    }
}

extension ExploreViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        outCardView.isHidden = false
        koloda.isHidden = true
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        performSegue(withIdentifier: "toReviewVC", sender: cars[index])
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .right {
            performSegue(withIdentifier: "toReviewVC", sender: cars[index])
        }
    }
}

extension ExploreViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return cars.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        let car = cars[index]
        
        guard
            let views = Bundle.main.loadNibNamed("CardView", owner: self, options: nil),
            let view = views[0] as? CardView
        else {
            return UIView()
        }
        
        view.cardTitle.text = car.model
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: car.estimatePrice as NSNumber) {
            view.cardPrice.text = formattedTipAmount
        }
        
        view.cardImage.af_setImage(withURL: URL(string: car.imageURL)!)
        view.cardRate.rating = Double(exactly: car.score)!
        
        return view
    }
}
