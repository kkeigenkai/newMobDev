
# Table of Contents

1.  [Описание функционала](#orgac26900)
    1.  [Picture of the day](#org0d75fce)
    2.  [Nasa search](#orgf3b8832)
2.  [Network](#orgc0d0092)


<a id="orgac26900"></a>

# Описание функционала

Используется 2 API Nasa: картинка дня и поиск по картинкам. Выбор экрана осуществляется свайпом влево или враво.


<a id="org0d75fce"></a>

## Picture of the day

Главный экран в приложении. При запуске показывает картинку сегодняшнего дня. Внизу экрана можно выбрать дату (с ограничением даты не выше сегодняшней).

API может вернуть не только ссылку на картинку, но и ссылку на embed youtube видео. Для отображения использую `YoutubeVideoView`.

Внутри структуры используеются:

-   `network` - для полчения результата картинки дня;
-   `date` - для передачи в функцию `getPicktureOfTheDay`;
-   `dateRange` - для ограничения выбора даты.

```swift
struct PictureOfTheDayView: View {
    @EnvironmentObject var network: Network
    @State var date = Date.now

    let dateRange: ClosedRange<Date> = {
        let to = Date.now
        let from = Date(timeIntervalSince1970: 0)
        return from...to
    }()

    var body: some View {
        ...
    }
}
```


<a id="orgf3b8832"></a>

## Nasa search

Осуществляет поиск по картинкам по запросу пользователя. Внешний вид результата поиска выполнен в виде карточек.

Внутри структуры две переменные: `network` - получаем результат поиска и `query` - передаем в `getNasaSearch`.

```swift
struct NasaSearchVeiw: View {
    @EnvironmentObject var network: Network
    @State var query = ""

    var body: some View {
        VStack(alignment: .leading) {
            TextField(
                "Nasa Search",
                text: $query
            ).textFieldStyle(.roundedBorder).onChange(of: query) {
                network.getNasaSearch(query: query)
            }.padding()

            NasaSearchCardView().environmentObject(network)
        }
    }
}
```

<a id="orgc0d0092"></a>

# Network

Для получения запросов используется класс `Network`. Класс имеет две `@Published` переменные: `pictureOfTheDay` и `searchResult`. Внутри два метода `getNasaSearch` и `getPicktureOfTheDay`.
```swift
class Network: ObservableObject {
    @Published var pictureOfTheDay = PictureOfTheDay(date: "", url: "", title: "", explanation: "")
    @Published var searchResult = NewEmptyNasaSearch()

    func getNasaSearch(query: String) {
            guard let url = URL(string: "https://images-api.nasa.gov/search?q=\(query)&media_type=image") else {
                fatalError("Missing request URL")
            }
                ...
    }

    func getPicktureOfTheDay(day: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=QENM2TIRsYGnfHepVNFDJNpbukhBzTXB1ex8Eh73&date=\(formatter.string(from: day))") else {
            fatalError("Missing request URL")
        }
            ...
    }
}
```
