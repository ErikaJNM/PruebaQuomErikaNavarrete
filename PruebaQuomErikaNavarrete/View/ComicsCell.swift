//
//  ComicsCell.swift
//  PruebaQuomErikaNavarrete
//
//  Created by MacBookMBA1 on 12/07/23.
//

import UIKit

class ComicsCell: UICollectionViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imagenComic: UIImageView!
    @IBOutlet weak var cargandoComic: UIActivityIndicatorView!
    
    @IBOutlet weak var lblNombre: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imagenComic.image = nil
    }
}
