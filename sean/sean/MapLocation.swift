import SwiftUI
import MapKit

struct MapLocation: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(.pink)
            .onAppear {
                viewModel.checkLocation()
            }
    }
}
struct MapLocation_Previews: PreviewProvider {
    static var previews: some View {
        MapLocation()
    }
}


enum MapDetails {
    static var center = CLLocationCoordinate2D(latitude: 37.332, longitude: -121.891)
    static var span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}


class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.center, span: MapDetails.span)
    var locationManager: CLLocationManager?
    
    func checkLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("fuck")
        }
    }
    func checkAuthorized() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted.")
        case .denied:
            print("You have denied location access.")
            
        case .authorizedAlways, .authorizedWhenInUse:
            
            if locationManager.location != nil {
                region = MKCoordinateRegion(
                    center: locationManager.location!.coordinate,
                    span: MapDetails.span)
            } else {
                region = MKCoordinateRegion(
                    center: MapDetails.center,
                    span: MapDetails.span)
            }
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorized()
    }
}
