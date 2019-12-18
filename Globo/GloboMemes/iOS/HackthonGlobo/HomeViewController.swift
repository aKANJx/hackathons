//
//  HomeViewController.swift
//  HackthonGlobo
//
//  Created by Fabio Barboza on 5/13/17.
//  Copyright © 2017 Bruno Faganello Neto. All rights reserved.
//

import UIKit
import SFFocusViewLayout
import AVFoundation

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let repository = Repository()
    fileprivate let renderer = Renderer()
    
    var currentCell: CollectionViewCellInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self)
        
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.backgroundColor = .clear
        collectionView.backgroundView?.backgroundColor = .clear
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playCell(at: IndexPath(row: 0, section: 0))
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func playCell(at indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellInterface else {
            return
        }
        
        cell.getVideoView().stop()
        collectionView.layoutIfNeeded()
        self.currentCell?.getVideoView().stop()
        self.currentCell = nil
        self.currentCell = cell
        self.currentCell?.getVideoView().play()
    }
    
    func recordButtonPressed(_ sender: UIButton) {
        currentCell?.getVideoView().stop()
        let resource = repository[sender.tag]
        performSegue(withIdentifier: "showDetail", sender: resource)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let resource = sender as? Resource, let movieViewController = segue.destination as? MovieViewController {
                movieViewController.resource = resource
                currentCell?.getVideoView().stop()
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath) as CollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard
            let cell = cell as? CollectionViewCell
            else {
                fatalError("error with registred cell")
        }
        cell.recordButton.tag = indexPath.row
        cell.recordButton.addTarget(self, action: #selector(recordButtonPressed(_:)), for: .touchUpInside)
        renderer.present(model: repository[indexPath.item], in: cell)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard
            let focusViewLayout = collectionView.collectionViewLayout as? SFFocusViewLayout
            else {
                fatalError("error casting focus layout from collection view")
        }
        
        let offset = focusViewLayout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
        
        playCell(at: indexPath)
        
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var paths: [IndexPath] = [IndexPath]()
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            paths.append(indexPath!)
        }
        paths.sort(by: {$0.row < $1.row})
        playCell(at: paths[0])
        
        collectionView.layoutIfNeeded()
    }
}
