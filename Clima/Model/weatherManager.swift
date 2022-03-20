
import Foundation

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=3a4fba8287927297777925634f855b76&units=metric"
    
    func fetchWeather(cityName:String){
        let urlString = "\(weatherUrl)&q=\(cityName)"
//        print(urlString)
        pRequest(urlString: urlString)
        
    }
    
    func pRequest(urlString:String){
        if let url = URL(string: urlString){
            let Session = URLSession(configuration: .default)
            
            let task = Session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            task.resume()
        }
    }
    
    func handle(data:Data?,response:URLResponse?,error:Error?){
        if error != nil{
            print(error!)
            return
        }
        if let safedata = data{
            let dataString = String(data:safedata,encoding: .utf8)
            print(dataString)
        }
    }
}
