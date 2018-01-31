
# コード

library(data.table)
library(dplyr)
library(stringr)



# 金沢、富山の気象データを抽出

weather.data.kanazawa <- weather.data %>%
    filter(weather.data$地点 == "金沢")

weather.data.toyama <- weather.data %>%
    filter(weather.data$地点 == "富山")


# 金沢、富山の気象データのうち、訓練データを抽出

weather.data.kanazawa.2016 <- as.data.table(weather.data.kanazawa) %>%
    filter(
        str_detect(年月日時, "2016")
    )

weather.data.toyama.2016 <- as.data.table(weather.data.toyama) %>%
    filter(
        str_detect(年月日時, "2016")
    )


# 列名を修正

colnames(weather.data.kanazawa.2016) <-
c("date", "location", "tempareture(℃)", "precipitation(mm)", "snowfall(cm)", "snow(cm)", "sunshineTime(h)", "windSpeed(m/s)", "windDirection", "amountOfIsolation(MJ/㎡)", "localAtomosphericPressur(hPa)", "seeLevelPressur(hPa)", "relativeHumidity(％)", "VaporPressur(hPa)", "cloudVlume(10minThan)", "dewPointTempareture(℃)", "weather", "visiblity(km)")

colnames(weather.data.toyama.2016) <-
c("date", "location", "tempareture(℃)", "precipitation(mm)", "snowfall(cm)", "snow(cm)", "sunshineTime(h)", "windSpeed(m/s)", "windDirection", "amountOfIsolation(MJ/㎡)", "localAtomosphericPressur(hPa)", "seeLevelPressur(hPa)", "relativeHumidity(％)", "VaporPressur(hPa)", "cloudVlume(10minThan)", "dewPointTempareture(℃)", "weather", "visiblity(km)")


# 時刻を修正

weather.data.kanazawa.2016$date <- as.POSIXlt(weather.data.kanazawa.2016$date)

weather.data.toyama.2016$date <- as.POSIXlt(weather.data.toyama.2016$date)


# 気象データからロケーション列を抜く

weather.data.kanazawa.2016 <- weather.data.kanazawa.2016[, c(1, 3:16)]

weather.data.toyama.2016 <- weather.data.toyama.2016[, c(1, 3:16)]


# 金沢、富山の気象データは列名がかぶるので、列名を変更する

colnames(weather.data.kanazawa.2016) <-
c("kanazawaTimeWeather", "k_tempareture(℃)", "k_precipitation(mm)", "k_snowfall(cm)", "k_snow(cm)", "k_sunshineTime(h)", "k_windSpeed(m/s)", "k_windDirection", "k_amountOfIsolation(MJ/㎡)", "k_localAtomosphericPressur(hPa)", "k_seeLevelPressur(hPa)", "k_relativeHumidity(％)", "k_VaporPressur(hPa)", "k_cloudVlume(10minThan)", "k_dewPointTempareture(℃)")

colnames(weather.data.toyama.2016) <-
c("toyamaTimeWeather", "t_tempareture(℃)", "t_precipitation(mm)", "t_snowfall(cm)", "t_snow(cm)", "t_sunshineTime(h)", "t_windSpeed(m/s)", "t_windDirection", "t_amountOfIsolation(MJ/㎡)", "t_localAtomosphericPressur(hPa)", "t_seeLevelPressur(hPa)", "t_relativeHumidity(％)", "t_VaporPressur(hPa)", "t_cloudVlume(10minThan)", "t_dewPointTempareture(℃)")


# 金沢発、富山着の時刻を気象データにそろえるため、ダイヤ時刻を四捨五入して、気象データとそろえる

train.weather <- train.master

train.weather$kanazawaTimeWeather <- round(train.weather$kanazawaTime, "hours")

train.weather$toyamaTimeWeather <- round(train.weather$toyamaTime, "hours")


# 車両データに気象データをマージする

train.weather.kanazawa <- 
merge(train.weather, weather.data.kanazawa.2016, by = "kanazawaTimeWeather", all.x = T)

train.weather.kanazawa.toyama <- 
merge(train.weather.kanazawa, weather.data.toyama.2016, by = "toyamaTimeWeather", all.x = T)


# 不要列の削除と整理

train.weather.kanazawa.toyama <-
train.weather.kanazawa.toyama[, c(3:7, 2, 8:21, 1, 22:35)]


# 車両、気象のマスターデータ作成

train.weather.master <- train.weather.kanazawa.toyama


