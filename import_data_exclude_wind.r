library(data.table)
library(dplyr)


# CSV取り込み(風速以外)
train.data <- as.data.frame(
    fread("train.csv")
)
out_of_service.data <- as.data.frame(
    fread("out_of_service.csv")
)
stop_station_location.data <- as.data.frame(
    fread("stop_station_location.csv")
)
tunnel_location.data <- as.data.frame(
    fread("tunnel_location.csv")
)
wind_location.data <- as.data.frame(
    fread("wind_location.csv")
)
snowfall_location.data <- as.data.frame(
    fread("snowfall_location.csv")
)
diagram.data <- as.data.frame(
    fread("diagram.csv")
)
kanazawa_nosnow.data <- as.data.frame(
    fread("kanazawa_nosnow.csv")
)
weather.data <- as.data.frame(
    fread("weather.csv")
)
snowfall.data <- as.data.frame(
    fread("snowfall.csv")
)
test.data <- as.data.frame(
    fread("test.csv")
)


## サマリ確認(風速以外)
summary(train.data)
summary(out_of_service.data)
summary(stop_station_location.data)
summary(tunnel_location.data)
summary(wind_location.data)
summary(snowfall_location.data)
summary(diagram.data)
summary(kanazawa_nosnow.data)
summary(weather.data)
summary(snowfall.data)
summary(test.data)

## 欠損値確認(風速以外)
anyNA(train.data)
anyNA(out_of_service.data)
anyNA(stop_station_location.data)
anyNA(tunnel_location.data)
anyNA(wind_location.data)
anyNA(snowfall_location.data)
anyNA(diagram.data)
anyNA(kanazawa_nosnow.data)
anyNA(weather.data)
anyNA(snowfall.data)
anyNA(test.data)


