
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
            
            let task = Session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safedata = data{
                    self.jsonParse(weatherData: safedata)
                }
            }
            task.resume()
        }
    }
    
    func jsonParse(weatherData:Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        }catch{
            print(error)
        }
    }
    

}
