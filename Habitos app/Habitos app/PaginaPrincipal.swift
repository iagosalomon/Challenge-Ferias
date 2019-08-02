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
    
    let fraseinicioarray = ["\"Compreender a dificuldade dos outros é perdoar.\"",
                            "\"Os homens não têm muito respeito pelos outros porque têm pouco até por sí próprios.\"",
                            "\"O lugar que ocupamos é menos importante do que aquele para o qual nos dirigimos.\"",
                            "\"A felicidade só é verdadeira se for compartilhada.\"",
                            "\"Algumas pessoas sentem-se como se não merecessem amar. Escapando em silêncio em seus espaços vazios, tentando fechar as lacunas do passado.\"",
                            "\"É nas experiências, nas lembranças, na grande e triunfante alegria de viver na mais ampla plenitude que o verdadeiro sentido é encontrado.\"",
                            "\"Nada é mais maléfico para o espirito aventureiro do homem que um futuro seguro.\"",
                            "\"A alegria de fazer o bem é a única felicidade verdadeira.\"",
                            "\"Os que se chamam grandes homens são etiquetas que dão o seu nome aos acontecimentos históricos; e assim como as etiquetas, não têm relação com esses acontecimentos.\"",
                            "\"Assim como uma vela acende outra e pode acender milhares de outras velas, um coração ilumina outro e pode iluminar milhares de outros corações.\"",
                            "\"A sabedoria com as coisas da vida não consiste, ao que me parece, em saber o que é preciso fazer, mas em saber o que é preciso fazer antes e o que fazer depois.\"",
                            "\"Não alcançamos a liberdade buscando a liberdade, mas sim a verdade. A liberdade não é um fim, mas uma consequência.\"",
                            "\"Se você já construiu castelos no ar, não tenha vergonha deles. Estão onde devem estar. Agora, dê-lhes alicerces.\"",
                            "\"Para cada mil homens dedicados a cortar as folhas do mal, há apenas um atacando as raízes.\"",
                            "\"São precisas duas pessoas para falar a verdade, uma para falar, e outra para ouvir.\"",
                            "\"Cuidado com todas as atividades que requeiram roupas novas.\"",
                            "\"A bondade é o único investimento que nunca vai à falência.\"",
                            "\"É tão difícil observar-se a si mesmo quanto olhar para trás sem se voltar.\"",
                            "\"Quem avança confiante na direção de seus sonhos e se empenha em viver a vida que imaginou para si encontra um sucesso inesperado em seu dia-a-dia.\"",
                            "\"Fazer todos os dias um bom dia, essa é a mais elevada das artes.\"",
                            "\"O homem mais rico é aquele cujos prazeres são mais baratos.\"",
                            "\"Se queres um escudo impenetrável, permanece dentro de ti mesmo.\"",
                            "\"A vida não examinada não vale a pena ser vivida.\"",
                            "\"Tente mover o mundo - o primeiro passo será mover a si mesmo.\"",
                            "\"O mundo é um livro, e quem fica sentado em casa lê somente uma página.\"",
                            "\"Tomei a decisão de fingir que todas as coisas que até então haviam entrado na minha mente não eram mais verdadeiras do que as ilusões dos meus sonhos.\"",
                            "\"A filosofia que cultivo não é nem tão bárbara nem tão inacessível que rejeite as paixões; pelo contrário, é só nelas que reside a doçura e felicidade da vida.\"",
                            "\"Não há nada que dominemos inteiramente a não ser os nossos pensamentos.\"",
                            "\"Preocupe-se com a aprovação das pessoas e você será prisioneiro de si mesmo.\"",
                            "\"Grandes atos são feitos de pequenas atitudes.\"",
                            "\"Você só ira falhar quando desistir de tentar\""]
    
    
    
    
    
    let citacaoinicioarray = [" - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Christopher McCandless"," - Christopher McCandless"," - Christopher McCandless"," - Christopher McCandless"," - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Liev Nikoláievich Tolstói"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Henry David Thoreau"," - Sócrates"," - Platão"," - Santo Agostinho"," - René Descartes", " - René Descartes"," - René Descartes"," - Lao Zi"," - Lao Zi","Albert Einstein"]
    
    
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
            ButtonPorcentagem.setTitle("Parabens", for: .normal)
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
        var corpo = "Voce conseguiu comprir seu objetivo hoje, aproveite sua recompensa"
        
        
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
