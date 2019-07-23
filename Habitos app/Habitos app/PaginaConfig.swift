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

    @IBOutlet weak var timePicker: UIDatePicker!
    
 
    @IBOutlet weak var TextFieldRecompensa: UITextField!
    
    @IBOutlet weak var labelRecompensa: UILabel!
    
    @IBOutlet weak var SwitchState: UISwitch!
    @IBAction func Changehidden(_ sender: Any) {
        if SwitchState.isOn{
            labelRecompensa.isHidden = false
            TextFieldRecompensa.isHidden = false
        }
        else{
            labelRecompensa.isHidden = true
            TextFieldRecompensa.isHidden = true
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
    
    }
    
    
    //Notification
    var titulo = "Esta na hora do seu habito"
    var corpo = "Continua a desenvoler seu habito, voce consegue"
    var som = true
    var badge = false
    var intervaloDeTempo = 9

    func createNotifcation(){
        //puxar modo do habito do core data
        titulo = "nome do habito"
        corpo = "Continua a desenvoler seu habito, voce consegue"


        let repeatAction = UNNotificationAction(identifier: "Me lembre em uma hora", title: "Me lembre em uma hora")
        let okAction = UNNotificationAction(identifier: "ok", title: "ok", options: UNNotificationActionOptions.foreground)


        let category = UNNotificationCategory(identifier: "Options", actions: [okAction,repeatAction], intentIdentifiers: [],  options: [])


        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([category])

        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {

                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: self.titulo, arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: self.corpo, arguments: nil)
                if self.som{
                    content.sound = UNNotificationSound.default
                }
                content.categoryIdentifier = "Options"
                if self.badge{
                    content.badge = UIApplication.shared.applicationIconBadgeNumber  +  1 as NSNumber

                }
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current

                let components = Calendar.current.dateComponents([.hour,.minute], from: self.timePicker.date)


                dateComponents.hour = components.hour!
                dateComponents.minute = components.minute!


                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let request = UNNotificationRequest(identifier: "5seconds", content: content, trigger: trigger)

                let center = UNUserNotificationCenter.current()
                center.add(request) { (error : Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }

            } else {
                print("Impossível mandar notificação - permissão negada")
            }
        }

    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "Me lembre em uma hora"{
            titulo = "Agora e um horario melhor pro seu habito ?"
            corpo = "Um passo de cada vez te leva longe"
            intervaloDeTempo = 9


            let repeatAction = UNNotificationAction(identifier: "Me lembre em uma hora", title: "Me lembre em uma hora")
            let okAction = UNNotificationAction(identifier: "ok", title: "ok", options: UNNotificationActionOptions.foreground)


            let category = UNNotificationCategory(identifier: "Options", actions: [okAction,repeatAction], intentIdentifiers: [],  options: [])


            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.setNotificationCategories([category])

            notificationCenter.getNotificationSettings { (settings) in
                if settings.authorizationStatus == .authorized {

                    let content = UNMutableNotificationContent()
                    content.title = NSString.localizedUserNotificationString(forKey: self.titulo, arguments: nil)
                    content.body = NSString.localizedUserNotificationString(forKey: self.corpo, arguments: nil)
                    if self.som{
                        content.sound = UNNotificationSound.default
                    }
                    content.categoryIdentifier = "Options"
                    if self.badge{
                        content.badge = UIApplication.shared.applicationIconBadgeNumber  +  1 as NSNumber

                    }

                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(self.intervaloDeTempo), repeats: false)

                    let request = UNNotificationRequest(identifier: "5seconds", content: content, trigger: trigger)

                    let center = UNUserNotificationCenter.current()
                    center.add(request) { (error : Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }

                } else {
                    print("Impossível mandar notificação - permissão negada")
                }
            }


        }else{

        }
 }




}
