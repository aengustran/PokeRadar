//
//  ViewController.swift
//  PokeRadar
//
//  Created by Aengus Tran on 30/9/16.
//  Copyright © 2016 Aengus Tran. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()

    lazy var mapView: MKMapView = {
        let mv = MKMapView()
        mv.delegate = self
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.userTrackingMode = MKUserTrackingMode.followWithHeading
        return mv
    }()

    func SetupMapView() {
        mapView.frame = view.frame
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        mapView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        requestAuthorization()

    }


    lazy var pokemonButton: UIButton = {
        let bnt = UIButton()
        bnt.translatesAutoresizingMaskIntoConstraints = false
        bnt.addTarget(self, action: #selector(handlepokemonButton), for: .touchUpInside)
        return bnt
    }()


    func handlepokemonButton() {
        print("Handle pokemon button")
    }



    func SetupPokemonButton() {

        let image = UIImage(named: "pokeball")
        pokemonButton.setImage(image, for: .normal)
        pokemonButton.contentMode = .scaleAspectFit
        pokemonButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 20).isActive = true
        pokemonButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20).isActive = true
        pokemonButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pokemonButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }




    func requestAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }

    }



    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = true
    }



    var locationSetOnce = false
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

        if !locationSetOnce {
            let currentRegion = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 2000, 2000)
            mapView.setRegion(currentRegion, animated: true)
            locationSetOnce = true
        }

    }


    override func viewDidAppear(_ animated: Bool) {
        requestAuthorization()
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        SetupMapView()
        view.addSubview(pokemonButton)
        SetupPokemonButton()
    }



}

