//
//  LYCLocalization.swift
//  LYCLocalization
//
//  Created by  Ismael Liang on 21/09/16.
//  Copyright © 2016 Yuchen Liang. All rights reserved.
//
//
//
//

import Foundation


final class LYCLocalization {

    ///
    static let defaultTool = LYCLocalization() // 单例
    
    ///
    private let userLangKey = "userLangKey" // UserDefaults 中的 key值
    
    private var default_lang_key: String // 默认语言Key
    private var local_dict_all: Dictionary< String, String > // 支持的语言Dict
    
    
    ///
    var bundle: Bundle?
    
    
    var curLang: String { // 计算属性
    
        // get
        get {
            
            let userLangObj = UserDefaults.standard.value(forKey: userLangKey)
            var userLang = (userLangObj != nil) ? userLangObj as! String : ""
            
            
            if userLang.isEmpty {
            
                let languages: Array< String > = UserDefaults.standard.value(forKey: "AppleLanguages") as! Array<String>
                
                userLang = languages[0]
                
                
                var langSupported = false
                
                for langKey in local_dict_all.values {
                    
                    let range: Range? = userLang.range(of: langKey)
                    
                    if range == nil {
                        
                        break
                        
                    } else if !range!.isEmpty {
                    
                        langSupported = true
                        userLang = langKey
                        break
                    
                    }

                }
                
                if !langSupported {
                    userLang = local_dict_all[ "local_cn" ]!
                }
                
                self.curLang = userLang
                
            }
            
            
            return userLang
        }
        
        // set
        set {
            
            // 如果没有切换到新的语言，不做处理
            let userLangObj = UserDefaults.standard.value(forKey: userLangKey)
            let userLang = (userLangObj != nil) ? userLangObj as! String : ""
            if userLang == newValue{
                return
            }
            
            // 更新 UserDefault 存储
            UserDefaults.standard.set(newValue, forKey: userLangKey)
            
            // 更新 Bundle 属性
            let path = Bundle.main.path(forResource: newValue, ofType: "lproj")
            self.bundle = Bundle(path: path!)
            
            
        }
        
    }
    
    // 单例模式， init方法设为private，
    private init() {
        bundle = nil
        default_lang_key = "local_en"
        local_dict_all = [
            "local_en": "en",
            "local_cn": "zh-Hans"
        ]
    }
    
    
    // 支持外部设置app支持的语言和其中的默认语言
    func setupSupportedLangs( langsDict: Dictionary<String, String>? ) {
        setupSupportedLangs(langsDict: langsDict, defaultkey: nil)
    }
    
    func setupSupportedLangs( defaultKey: String? ) {
        setupSupportedLangs(langsDict: nil, defaultkey: defaultKey)
    }
    
    func setupSupportedLangs( langsDict: Dictionary<String, String>?, defaultkey: String? ){
    
        if langsDict != nil {
            local_dict_all = langsDict!
        }
        
        if defaultkey != nil {
            
            if local_dict_all[ defaultkey! ] != nil {
            
                default_lang_key = defaultkey!
                
            }
            
        }
        
        
        
    }
    

}


/*
 * String Extension 简化国际化的调用
 *
 * "keyStr".localized()
 */
extension String {

    func localized( ) -> String {
    
        var bundle = LYCLocalization.defaultTool.bundle
        
        if bundle == nil {
            let path = Bundle.main.path(forResource: LYCLocalization.defaultTool.curLang, ofType: "lproj")
            
            bundle = Bundle(path: path!)!
        }
        
        let str: String? = bundle?.localizedString(forKey: self, value: nil, table: "Localizable")
        
        return str != nil ? str! : "Not found"

        
    }

}
