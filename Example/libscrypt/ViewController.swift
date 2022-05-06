//
//  ViewController.swift
//  libscrypt
//
//  Created by sunimp on 04/29/2022.
//  Copyright (c) 2022 sunimp. All rights reserved.
//

import UIKit
import libscrypt

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let scrypt = Scrypt(password: "123456", salt: "Sun", n: 262144, r: 8, p: 1)
        print(scrypt.encrypt())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class Scrypt {
    private let password: String
    private let salt: String
    private let n: Int
    private let r: Int
    private let p: Int
    private let dklen = 32
    
    // Param: password and salt should be in hex format.
    init(password: String, salt: String, n: Int, r: Int, p: Int) {
        self.password = password
        self.salt = salt
        self.n = n
        self.r = r
        self.p = p
    }
    
    func encrypt() -> String {
        
        
        var passwordBytes: [UInt8] = []
        password.data(using: .utf8)?.withUnsafeBytes { (body: UnsafeRawBufferPointer) in
            if let bytes = body.baseAddress?.assumingMemoryBound(to: UInt8.self).pointee {
                passwordBytes = [bytes]
            }
        }
        var saltBytes: [UInt8] = []
        salt.data(using: .utf8)?.withUnsafeBytes { (body: UnsafeRawBufferPointer) in
            if let bytes = body.baseAddress?.assumingMemoryBound(to: UInt8.self).pointee {
                saltBytes = [bytes]
            }
        }
        
        var data = Data(count: dklen)
        data.withUnsafeMutableBytes { (body: UnsafeMutableRawBufferPointer) -> Void in
            
            let bytes = body.baseAddress?.assumingMemoryBound(to: UInt8.self)
            libscrypt_scrypt(
                passwordBytes,
                passwordBytes.count,
                saltBytes,
                saltBytes.count,
                UInt64(n),
                UInt32(r),
                UInt32(p),
                bytes,
                dklen
            )
        }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
