//
//  TagListDatasource.swift
//  FoodKids
//
//  Created by Jean Paul Marinho on 19/08/18.
//  Copyright © 2018 Expresso MovHack Expresso MovHack Expresso MovHack Expresso MovHack. All rights reserved.
//

import Foundation
import TagListView

extension TagListView {
    
    class func config(view: TagListView) {
        view.textColor = UIColor.black
        view.textFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.paddingX = 30
        view.paddingY = 10
        view.cornerRadius = view.frame.height/4.0
        view.tagBackgroundColor = UIColor.clear
        view.textColor = UIColor.white
        view.selectedTextColor = UIColor.darkGray
        view.tagSelectedBackgroundColor = UIColor.white
        view.borderColor = UIColor.white
        view.alignment = .center
        view.borderWidth = 2
        view.marginX = 10
        view.marginY = 10
    }
}

enum TagListState {
    case single
    case multiple
}

class TagListDelegateHandler: TagListViewDelegate {
    
    var state: TagListState
    
    init(state: TagListState) {
        self.state = state
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        switch self.state {
        case .single:
            _ = sender.selectedTags().map({ $0.isSelected = false })
            tagView.isSelected = true
        case .multiple:
            tagView.isSelected = tagView.isSelected ? false : true
        }
    }
}
