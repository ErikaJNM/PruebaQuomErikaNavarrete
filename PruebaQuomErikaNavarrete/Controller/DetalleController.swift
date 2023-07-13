//
//  DetalleController.swift
//  PruebaQuomErikaNavarrete
//
//  Created by MacBookMBA1 on 12/07/23.
//

import UIKit

class DetalleController: UIViewController {
    @IBOutlet weak var descripcionComic: UITextView!
    
    @IBOutlet weak var imagenComic: UIImageView!
    @IBOutlet weak var lblNombreComic: UILabel!
    @IBOutlet weak var itemCreadores: UICollectionView!
    var id : Int = 0
    var result = Root()
    var escritores : [Items] = []
    var text : String = ""
    override func viewDidLoad() {
        
        itemCreadores.register(UINib(nibName: "CreadoresCell", bundle: .main), forCellWithReuseIdentifier: "CreadoresCell")
        itemCreadores.delegate = self
        itemCreadores.dataSource = self
        super.viewDidLoad()
        
        UIUpdate()
    }
    
    @IBAction func btnRegresar() {
        dismiss(animated: false)
    }
    
    func UIUpdate(){
        escritores.removeAll()
        PrincipalViewModel.GetById(String(Token.shared.GetTs()), Token.shared.GetApiKey(), Token.shared.GetHash(), Id: id) { result, error in
            if let resultSource = result {
                
                for cradores in resultSource.data!.results[0].creators.items{
                    self.escritores.append(cradores)
                }
                
                DispatchQueue.main.async {
                    self.lblNombreComic.text = resultSource.data?.results[0].title
                    let url = URL(string: "\(resultSource.data!.results[0].thumbnail.path).\(resultSource.data!.results[0].thumbnail.extention)")
                    self.imagenComic.load(url: url!)
                    self.itemCreadores.reloadData()
                    self.descripcionComic.text = self.text
                }
                
            }
        }
    }
}

extension DetalleController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return escritores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCreadores.dequeueReusableCell(withReuseIdentifier: "CreadoresCell", for: indexPath) as! CreadoresCell
        cell.lblNombreCreador.text = escritores[indexPath.row].name
        cell.lblCargo.text = escritores[indexPath.row].role
        
        return cell
    }
    
    
}
