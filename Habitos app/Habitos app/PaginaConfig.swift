//
//  PaginaConfig.swift
//  Habitos app
//
//  Created by iago salomon on 18/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit
import  UserNotifications

class PaginaConfig: UIViewController {
    var window: UIWindow?
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate

    @IBOutlet weak var timePicker: UIDatePicker!
    
 
    @IBOutlet weak var TextFieldRecompensa: UITextField!
    
    @IBOutlet weak var labelRecompensa: UILabel!
    
    @IBOutlet weak var SwitchState: UISwitch!
    @IBAction func Changehidden(_ sender: Any) {
        if SwitchState.isOn{
            labelRecompensa.isHidden = false
            TextFieldRecompensa.isHidden = false
            UserDefaults.standard.set(true, forKey: "temrecompensa")
        }
        else{
            labelRecompensa.isHidden = true
            TextFieldRecompensa.isHidden = true
            UserDefaults.standard.set(false, forKey: "temrecompensa")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.setValue(UIColor.white, forKey: "textColor")

        // Do any additional setup after loading the view.
        
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
        TextFieldRecompensa.resignFirstResponder()
        
        
        
    }
    
    //Funcao que fecha o teclado quando o usuario toca em uma area fora do teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TextFieldRecompensa.resignFirstResponder()
    }
    
    
    
    //Funcao que anima a tela quando o teclado eh aberto o fechado
    //Esta funcao eh chamada toda a vez que o avisar que os eventos que determinamos estiverem acontecendo
    @objc func keyboardWillChange(notification: Notification){
        
        //Funcao que pega o tamanho do teclado
        guard let keyboardRect = ( notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        //Sobe a tela se o teclado estiver abrindo e desce a tela quando ele estiver fechando
        if (notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification ){
            view.frame.origin.y = -keyboardRect.height
        }else{
            view.frame.origin.y = 0
        }
        
    }
    
    @IBAction func Botao_salvar(_ sender: Any) {
        
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    createNotifcation()
    UserDefaults.standard.set(TextFieldRecompensa.text, forKey: "nomeRecompensa")
    aviso(self)
    }
    
    
 func aviso(_ sender: Any) {
        
        let aviso : UIAlertController = UIAlertController(title: "Salvo", message: "As informaçōes do seu habito foram atualizadas", preferredStyle:.alert)
        let OkAction = UIAlertAction(title: "OK", style: .default)
        aviso.addAction (OkAction)
        
        
        var alertWindow: UIWindow!
        alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        alertWindow.tintColor = UIColor.black
        alertWindow.rootViewController = UIViewController.init()
        alertWindow.windowLevel  = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(aviso, animated: true)
        
        
        
        
    }
    func avisoDeletar(_ sender: Any) {
        
        let aviso : UIAlertController = UIAlertController(title: "Deletar Habito", message: "Voce realmete deseja deletar seu habito e começar um novo ?", preferredStyle:.alert)
//        let OkAction = UIAlertAction(title: "OK", style: .default)
        let CancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let OkAction =  UIAlertAction(title: "Apagar",
                                  style: .destructive,
                                  handler: {action in self.ApagarTudo()})
        aviso.addAction (OkAction)
        aviso.addAction (CancelAction)
        
        
        var alertWindow: UIWindow!
        alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        alertWindow.tintColor = UIColor.black
        alertWindow.rootViewController = UIViewController.init()
        alertWindow.windowLevel  = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(aviso, animated: true)
        
        
        
        
    }
    
    @IBAction func apagarHabito(_ sender: Any) {
        avisoDeletar(self)
        
    }
    
    
    func ApagarTudo(){
        //reset das variaveis basicas do app
        UserDefaults.standard.set("", forKey: "nomeHabito")
        UserDefaults.standard.set(false, forKey: "temhabito")
        UserDefaults.standard.set(false, forKey: "temrecompensa")
        UserDefaults.standard.set("", forKey: "nomeRecompensa")
        
        //reset variaveis da pagina principal
        UserDefaults.standard.set(0, forKey: "IncrementarHabito")
        UserDefaults.standard.set(0.0, forKey: "porcentagemDoHabito")
        
        //ir para a pagina de criacao de habito
        
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = mainStoryboardIpad.instantiateViewController(withIdentifier: "criacaodeHabito") as! UINavigationController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = nav
    }
    
    // ---------------notification-------------------
    
    var titulo = "Esta na hora do seu habito"
    var corpo = "Continua a desenvoler seu habito, voce consegue"
    var som = true
    var badge = false
    
    
    func createNotifcation(){
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: self.timePicker.date)
        
        
        dateComponents.hour = components.hour!
        dateComponents.minute = components.minute!
        titulo = "testzera"
        corpo = "Continua a desenvoler seu habito, voce consegue"
        
        
        //O identificador serve para o caso de queremos identificar uma notificação especifica
        let identificador = "identifier\(Int.random(in: 0..<6))"
        self.appDelegate?.enviarNotificacao(titulo, "", corpo, identificador, dateComponents)
        
        
    }
    

    func fizhabitohj(){
        
    }



}
