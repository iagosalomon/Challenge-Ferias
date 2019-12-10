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
import CoreData

class PaginaPrincipal: UIViewController {
    
    var contex : NSManagedObjectContext?
    
    let fraseinicioarray = [
        
                            "\"O lugar que ocupamos é menos importante do que aquele para o qual nos dirigimos.\"",
                            "\"A felicidade só é verdadeira se for compartilhada.\"",
                            "\"É nas experiências, nas lembranças, na grande e triunfante alegria de viver na mais ampla plenitude que o verdadeiro sentido é encontrado.\"",
                            "\"Assim como uma vela acende outra e pode acender milhares de outras velas, um coração ilumina outro e pode iluminar milhares de outros corações.\"",
                            "\"A sabedoria com as coisas da vida não consiste, ao que me parece, em saber o que é preciso fazer, mas em saber o que é preciso fazer antes e o que fazer depois.\"",
                            "\"Quem avança confiante na direção de seus sonhos e se empenha em viver a vida que imaginou para si encontra um sucesso inesperado em seu dia-a-dia.\"",
                            "\"A vida não examinada não vale a pena ser vivida.\"",
                            "\"Tente mover o mundo - o primeiro passo será mover a si mesmo.\"",
                            "\"O mundo é um livro, e quem fica sentado em casa lê somente uma página.\"",
                            "\"Grandes atos são feitos de pequenas atitudes.\"",
                            
                            "\"Você só irá falhar quando desistir de tentar\"",
                            "\"Tudo o que temos de decidir é o que fazer com o tempo que nos é dado.\"",
                            "\"Uma viagem de mil milhas começa com um simples passo\"",
                            "\"Se vale a pena fazer algo, vale a pena fazê-lo bem\"",
                            "\"O homem que moveu a montanha começou por retirar as menores pedras\""
                            
                            
                            
    
                            ]
    
    
    
    
    
    let citacaoinicioarray = [" - Liev Nikoláievich Tolstói"," - Christopher McCandless"," - Christopher McCandless"," - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Henry David Thoreau"," - Henry David Thoreau"," - Sócrates"," - Platão"," - Santo Agostinho","-Albert Einstein","-Gandalf The Grey","-Provérbio Chinês","-Provérbio Chinês","-Provérbio Chinês"]
    
    
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
    @IBOutlet weak var FraseInspiradora: UILabel!
    @IBOutlet weak var autorFrase: UILabel!
    
    
    @IBOutlet weak var Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewLiquido.layer.cornerRadius = 134.5
        startDeviceMotion()
        calibrarPagina()
        let seletorFrase = Int.random(in: 0 ..< fraseinicioarray.count)
        FraseInspiradora.text = fraseinicioarray[seletorFrase]
        autorFrase.text = citacaoinicioarray[seletorFrase]
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
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        let hj = df.string(from: Date())
        
        
        if hj == UserDefaults.standard.string(forKey: "DataUsada") {
            return
        }
        
        if IncrementarHabito <= 27{
            IncrementarHabito += 1
            if IncrementarHabito <= 28{
                porcentagemDoHabito += 1
                AumentarBola(Incrementar: IncrementarHabito)
                
                UserDefaults.standard.set(IncrementarHabito, forKey: "IncrementarHabito")
                UserDefaults.standard.set(IncrementarHabito, forKey: "porcentagemDoHabito")
                UserDefaults.standard.set(hj, forKey: "DataUsada")
                
                var  temRecompensa =  UserDefaults.standard.bool(forKey: "temrecompensa")
                if  temRecompensa{
                    createNotifcation()
                }
                
            }
            if IncrementarHabito == 28{
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                SalvarCoreData(nomeHabito: UserDefaults.standard.string(forKey: "nomeHabito")! , dataHabito: hj)
                
            }
        }
    }
    
    @IBAction func ShowLabel(_ sender: Any) {
        if IncrementarHabito < 28{
            ButtonPorcentagem.setTitle("\(String(format: "%.f",round(porcentagem * porcentagemDoHabito)))%", for: .normal)
        }else{
            ButtonPorcentagem.setTitle("Parabéns", for: .normal)
            //salvar habito
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
        var titulo = UserDefaults.standard.string(forKey: nomeRecompensa!)
        var corpo = "Você conseguiu comprir seu objetivo hoje, aproveite sua recompensa"
        
        
        let identificador = "identifier\(Int.random(in: 0..<6))"
        self.appDelegate?.enviarlembrete(titulo!,"" , corpo, identificador, 3600)
        
        
    }
    
    func AumentarBola(Incrementar: Int) {
        
        UIView.animate(withDuration: 0.5) {
            self.PorcentagemBola.constant = CGFloat(23 + 8 * Incrementar)
            self.view.layoutIfNeeded()
        }
        
    }
    
    func SalvarCoreData(nomeHabito : String,dataHabito : String ){
        var habito = NSEntityDescription.insertNewObject(forEntityName: "Habito", into: contex!) as! Habito
        habito.nome_habito = nomeHabito
        habito.data_completo = dataHabito
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.saveContext()

    }
}
