//
//  ViewController.swift
//  CalcularDataAndre
//
//  Created by user151729 on 3/26/19.
//  Copyright © 2019 user151729. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtData: UITextField!
    @IBOutlet weak var btnCalculaIdade: UIButton!
    @IBOutlet weak var lblResultado: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func btnClick(_ sender: Any) {
        do {
            let age = try CalculateAge(from: txtData.text ?? "", dateFormat: "dd/MM/yyyy")
         lblResultado.text = String(age)
        }
        catch AgeError.emptyText{
            lblResultado.text = "Texto em Branco"
        }
        catch AgeError.futureBirthday{
            lblResultado.text = "Data Futura"
        }
        catch AgeError.invalidFormat{
            lblResultado.text = "Formato Inválido"
        }
        catch AgeError.invalidDate{
            lblResultado.text = "Data Inválida"
        }
        catch {
            lblResultado.text = "Erro desconhecido"
        }
    }
    
    private func CalculateAge(from text: String, dateFormat: String	) throws -> Int{
        if text.isEmpty{
            throw AgeError.emptyText
        }
        
        if text.count != dateFormat.count{
            throw AgeError.invalidFormat
        }
    
        let FormatDate = DateFormatter()
        FormatDate.dateFormat =  dateFormat
        
        let data = FormatDate.date(from: text)
        
        if data == nil {
            throw AgeError.invalidDate
        }
        
        if data! > Date(){
            throw AgeError.futureBirthday
        }
        
        let age = Calendar.current.dateComponents([Calendar.Component.year], from: data!, to: Date()).year
        
        if age == nil{
            throw AgeError.unknown
        }
        
        return age!
    }
}

enum AgeError: Error {
    case emptyText
    case invalidFormat
    case invalidDate
    case futureBirthday
    case unknown
}

