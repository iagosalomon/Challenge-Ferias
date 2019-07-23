//
//  PaginaCriarHabito.swift
//  Habitos app
//
//  Created by iago salomon on 18/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit

class PaginaCriarHabito: UIViewController {
    
    let persistenceManager: PersistenceManager
    
    init(persistenceManager : PersistenceManager){
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var tecladoCerto = false
    @IBAction func tecladoBaixo(_ sender: Any) {
        tecladoCerto = true
        print(tecladoCerto)
    }
    
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textFieldNomeHabito: UITextField!
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var recompensaLabel: UILabel!
    @IBOutlet weak var recompensaTextFiel: UITextField!
    
    
    
    @IBAction func Switch(_ sender: Any) {
        if switchState.isOn{
            recompensaLabel.isHidden = false
            recompensaTextFiel.isHidden = false
        }
        else{
            recompensaLabel.isHidden = true
            recompensaTextFiel.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.setValue(UIColor.white, forKey: "textColor")
        
        

        //escuta o programa para avisar quando esses eventos acontecem
        //Quando o teclado ira aparecer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name:UIResponder.keyboardWillShowNotification, object: nil)
        //Quando o teclado ira desaparecer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name:UIResponder.keyboardWillHideNotification, object: nil)
        //Quando o teclado ir mudar de frame
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    //Funcao que esconde o teclado quando o usuario aperta retun no teclado
    @objc func returnpressed (){
        textFieldNomeHabito.resignFirstResponder()
        recompensaTextFiel.resignFirstResponder()
        tecladoCerto = false
        
        
        
        
    }
    
    //Funcao que fecha o teclado quando o usuario toca em uma area fora do teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldNomeHabito.resignFirstResponder()
        recompensaTextFiel.resignFirstResponder()
        tecladoCerto = false
    }
    
    
    
    //Funcao que anima a tela quando o teclado eh aberto o fechado
    //Esta funcao eh chamada toda a vez que o avisar que os eventos que determinamos estiverem acontecendo
    @objc func keyboardWillChange(notification: Notification){
        
        //Funcao que pega o tamanho do teclado
        guard let keyboardRect = ( notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        //Sobe a tela se o teclado estiver abrindo e desce a tela quando ele estiver fechando
        if tecladoCerto{
        if (notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification ){
            view.frame.origin.y = -keyboardRect.height
        }else{
            view.frame.origin.y = 0
        }
        }
    }
    
    @IBAction func CriarHabito(_ sender: Any) {
        //Salvar os habitos no cor data aqui
        persistenceManager.save()
        
        
        //-----------------------------------
        
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "PaginaPrincipal") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
    }
    
}
