//
//  ThumbCollectionViewCell.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import UIKit
import Kingfisher

class ThumbCollectionViewCell: UICollectionViewCell {

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
        //TODO: Set kingfisher image
        self.data = data
        
        let urlString: String = data.imageUrl ?? ""
        let url = URL(string: urlString)
        
        self.imgMovie.loadFrom(url: url!)
        self.imgMovie.contentMode = .scaleAspectFill
        self.lblTitle.text = data.title
    }

}
