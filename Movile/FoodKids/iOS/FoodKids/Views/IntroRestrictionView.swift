//
//  IntroRestrictionView.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import UIKit
import TagListView

class IntroRestrictionView: UIView {

    @IBOutlet weak var tagListView: TagListView!
    var tagListDelegateHandler = TagListDelegateHandler(state: .multiple)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TagListView.config(view: self.tagListView)
        self.tagListView.addTags(["Diabetes", "Lactose", "Vegetariano", "Dislipidemia", "Constipação", "Rejeição ao glúten", "Doença de Crohn", "Gastrite"])
        self.tagListView.delegate = self.tagListDelegateHandler
    }
}
