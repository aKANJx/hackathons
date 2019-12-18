//
//  IntroViewController.swift
//  Saiga
//
//  Created by Jean Paul Marinho on 26/08/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit
import Lottie

class IntroViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var proceedButton: UIButton!
    var titles = ["Melhor localização para vendas",
                  "Maximizar lucros",
                  "Maior visibilidade"]
    var abouts = ["Descubra os melhores locais para vender", "Aumente suas vendas em diferentes regiões", "Seja direcionado para diferentes públicos"]

    @IBOutlet weak var pagecontroller: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.proceedButton.backgroundColor = UIColor.hexStringToUIColor(hex: "55A773")
    }
    private  func addLottie(with name: String, in view: UIView) {
        let animationView = LOTAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = true
        animationView.frame = view.bounds
        view.addSubview(animationView)
        animationView.play{ (finished) in
        }
    }
}



extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginCell", for: indexPath) as! LoginCell
        self.addLottie(with: "lottie\(indexPath.row+1)", in: cell.lottieView)
        cell.titleLabel.text = self.titles[indexPath.row]
        cell.aboutLabel.text = self.abouts[indexPath.row]
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pagecontroller.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
