//
//  AppDelegate.swift
//  Habitos app
//
//  Created by iago salomon on 12/07/19.
//  Copyright © 2019 iago salomon. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let centroDeNotificacao = UNUserNotificationCenter.current()
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Para usar podermos usar o protocolo UNUserNotificationCenterDelegate
        //na extensão mais abaixo
        
        centroDeNotificacao.delegate = self
        
        //Aqui pedimos três coisas ao usuário, para a notificação gerar um alerta
        //com som e um pontinho vermelhor junto ao logo da nossa aplicação
        let opcoes: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        //Método que pede permissão ao usuáio
        centroDeNotificacao.requestAuthorization(options: opcoes) {
            (foiPermitido, error) in
            if !foiPermitido {
                print("O usúario não permitiu, não podemos enviar notificacão")
            }
        }
        
        
        
        
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("Notifications not allowed by user")
            }
        }
        
        
        
        let apphasbeenopen = UserDefaults.standard.bool(forKey: "launchedBefore")
        

        if  apphasbeenopen{
        //vai pra pagaina principal
        let temHabito = UserDefaults.standard.bool(forKey: "temhabito")
            if temHabito{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "PaginaPrincipal")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
            }else{
                //vai pra pagina de criacao de habito
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "criacaodeHabito")
                
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
            
            
            
        
        }else{
            //So roda na primeira vez que o app roda 
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            //setup das variaveis basicas do app
            UserDefaults.standard.set("", forKey: "nomeHabito")
            UserDefaults.standard.set(false, forKey: "temhabito")
            UserDefaults.standard.set(false, forKey: "temrecompensa")
            UserDefaults.standard.set("", forKey: "nomeRecompensa")
            
            //set variaveis da pagina principal
            UserDefaults.standard.set(0, forKey: "IncrementarHabito")
            UserDefaults.standard.set(0.0, forKey: "porcentagemDoHabito")
            
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Habitos_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    

    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("save succesfully")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func enviarNotificacao(_ titulo:String, _ subtitulo:String, _ mensagem:String, _ identificador:String, _ data:DateComponents) {
        
        //Essa instancia de classe é necessária para criar o corpo da notificação
        let contexto = UNMutableNotificationContent()
        
        //Criando corpo da notificação
        contexto.title = titulo
        contexto.subtitle = subtitulo
        contexto.body = mensagem
        contexto.sound = UNNotificationSound.default
        //Badge é a o alerta vermelho que fica no icone do aplicativo quando há notificações e ela pode ser incrementada
        contexto.badge = 0
        contexto.categoryIdentifier = identificador
        
        
        //Colocando a imgem de fundo
        let nomeDaImagem = "Icone-logo"
        //Aqui verificamos se a mensagem realmente existe, caso ela não exista ele para a função a retornando.
        if let imageURL = Bundle.main.url(forResource: nomeDaImagem, withExtension: "png") {
            //Anexando a imagem
            let anexo = try! UNNotificationAttachment(identifier: nomeDaImagem, url: imageURL, options: .none)
            contexto.attachments = [anexo]
        }
        
        
        
        //Criando os botões de ações
        let acaoDeSoneca = UNNotificationAction(identifier: "Repetir", title: "Repetir", options: [])
        let acaoDeDesligar = UNNotificationAction(identifier: "Desligar", title: "Desligar", options: [.destructive])
        let categoria = UNNotificationCategory(identifier: identificador,
                                               actions: [acaoDeSoneca, acaoDeDesligar],
                                               intentIdentifiers: [],
                                               options: [])
        
        
        //Adicionando as ações ao nosso centro de notificações
        centroDeNotificacao.setNotificationCategories([categoria])
        
        //Criando a requisição
        let trigger = UNCalendarNotificationTrigger(dateMatching: data, repeats: true)
        let requisicao = UNNotificationRequest(identifier: identificador, content: contexto, trigger: trigger)
        
        //Adicionando a requisição ao nosso centro de notificações
        centroDeNotificacao.add(requisicao) { (error) in
            if let error = error {
                print("Deu ruim: \(error.localizedDescription)")
            }
        }
        
        
        
        
    }
    
    func enviarlembrete(_ titulo:String, _ subtitulo:String, _ mensagem:String, _ identificador:String, _ tempo:TimeInterval) {
        
        //Essa instancia de classe é necessária para criar o corpo da notificação
        let contexto = UNMutableNotificationContent()
        
        //Criando corpo da notificação
        contexto.title = titulo
        contexto.subtitle = subtitulo
        contexto.body = mensagem
        contexto.sound = UNNotificationSound.default
        //Badge é a o alerta vermelho que fica no icone do aplicativo quando há notificações e ela pode ser incrementada
        contexto.badge = 0
        contexto.categoryIdentifier = identificador
        
        
        //Colocando a imgem de fundo
        let nomeDaImagem = "Icone-logo"
        //Aqui verificamos se a mensagem realmente existe, caso ela não exista ele para a função a retornando.
        if let imageURL = Bundle.main.url(forResource: nomeDaImagem, withExtension: "png") {
            //Anexando a imagem
            let anexo = try! UNNotificationAttachment(identifier: nomeDaImagem, url: imageURL, options: .none)
            contexto.attachments = [anexo]
        }
        
        
        
        //Criando os botões de ações
        let acaoDeSoneca = UNNotificationAction(identifier: "Repetir", title: "Me avise em uma hora", options: [])
        let acaoDeDesligar = UNNotificationAction(identifier: "Desligar", title: "ok", options: [.destructive])
        let categoria = UNNotificationCategory(identifier: identificador,
                                               actions: [acaoDeSoneca, acaoDeDesligar],
                                               intentIdentifiers: [],
                                               options: [])
        
        
        //Adicionando as ações ao nosso centro de notificações
        centroDeNotificacao.setNotificationCategories([categoria])
        
        //Criando a requisição
        let gatilho = UNTimeIntervalNotificationTrigger(timeInterval: tempo, repeats: false)
        let requisicao = UNNotificationRequest(identifier: identificador, content: contexto, trigger: gatilho)
        
        //Adicionando a requisição ao nosso centro de notificações
        centroDeNotificacao.add(requisicao) { (error) in
            if let error = error {
                print("Deu ruim: \(error.localizedDescription)")
            }
        }
        
        
        
        
    }
    
    //Quando a notificacao é enviada e o aplicativo está aberto
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        //Aqui definimos que a notificação deve gerar um alerta com som, mas sem o badge
        completionHandler([.alert,.sound])
    }
    
    
    //Quando a notificacao é respondida
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //Chamando identificador de ações
        let identificador = response.actionIdentifier
        
        //Pegando a resposta da notificação pela resposta da ação
        if identificador == "Repetir"{
            print("Repetir")
            //recriar notificacao
            enviarlembrete("Titulo", "", "Corpo", "identificador", 3600)
        }
        else if identificador == "Desligar" {
            print("Desligar")
        }
        
        //Não há retorno
        completionHandler()
    }
}




