
import Foundation
protocol WeatherManagerdDelegate {
    func updateWeather(waether:WeatherModel)
}

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=3a4fba8287927297777925634f855b76&units=metric"
    
    var delegate : WeatherManagerdDelegate?
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
                    if let weather = self.jsonParse(weatherData: safedata){
                        delegate?.updateWeather(waether: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func jsonParse(weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let Id = (decodedData.weather[0].id)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionId: Id, Name: name, Temperature: temp)
            return weather
        }catch{
            print(error)
            return nil
        }
    }
    
    
    

}
