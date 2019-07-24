//
//  PaginaPrincipal.swift
//  Habitos app
//
//  Created by iago salomon on 18/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit
import CoreMotion
import UserNotifications

class PaginaPrincipal: UIViewController {
    // variaveis da notificacao
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    
    var porcentagemDoHabito: Double = UserDefaults.standard.double(forKey: "porcentagemDoHabito")
    var IncrementarHabito = UserDefaults.standard.integer(forKey: "IncrementarHabito")
    
    var porcentagem: Double = 100/28
    @IBOutlet weak var viewLiquido: UIView!
    @IBOutlet weak var viewPorcent: UIView!
    
    @IBOutlet weak var ButtonPorcentagem: UIButton!
    
    @IBOutlet weak var PorcentagemBola: NSLayoutConstraint!
    
    
    
    var referenceAttitude:CMAttitude?
    
    let motion = CMMotionManager()
    
    
    @IBOutlet weak var Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLiquido.layer.cornerRadius = 134.5
        startDeviceMotion()
        calibrarPagina()
        // Do any additional setup after loading the view.
    }
    //Codigo Omella
    func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            //Frequencia de atualização dos sensores definida em segundos - no caso, 60 vezes por segundo
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            //A partir da chamada desta função, o objeto motion passa a conter valores atualizados dos sensores; o parâmetro representa a referência para cálculo de orientação do dispositivo
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            //Um Timer é configurado para executar um bloco de código 60 vezes por segundo - a mesma frequência das atualizações dos dados de sensores. Neste bloco manipulamos as informações mais recentes para atualizar a interface.
            var timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true,
                              block: { (timer) in
                                if let data = self.motion.deviceMotion {
                                    var relativeAttitude = data.attitude
                                    if let ref = self.referenceAttitude{
                                        //Esta função faz a orientação do dispositivo ser calculado com relação à orientação de referência passada
                                        relativeAttitude.multiply(byInverseOf: ref)
                                    }
                                    
                                    let x = relativeAttitude.pitch
                                    let y = relativeAttitude.roll
                                    let z = relativeAttitude
                                    
                                    
                                    let gravity = data.gravity
                                    //Um pouco de matemágica para rotacionar o background de acordo com a orientação do dispositivo - neste caso, usando o vetor da gravidade para este cálculo
                                    self.viewLiquido.transform = CGAffineTransform(rotationAngle: CGFloat(atan2(gravity.x, gravity.y) - .pi))
                                }
            })
            
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
        }


}
    @IBAction func AumentarPorcentagem(_ sender: Any) {
        if IncrementarHabito <= 27{
        IncrementarHabito += 1
        if IncrementarHabito <= 28{
        porcentagemDoHabito += 1
        PorcentagemBola.constant = CGFloat(23 + 8 * IncrementarHabito)
            
        UserDefaults.standard.set(IncrementarHabito, forKey: "IncrementarHabito")
        UserDefaults.standard.set(IncrementarHabito, forKey: "porcentagemDoHabito")
            
        var  temRecompensa =  UserDefaults.standard.bool(forKey: "temrecompensa")
            if  temRecompensa{
        createNotifcation()
            }
    
        }
        if IncrementarHabito == 28{
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        }
        }
    }
    
    @IBAction func ShowLabel(_ sender: Any) {
        if IncrementarHabito < 28{
        ButtonPorcentagem.setTitle("\(String(format: "%.f",round(porcentagem * porcentagemDoHabito)))%", for: .normal)
        }else{
            ButtonPorcentagem.setTitle("Parabens", for: .normal)
        }
    }
    
    @IBAction func Hidelabel(_ sender: Any) {
        ButtonPorcentagem.setTitle("", for: .normal)
    }
    
    
    func calibrarPagina(){
        PorcentagemBola.constant = CGFloat(23 + 8 * IncrementarHabito)
        self.navigationItem.title = UserDefaults.standard.string(forKey: "nomeHabito")
    
    }

    
    func createNotifcation(){
        var nomeRecompensa = UserDefaults.standard.string(forKey: "nomeRecompensa")
        var titulo = "\(String(describing: nomeRecompensa!))"
        var corpo = "Voce conseguiu comprir seu objetivo hoje, aproveite sua recompensa"
        
        
        let identificador = "identifier\(Int.random(in: 0..<6))"
        self.appDelegate?.enviarlembrete(titulo,"" , corpo, identificador, 3600)
        
        
    }
}
