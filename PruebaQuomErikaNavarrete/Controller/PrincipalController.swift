//
//  PrincipalController.swift
//  PruebaQuomErikaNavarrete
//
//  Created by MacBookMBA1 on 12/07/23.
//

import UIKit

class PrincipalController: UIViewController {

    static var offset : Int = 0
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnleft: UIButton!
    @IBOutlet weak var itemComics: UICollectionView!
    var result = Root()
    var comics : [Comics] = []
    var id : Int = 0
    var text : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemComics.register(UINib(nibName: "ComicsCell", bundle: .main), forCellWithReuseIdentifier: "ComicsCell")
        itemComics.delegate = self
        itemComics.dataSource = self
        itemComics.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        UIupdate()
        
        if PrincipalController.offset == 0 {
            btnleft.isHidden = true
        }else{
            btnleft.isHidden = false
        }
    }
    
    func UIupdate(){
        btnRight.isHidden = false
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
        comics.removeAll()
        PrincipalViewModel.GetAll(String(Token.shared.GetTs()), Token.shared.GetApiKey(), Token.shared.GetHash()) { result, error in
            if let resultSource = result {
                for comic in resultSource.data!.results{
                    self.comics.append(comic)
                }
                
                DispatchQueue.main.async{
                    self.itemComics.reloadData()
                    self.btnRight.isEnabled = true
                    UIApplication.shared.windows.first?.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @IBAction func btnPrevious() {
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
        btnRight.isEnabled = false
        btnleft.isEnabled = false
        comics.removeAll()
        PrincipalController.offset -= 20
        PrincipalViewModel.GetAll(String(Token.shared.GetTs()), Token.shared.GetApiKey(), Token.shared.GetHash()) { result, error in
            if let resultSource = result {
                for comic in resultSource.data!.results{
                    self.comics.append(comic)
                }
            
                DispatchQueue.main.async {
                    self.itemComics.reloadData()
                    UIApplication.shared.windows.first?.isUserInteractionEnabled = true
                    self.btnRight.isEnabled = true
                    self.btnleft.isEnabled = true
                }
            }
        }
    }
    @IBAction func btnNext() {
        UIApplication.shared.windows.first?.isUserInteractionEnabled = false
        btnRight.isEnabled = false
        btnleft.isEnabled = false
        comics.removeAll()
        PrincipalController.offset += 20
        PrincipalViewModel.GetAll(String(Token.shared.GetTs()), Token.shared.GetApiKey(), Token.shared.GetHash()) { result, error in
            if let resultSource = result {
                for comic in resultSource.data!.results{
                    self.comics.append(comic)
                }
                
                DispatchQueue.main.async{
                    self.itemComics.reloadData()
                    self.btnRight.isEnabled = true
                    self.btnleft.isEnabled = true
                    UIApplication.shared.windows.first?.isUserInteractionEnabled = true
                }
            }
        }
    }
    
}

extension PrincipalController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemComics.dequeueReusableCell(withReuseIdentifier: "ComicsCell", for: indexPath) as! ComicsCell
        
        cell.lblNombre.text = comics[indexPath.row].title
        
        cell.cargandoComic.isHidden = false
        cell.cargandoComic.startAnimating()
        cell.imagenComic.isHidden = true
        
        if comics.isEmpty {
            cell.cargandoComic.isHidden = true
            cell.cargandoComic.stopAnimating()
            cell.imagenComic.isHidden = false
            cell.imagenComic.image = UIImage(named: "not_Image")
        }else{
            cell.cargandoComic.isHidden = true
            cell.cargandoComic.stopAnimating()
            cell.imagenComic.isHidden = false
            let url = URL(string: "\(comics[indexPath.row].thumbnail.path).\(comics[indexPath.row].thumbnail.extention)")
             cell.imagenComic.load(url: url!)
        }
    
        if PrincipalController.offset == 0 {
            btnleft.isHidden = true
        }else{
            btnleft.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if comics[indexPath.row].textObjects.isEmpty {
            text = "There is no description of the selected comic"
        }else{
            text = comics[indexPath.row].textObjects[0].text
        }
        id = comics[indexPath.row].id
        
        performSegue(withIdentifier: "DetalleComic", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleComic"{
            let detalleComics = segue.destination as! DetalleController
            detalleComics.id = self.id
            detalleComics.text = self.text
        }
    }
    
}
