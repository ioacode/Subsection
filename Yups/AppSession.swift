//
//  AppSession.swift
//  Yups
//
//  Created by balcomm on 05/07/20.
//  Copyright © 2020 balcomm. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class AppSession {
    private var sessionMenu: UserDefaults
    private var session: UserDefaults
    private var sessionSub: UserDefaults
     
    let KEY_DATA = "data"
    let KEY_ISLOGIN = "isLogin"
    
    let KEY_SUBDATA = "subdata"
    let KEY_SUBISLOGIN = "issubLogin"
    
    let KEY_MENUDATA = "menudata"
    let KEY_MENUISLOGIN = "menuIslogin"
    
    
    init() {
        session = UserDefaults.standard
        sessionSub = UserDefaults.standard
        sessionMenu = UserDefaults.standard
    }
    
    func createSessionMenu(value: String, key: String){
        self.session.set(true, forKey: key)
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    func updateSessionMenu(value: String, key: String){
        self.session.set(true, forKey: key)
        KeychainWrapper.standard.removeObject(forKey: key)
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    func updatevalueMenu(key: String, position: String, value: String){
        
    }
    
    func getSessionMenu(key: String)->String{
        return KeychainWrapper.standard.string(forKey: key)!
    }
     
    func destroySessionMenu(key: String){
        self.session.set(false, forKey: key)
        KeychainWrapper.standard.removeObject(forKey: key)
    }
    
    func ismenuLogin(key: String)-> Bool{
        if (session.object(forKey: key) == nil){
            return false
        }else{
            return session.bool(forKey: key)
        }
    }
    
    func createSessionSubmenu(value: String, key: String){
        self.sessionSub.set(true, forKey: "menu"+key)
        KeychainWrapper.standard.set(value, forKey: "menu"+key)
    }
       
    func updateSessionSubmenu(value: String, key: String){
        self.sessionSub.set(true, forKey: "menu"+key)
        KeychainWrapper.standard.removeObject(forKey: "menu"+key)
        KeychainWrapper.standard.set(value, forKey: "menu"+key)
    }
       
    func getSessionSubmenu(key: String)->String{
        return KeychainWrapper.standard.string(forKey: "menu"+key)!
    }
       
    func destroySessionSubmenu(key: String){
        self.session.set(false, forKey: "menu"+key)
        KeychainWrapper.standard.removeObject(forKey: "menu"+key)
    }
    
    func issubmenuLogin(key: String)-> Bool{
        if (session.object(forKey: "menu"+key) == nil){
            return false
        }else{
            return session.bool(forKey: "menu"+key)
        }
    }
    
    func createSession(valueData: String){
        self.session.set(true, forKey: KEY_ISLOGIN)
        KeychainWrapper.standard.set(valueData, forKey: KEY_DATA)
    }
    
    func updateSession(valueData: String){
        self.session.set(true, forKey: KEY_ISLOGIN)
        KeychainWrapper.standard.removeObject(forKey: KEY_DATA)
        KeychainWrapper.standard.set(valueData, forKey: KEY_DATA)
    }
    
    func getSession()->String{
        return KeychainWrapper.standard.string(forKey: KEY_DATA)!
    }
    
    func destroySession(){
        self.session.set(false, forKey: KEY_ISLOGIN)
        KeychainWrapper.standard.removeObject(forKey: KEY_DATA)
    }
    
   
    func isLogin()-> Bool{
        if (session.object(forKey: KEY_ISLOGIN) == nil){
            return false
        }else{
            return session.bool(forKey: KEY_ISLOGIN)
        }
    }
}
