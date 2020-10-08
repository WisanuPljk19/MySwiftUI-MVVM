////
////  ApiManager.swift
////  ePM_Network
////
////  Created by Wisanu Paunglumjeak on 4/2/2563 BE.
////  Copyright © 2563 CDG Systems Ltd. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import SwiftyBeaver
//import Necromancer
//
//class ApiManager<T: Codable>{
//    
//    private init(){
//        
//    }
//    
//    static var shared: ApiManager<T> {
//        get{
//            return ApiManager<T>()
//        }
//    }
//    
//    func checkVersion(onPass: (() -> Void)!,
//                       onUpdate: ((String, URL?) -> Void)!){
//        
//        #if DEBUG
//        onPass()
//        #elseif RELEASE
//        AF.request("https://itunes.apple.com/lookup?bundleId=th.go.doe.HiringFreshGrad&country=TH").responseJSON { (dataResponse) in
//            switch dataResponse.result {
//            case .success:
//                guard let appStore = ObjectUtils.decodeJson(from: AppStoreModel.self,
//                                                            data: dataResponse.data),
//                      appStore.results.count > 0 else{
//                    onPass()
//                    return
//                }
//                let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
//                let appStoreVersion = appStore.results[0].version
//                if AppUtils.checkVersion(with: currentVersion, appStoreVersion: appStoreVersion) == .unknown {
//                    onPass()
//                }else {
//                    let message = "คุณกำลังใช้งานเวอร์ชัน \(currentVersion ?? "") กรุณาอัปเดตเป็นเวอร์ชัน \(appStoreVersion)"
//                    onUpdate(message, URL(string: "itms-apps://apps.apple.com/app/id1530664479"))
//                }
//            case .failure:
//                onPass()
//            }
//        }
//        #endif
//    }
//    
////    func authen(_ authen: Authen,
////                      completeHandler: ((GenericResponse<Authen>?) -> Void)!,
////                      failureHandler: ((_ message: String) -> Void)!){
////
////        let service = Service.auth.serviceConfig
////        var headers = HTTPHeaders()
////        headers.add(name: "X-CDGS-ACTIVE-ROLE", value: authen.roleCode!)
////        headers.add(name: Constants.contentType, value: service.contentType.rawValue)
////        headers.add(name: "User-Agent", value: defaultUserAgent)
////        authen.device = "iOS"
////        authen.messageToken = UserDefaults.standard.string(forKey: PreferenceKeys.messagingToken)
////        AF.request(service.serviceUrl,
////                          method: service.method,
////                          parameters: ObjectUtils.encodeJson(from: GenericRequest(authen)),
////                          encoding: JSONEncoding.default,
////                          headers: headers).responseJSON { dataResponse in
////                            guard let statusCode = dataResponse.response?.statusCode else {
////                                Log.error("\(service.serviceUrl) not Response ")
////                                failureHandler("เกิดข้อผิดพลาดไม่สามารถใช้งานได้ในขณะนี้")
////                                return
////                            }
////
////                            if 200..<300 ~= statusCode {
////                                guard let response = GenericResponse<Authen>.toGenericResponse(with: dataResponse.data),
////                                      let accessTokenResponse = response.result else{
////                                    self.clearPreferences()
////                                    failureHandler("เกิดข้อผิดพลาดไม่สามารถใช้งานได้ในขณะนี้")
////                                    return
////                                }
////
//////                                Log.debug("CHECKREFRESHTOKEN FROM AUTH = \(accessTokenResponse.authentication!.refreshToken!)")
////
////                                UserDefaults.standard.set(accessTokenResponse.authentication?.accessToken, forKey: PreferenceKeys.accessToken)
////                                UserDefaults.standard.set(accessTokenResponse.authentication?.refreshToken, forKey: PreferenceKeys.refreshToken)
////
////                                UserDefaults.standard.set(response.result?.userInfo?.referenceUser?.refferenceKey, forKey: PreferenceKeys.refferenceKey)
////                                UserDefaults.standard.set(response.result?.userInfo?.referenceUser?.refferenceName, forKey: PreferenceKeys.refferenceName)
////                                UserDefaults.standard.set(authen.roleCode, forKey: PreferenceKeys.roleCode)
////
////                                UserDefaults.standard.set(response.result?.initialInfo?.displayName, forKey: PreferenceKeys.displayName)
////                                UserDefaults.standard.set(response.result?.initialInfo?.provinceName, forKey: PreferenceKeys.provinceName)
////                                UserDefaults.standard.set(response.result?.initialInfo?.imageUrl, forKey: PreferenceKeys.imageUrl)
////                                UserDefaults.standard.set(response.result?.initialInfo?.email, forKey: PreferenceKeys.email)
////
////                                let menus = (response.result?.menus ?? []).map { "\($0.programId!)#\($0.name!)"}
////                                UserDefaults.standard.set(menus, forKey: PreferenceKeys.menu)
////
////                                UserDefaults.standard.synchronize()
//////                                Log.debug("CHECKREFRESHTOKEN FROM UserDefaults AFTER AUTH = \(UserDefaults.standard.string(forKey: PreferenceKeys.refreshToken) ?? "")")
////                                completeHandler(response)
////                            }else if 401 == statusCode {
////                                guard let response = GenericResponse<String>.toGenericResponse(with: dataResponse.data) else{
////                                    self.clearPreferences()
////                                    return
////                                }
////                                failureHandler(response.message ?? "")
////                            }else if 400..<500 ~= statusCode {
////                                self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
////                                    let messageResponse = "\(service.serviceUrl) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
////                                    Log.info(messageResponse)
////                                }, failureHandler: failureHandler)
////                            }else if 502 == statusCode {
////                                self.handlerErrorResponse(with: "Bad Gateway", beforeHandler: { (errorResponse) in
////                                    let messageResponse = "\(service.serviceUrl) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
////                                    Log.error(messageResponse)
////                                }, failureHandler: failureHandler)
////                            }else if 503 == statusCode {
////                                self.presentServiceUnavailable()
////                            }else if 504 == statusCode {
////                                self.handlerErrorResponse(with:
////                                    """
////                                        ไม่สามารถเชื่อมต่อได้หรือหมดเวลาการเชื่อมต่อ
////                                        กรุณารอและทำรายการใหม่
////                                    """, beforeHandler: { (errorResponse) in
////                                    let messageResponse = "\(service.serviceUrl) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
////                                    Log.error(messageResponse)
////                                }, failureHandler: failureHandler)
////                            }else {
////                                self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
////                                    let messageResponse = "\(service.serviceUrl) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
////                                    Log.error(messageResponse)
////                                }, failureHandler: failureHandler)
////                            }
////        }
////    }
//    
////    func renewAccessToken(_ renewAccessTokenHandler: (() -> Void)!) {
////        let service = Service.renewAccessToken.serviceConfig
////        let refreshToken = UserDefaults.standard.string(forKey: PreferenceKeys.refreshToken) ?? ""
//////        Log.debug("CHECKREFRESHTOKEN FROM UserDefaults BEFORE RENEW = \(UserDefaults.standard.string(forKey: PreferenceKeys.refreshToken) ?? "")")
////        let headers = [
////            "Content-Type": service.contentType.rawValue,
////            "User-Agent": defaultUserAgent
////        ]
////
////        let authen = Authenticate()
////        authen.refreshToken = refreshToken
////        let genericRequest = GenericRequest.init(authen)
////
////        AF.request(service.serviceUrl, method: service.method, parameters: ObjectUtils.encodeJson(from: genericRequest),
////                   encoding: JSONEncoding.default, headers: HTTPHeaders(headers))
////            .responseJSON { dataResponse in
////
////                switch dataResponse.result {
////                case .success:
////                    guard let response = GenericResponse<Authen>.toGenericResponse(with: dataResponse.data),
////                          let accessTokenResponse = response.result else{
////                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
////                        Log.info("URL [\(service.serviceUrl)] is not response")
////                        ProgressLoadingView.dismiss()
////                        self.goToLogin()
////                        return
////                    }
//////                    Log.debug("CHECKREFRESHTOKEN FROM RENEW = \(accessTokenResponse.authentication!.refreshToken!)")
////                    UserDefaults.standard.set(accessTokenResponse.authentication?.accessToken, forKey: PreferenceKeys.accessToken)
////                    UserDefaults.standard.set(accessTokenResponse.authentication?.refreshToken, forKey: PreferenceKeys.refreshToken)
////                    UserDefaults.standard.synchronize()
//////                    Log.debug("CHECKREFRESHTOKEN FROM UserDefaults AFTER RENEW = \(UserDefaults.standard.string(forKey: PreferenceKeys.refreshToken) ?? "")")
////                    renewAccessTokenHandler()
////                case .failure:
////                    guard let statusCode = dataResponse.response?.statusCode, statusCode != 503 else {
////                        self.presentServiceUnavailable()
////                        return
////                    }
////
////                    guard statusCode != 401 else {
////                        self.presentServiceUnavailable()
////                        return
////                    }
////                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
////                    Log.info("renewAccessToken failed")
////                    ProgressLoadingView.dismiss()
////                    self.goToLogin()
////                }
////        }
////    }
//    
//    /**
//     for call any services with security.
//     
//     This function will combine the access token from `preference` to send with `Authorization` header.
//     */
//    func service(_ service: Service,
//                 params: Parameters?,
//                 completeHandler: ((GenericResponse<T>?) -> Void)!,
//                 failureHandler: ((_ message: String) -> Void)!){
//        
//        let serviceConfig = Service.renewAccessToken.serviceConfig
//        
////        let accessToken = UserDefaults.standard.string(forKey: PreferenceKeys.accessToken) ?? ""
//        let headers:HTTPHeaders = [
////            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": serviceConfig.contentType.rawValue,
////            "X-CDGS-ACTIVE-ROLE": UserDefaults.standard.string(forKey: PreferenceKeys.roleCode) ?? "",
//            "User-Agent": defaultUserAgent
//        ]
//        
//        self.service(service, params: params, headers: headers, completeHandler: completeHandler, failureHandler: failureHandler)
//    }
//    
//    /**
//     for call any services without security.
//     
//     This function will not combine the access token from `preference` to send with `Authorization` header.
//     */
//    func serviceWithoutAccess(_ service: Service,
//                              params: Parameters?,
//                              completeHandler: ((GenericResponse<T>?) -> Void)!,
//                              failureHandler: ((String) -> Void)!){
//        let serviceConfig = service.serviceConfig
//        
//        let headers:HTTPHeaders = ["Content-Type": serviceConfig.contentType.rawValue,
////                                   "X-CDGS-ACTIVE-ROLE": UserDefaults.standard.string(forKey: PreferenceKeys.roleCode) ?? "",
//                                   "User-Agent": defaultUserAgent]
//        
//        self.service(service, params: params, headers: headers, completeHandler: completeHandler, failureHandler: failureHandler)
//    }
//    
//    /**
//     overloaded function, for manual configuration header.
//     
//     if really need this function, please beware `Authorization` header.
//     
//     This function will automaticcally renew the access token when it expire,
//     then recall the main service with no more code.
//     
//     */
//    
//    func service(_ service: Service,
//                 params: Parameters?,
//                 headers: HTTPHeaders,
//                 completeHandler: ((_ response: GenericResponse<T>?) -> Void)!,
//                 failureHandler: ((_ message: String) -> Void)!){
//        guard NetworkReachabilityManager()!.isReachable else {
//            self.alertNetworkUnreachable()
//            return
//        }
//        
//        let url = service.serviceConfig.serviceUrl
//        let method = service.serviceConfig.method
//        var encode: ParameterEncoding {
//            switch service.serviceConfig.contentType {
//            case .json:
//                return JSONEncoding.default
//            default:
//                return URLEncoding.default
//            }
//        }
//    
//        AF.request(url, method: method, parameters: params, encoding: encode, headers: headers)
//            .responseJSON { (dataResponse) in
//                guard let statusCode = dataResponse.response?.statusCode else {
//                    Log.error("\(url) not Response ")
//                    failureHandler(Message.serviceError)
//                    return
//                }
//                
//                if 200..<300 ~= statusCode {
//                    let response:GenericResponse<T>? = GenericResponse<T>.toGenericResponse(with: dataResponse.data)
//                    completeHandler(response)
//                }else if 401 == statusCode {
////                    self.renewAccessToken({
////                        self.service(service, params: params, completeHandler: completeHandler, failureHandler: failureHandler)
////                    })
//                }else if 400..<500 ~= statusCode {
//                    self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
//                        let messageResponse = "\(url) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
//                        Log.info(messageResponse)
//                    }, failureHandler: failureHandler)
//                }else if 503 == statusCode {
//                    self.presentServiceUnavailable()
//                }else {
//                    self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
//                        let messageResponse = "\(url) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
//                        Log.error(messageResponse)
//                    }, failureHandler: failureHandler)
//                }
//        }
//    }
//    
//    func uploadFile(_ service: Service,
//                    multipartFormData: MultipartFormData,
//                    completeHandler: ((_ response: GenericResponse<T>?) -> Void)!,
//                    failureHandler: ((_ message: String) -> Void)!){
//        
//        let url = service.serviceConfig.serviceUrl
//        let method = service.serviceConfig.method
//        let contentType = service.serviceConfig.contentType.rawValue
//        
////        let accessToken = UserDefaults.standard.string(forKey: PreferenceKeys.accessToken) ?? ""
//        let headers:HTTPHeaders = [
////            "Authorization": "Bearer \(accessToken)",
//            "Content-Type": contentType,
////            "X-CDGS-ACTIVE-ROLE": UserDefaults.standard.string(forKey: PreferenceKeys.roleCode) ?? "",
//            "User-Agent": defaultUserAgent]
//        
//        AF.upload(multipartFormData: multipartFormData,
//                  to: url,
//                  method: method,
//                  headers: headers).responseJSON { (dataResponse) in
//                    guard let statusCode = dataResponse.response?.statusCode else {
//                        Log.error("\(url) not Response ")
//                        failureHandler(Message.serviceError)
//                        return
//                    }
//                    
//                    if 200..<300 ~= statusCode {
//                        let response:GenericResponse<T>? = GenericResponse<T>.toGenericResponse(with: dataResponse.data)
//                        completeHandler(response)
//                    }else if 401 == statusCode {
////                        self.renewAccessToken({
////                            self.uploadFile(service,
////                                            multipartFormData: multipartFormData,
////                                            completeHandler: completeHandler,
////                                            failureHandler: failureHandler)
////                        })
//                    }else if 400..<500 ~= statusCode {
//                        self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
//                            let messageResponse = "\(url) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
//                            Log.info(messageResponse)
//                        }, failureHandler: failureHandler)
//                    }else {
//                        self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
//                            let messageResponse = "\(url) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
//                            Log.error(messageResponse)
//                        }, failureHandler: failureHandler)
//                    }
//        }
//    }
//	
//	
////	func logout(_ logoutHandler: ((Bool) -> Void)!, failureHandler: ((_ message: String) -> Void)!) {
////        let service = Service.logout.serviceConfig
////		let url = service.serviceUrl
////        let accessToken = UserDefaults.standard.string(forKey: PreferenceKeys.accessToken) ?? ""
////        let headers = [
////			"Authorization": "Bearer \(accessToken)",
////            "Content-Type": service.contentType.rawValue,
////            "User-Agent": defaultUserAgent
////        ]
////
////        let refreshToken = UserDefaults.standard.string(forKey: PreferenceKeys.refreshToken) ?? ""
////		let device = "iOS"
////		let messageToken = UserDefaults.standard.string(forKey: PreferenceKeys.messagingToken) ?? ""
////		let userId = UserDefaults.standard.string(forKey: PreferenceKeys.refferenceKey) ?? ""
////		let email = UserDefaults.standard.string(forKey: PreferenceKeys.email) ?? ""
////		let params: [String: String] = ["refreshToken" : refreshToken,
////										"device": device,
////										"messageToken": messageToken,
////										"userId": userId,
////										"email": email
////		]
////
////		AF.request(service.serviceUrl, method: service.method, parameters: ObjectUtils.encodeJson(from: ["request": params]),
////                   encoding: JSONEncoding.default, headers: HTTPHeaders(headers))
////            .responseJSON { dataResponse in
////
////				guard let statusCode = dataResponse.response?.statusCode else {
////					Log.error("\(url) not Response ")
////					failureHandler(Message.serviceError)
////					return
////				}
////
////                if 200..<300 ~= statusCode {
////					self.clearPreferences()
////					logoutHandler(true)
////				}else if 401 == statusCode {
////					self.renewAccessToken({
////						self.logout(logoutHandler, failureHandler: failureHandler)
////					})
////				}else if 400..<500 ~= statusCode {
////					self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
////						let messageResponse = "\(url) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
////						Log.info(messageResponse)
////					}, failureHandler: failureHandler)
////				}else {
////					self.handlerErrorResponse(with: dataResponse.data, beforeHandler: { (errorResponse) in
////						let messageResponse = "\(url) [\(statusCode)]: \(errorResponse?.timestamp ?? "") with message \(errorResponse?.message ?? "NULL")"
////						Log.error(messageResponse)
////					}, failureHandler: failureHandler)
////				}
////        }
////    }
//    
//    private func goToLogin(){
////        guard let presentView = BusinessUtils.getPresentViewController() else{
////            return
////        }
////        let dialog = UIDialog.initialDialog(with: Message.sessionExpire) {
////            let navLogin = Storyboard.login.instantiateViewController(withIdentifier: "navLogin")
////            presentView.modalTransitionStyle = .crossDissolve
////            presentView.present(navLogin, animated: true, completion: nil)
////        }
////        presentView.present(dialog, animated: true, completion: nil)
//    }
//    
//    private func handlerErrorResponse(with data: Data?,
//                                      beforeHandler: ((ErrorResponse?) -> Void)? = nil,
//                                      failureHandler: ((_ message: String) -> Void)){
//        guard let data = data else{
//            failureHandler(Message.serviceError)
//            return
//        }
//        let errorResponse = ErrorResponse.toErrorResponse(with: data)
//        beforeHandler?(errorResponse)
//        failureHandler(errorResponse?.message ?? Message.serviceError)
//    }
//    
//    private func handlerErrorResponse(with message: String?,
//                                      beforeHandler: ((ErrorResponse?) -> Void)? = nil,
//                                      failureHandler: ((_ message: String) -> Void)){
//        guard let message = message else{
//            failureHandler(Message.serviceError)
//            return
//        }
//        let errorResponse = ErrorResponse()
//        errorResponse.message = message
//        beforeHandler?(errorResponse)
//        failureHandler(errorResponse.message ?? Message.serviceError)
//    }
//    
//    private func alertNetworkUnreachable(){
////        guard let presentView = BusinessUtils.getPresentViewController() else{
////            return
////        }
////        let dialog = UIDialog.initialDialog(with: Message.connectNetworkForUsing)
////        presentView.present(dialog, animated: true, completion: nil)
//    }
//    
//    private func presentServiceUnavailable(){
////        guard let presentView = BusinessUtils.getPresentViewController() else{
////            return
////        }
////        presentView.present(ServiceUnavailableViewController.initialVC(), animated: true, completion: nil)
//    }
//    
//    private func clearPreferences(){
////        let messageToken = UserDefaults.standard.string(forKey: PreferenceKeys.messagingToken)
////        let roleTemp = UserDefaults.standard.string(forKey: PreferenceKeys.roleCodeTemp)
////        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
////        UserDefaults.standard.synchronize()
////        UserDefaults.standard.set(messageToken, forKey: PreferenceKeys.messagingToken)
////        UserDefaults.standard.set(roleTemp, forKey: PreferenceKeys.roleCodeTemp)
////        UserDefaults.standard.synchronize()
//    }
//    
//    /// Returns Alamofire's default `User-Agent` header.
//    ///
//    /// See the [User-Agent header documentation](https://tools.ietf.org/html/rfc7231#section-5.5.3).
//    ///
//    /// Example: `iOS Example/1.0 (org.alamofire.iOS-Example; build:1; iOS 13.0.0) Alamofire/5.0.0`
//    lazy var defaultUserAgent: String = {
//        let info = Bundle.main.infoDictionary
//        let executable = "DOE"
//        let bundle = info?[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
//        let appVersion = info?["CFBundleShortVersionString"] as? String ?? "Unknown"
//        let appBuild = info?[kCFBundleVersionKey as String] as? String ?? "Unknown"
//        let osNameVersion: String = {
//            let version = ProcessInfo.processInfo.operatingSystemVersion
//            let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
//            let osName: String = {
//                #if os(iOS)
//                #if targetEnvironment(macCatalyst)
//                return "macOS(Catalyst)"
//                #else
//                return "iOS"
//                #endif
//                #elseif os(watchOS)
//                return "watchOS"
//                #elseif os(tvOS)
//                return "tvOS"
//                #elseif os(macOS)
//                return "macOS"
//                #elseif os(Linux)
//                return "Linux"
//                #elseif os(Windows)
//                return "Windows"
//                #else
//                return "Unknown"
//                #endif
//            }()
//
//            return "\(osName) \(versionString)"
//        }()
//
//        let alamofireVersion = "Alamofire/5.2.2"
//
//        let userAgent = "\(executable)/\(appVersion) (\(bundle); build:\(appBuild); \(osNameVersion)) \(alamofireVersion)"
//
//        return userAgent
//    }()
//}
