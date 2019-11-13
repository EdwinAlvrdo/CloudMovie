//
//  PosterCollectionViewCell.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import UIKit
import Kingfisher

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var data: MoviesDTO! {
        didSet {}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(_ data: MoviesDTO){
        self.data = data
        let url = URL(string: data.imageUrl ?? "")
        self.imgMovie.loadFrom(url: url!)
        self.lblTitle.text = data.title
    }

}
