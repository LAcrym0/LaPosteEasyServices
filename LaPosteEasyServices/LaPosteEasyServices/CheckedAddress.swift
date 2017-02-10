//
//  CheckedAddresses.swift
//  LaPosteEasyServices
//
//  Created by Nico on 10/02/2017.
//  Copyright © 2017 Rémi. All rights reserved.
//

import Foundation

public class CheckedAddress{
    
    var destinataire: String = String()
    var pointRemise: String = String()
    var numeroVoie: String = String()
    var libelleVoie: String = String()
    var lieuDit: String = String()
    var codePostal: String = String()
    var codeCedex: String = String()
    var commune: String = String()
    var blocAdresse: [String] = []
    
    
    init?(json: [String: Any]) {
        guard let destinataire = json["destinataire"] as? String,
            let pointRemise = json["pointRemise"] as? String,
            let numeroVoie = json["numeroVoie"] as? String,
            let libelleVoie = json["libelleVoie"] as? String,
            let lieuDit = json["lieuDit"] as? String,
            let codePostal = json["codePostal"] as? String,
            let codeCedex = json["codeCedex"] as? String,
            let commune = json["commune"] as? String,
            let blocAdresse = json["commune"] as? [String]
            else {
                return nil
        }
        
        self.destinataire = destinataire
        self.pointRemise = pointRemise
        self.numeroVoie = numeroVoie
        self.libelleVoie = libelleVoie
        self.lieuDit = lieuDit
        self.codePostal = codePostal
        self.codeCedex = codeCedex
        self.commune = commune
        self.blocAdresse = blocAdresse
    }
}
