
# コード

library("randomForest")


# 訓練データを作成

training.data <- train.weather.master


# 列名を修正

colnames(training.data) <-
c("date","train","kanazawaTime","toyamaTime","snow","kanazawaTimeWeather","k_tempareture","k_precipitation","k_snowfall","k_snow","k_sunshineTime","k_windSpeed","k_windDirection","k_amountOfIsolation","k_localAtomosphericPressur","k_seeLevelPressur","k_relativeHumidity","k_VaporPressur","k_cloudVlume","k_dewPointTempareture","toyamaTimeWeather","t_tempareture","t_precipitation","t_snowfall","t_snow","t_sunshineTime","t_windSpeed","t_windDirection","t_amountOfIsolation","t_localAtomosphericPressur","t_seeLevelPressur","t_relativeHumidity","t_VaporPressur","t_cloudVlume","t_dewPointTempareture")


# 不要列を削除(時刻と因子型)

training.data <-
training.data[, c(5, 7:12, 15:18, 20, 22:27, 29:33, 35)]


# 予測モデルを構築

result <- randomForest(
    training.data$snow ~.,
    training.data,
    na.action = na.exclude,
    mtry = 1,
    ntree = 500,
    type = "regression"
)


# テストデータを作成(train.data.master部分)

hoge1 <- test.data
hoge2 <- diagram.data.kanazawa_to_toyama.t
colnames(hoge1) <- c("V1", "date", "train")
colnames(hoge2) <- c("kanazawaTime","toyamaTime","train")
hoge3 <-
    merge(hoge1, hoge2, by = "train", all.x = T)
hoge3[order(hoge3$date, hoge3$kanazawaTime), ]
hoge3$date <- as.Date(hoge3$date)
hoge3$kanazawaTime <- as.POSIXlt(
    paste(hoge3$date, hoge3$kanazawaTime)
)
hoge3$toyamaTime <- as.POSIXlt(
    paste(hoge3$date, hoge3$toyamaTime)
)
hoge3 <- hoge3[order(hoge3$kanazawaTime), c(2, 3, 1, 4, 5)]
rownames(hoge3) <- c(1:nrow(hoge3))
test.data.master <- hoge3
rm(hoge1)
rm(hoge2)
rm(hoge3)


# テストデータを作成(weather.data部分)

weather.data.kanazawa.2017 <- as.data.table(weather.data.kanazawa) %>%
    filter(
        str_detect(年月日時, "2017")
    )

weather.data.toyama.2017 <- as.data.table(weather.data.toyama) %>%
    filter(
        str_detect(年月日時, "2017")
    )

colnames(weather.data.kanazawa.2017) <-
c("date", "location", "tempareture(℃)", "precipitation(mm)", "snowfall(cm)", "snow(cm)", "sunshineTime(h)", "windSpeed(m/s)", "windDirection", "amountOfIsolation(MJ/㎡)", "localAtomosphericPressur(hPa)", "seeLevelPressur(hPa)", "relativeHumidity(％)", "VaporPressur(hPa)", "cloudVlume(10minThan)", "dewPointTempareture(℃)", "weather", "visiblity(km)")

colnames(weather.data.toyama.2017) <-
c("date", "location", "tempareture(℃)", "precipitation(mm)", "snowfall(cm)", "snow(cm)", "sunshineTime(h)", "windSpeed(m/s)", "windDirection", "amountOfIsolation(MJ/㎡)", "localAtomosphericPressur(hPa)", "seeLevelPressur(hPa)", "relativeHumidity(％)", "VaporPressur(hPa)", "cloudVlume(10minThan)", "dewPointTempareture(℃)", "weather", "visiblity(km)")

weather.data.kanazawa.2017$date <- as.POSIXlt(weather.data.kanazawa.2017$date)

weather.data.toyama.2017$date <- as.POSIXlt(weather.data.toyama.2017$date)

weather.data.kanazawa.2017 <- weather.data.kanazawa.2017[, c(1, 3:16)]

weather.data.toyama.2017 <- weather.data.toyama.2017[, c(1, 3:16)]


colnames(weather.data.kanazawa.2017) <-
c("kanazawaTimeWeather", "k_tempareture(℃)", "k_precipitation(mm)", "k_snowfall(cm)", "k_snow(cm)", "k_sunshineTime(h)", "k_windSpeed(m/s)", "k_windDirection", "k_amountOfIsolation(MJ/㎡)", "k_localAtomosphericPressur(hPa)", "k_seeLevelPressur(hPa)", "k_relativeHumidity(％)", "k_VaporPressur(hPa)", "k_cloudVlume(10minThan)", "k_dewPointTempareture(℃)")

colnames(weather.data.toyama.2017) <-
c("toyamaTimeWeather", "t_tempareture(℃)", "t_precipitation(mm)", "t_snowfall(cm)", "t_snow(cm)", "t_sunshineTime(h)", "t_windSpeed(m/s)", "t_windDirection", "t_amountOfIsolation(MJ/㎡)", "t_localAtomosphericPressur(hPa)", "t_seeLevelPressur(hPa)", "t_relativeHumidity(％)", "t_VaporPressur(hPa)", "t_cloudVlume(10minThan)", "t_dewPointTempareture(℃)")

hoge1 <- 
test.data.master

hoge1$kanazawaTimeWeather <- round(hoge1$kanazawaTime, "hours")

hoge1$toyamaTimeWeather <- round(hoge1$toyamaTime, "hours")


hoge1$kanazawaTimeWeather <- as.character(hoge1$kanazawaTimeWeather)
hoge1$toyamaTimeWeather <- as.character(hoge1$toyamaTimeWeather)


weather.data.kanazawa.2017$kanazawaTimeWeather <- as.character(weather.data.kanazawa.2017$kanazawaTimeWeather)


weather.data.toyama.2017$toyamaTimeWeather <- as.character(weather.data.toyama.2017$toyamaTimeWeather)

test.weather.kanazawa <- 
merge(hoge1, weather.data.kanazawa.2017, by = "kanazawaTimeWeather", all.x = T)

test.weather.kanazawa.toyama <- 
merge(test.weather.kanazawa, weather.data.toyama.2017, by = "toyamaTimeWeather", all.x = T)

test.weather.kanazawa.toyama <-
test.weather.kanazawa.toyama[, c(3:7, 2, 8:21, 1, 22:35)]

test.weather.master <- test.weather.kanazawa.toyama


# 説明変数のテストデータを作成

test.weather.master <- test.weather.kanazawa.toyama

colnames(test.weather.master) <-
c("V1", "date", "train", "kanazawaTime", "toyamaTime", "kanazawaTimeWeather", "k_tempareture", "k_precipitation", "k_snowfall", "k_snow", "k_sunshineTime", "k_windSpeed", "k_windDirection", "k_amountOfIsolation", "k_localAtomosphericPressur", "k_seeLevelPressur", "k_relativeHumidity", "k_VaporPressur", "k_cloudVlume", "k_dewPointTempareture", "toyamaTimeWeather", "t_tempareture", "t_precipitation", "t_snowfall", "t_snow", "t_sunshineTime", "t_windSpeed", "t_windDirection", "t_amountOfIsolation", "t_localAtomosphericPressur", "t_seeLevelPressur", "t_relativeHumidity", "t_VaporPressur", "t_cloudVlume", "t_dewPointTempareture")


test.weather.master <-
test.weather.master[, c(
"k_tempareture",
"k_precipitation",
"k_snowfall",
"k_snow",
"k_sunshineTime",
"k_windSpeed",
"k_localAtomosphericPressur",
"k_seeLevelPressur",
"k_relativeHumidity",
"k_VaporPressur",
"k_dewPointTempareture",
"t_tempareture",
"t_precipitation",
"t_snowfall",
"t_snow",
"t_sunshineTime",
"t_windSpeed",
"t_amountOfIsolation",
"t_localAtomosphericPressur",
"t_seeLevelPressur",
"t_relativeHumidity",
"t_VaporPressur",
"t_dewPointTempareture"
)]


# 結果を予測

test.data.result <- test.data
test.data.result$predict <- predict(result, test.weather.master)


# CSVに出力、ネイピア表記させない、ダブルウォートと列番号無効化

submit_sample.data <-
test.data.result[, c(1,4)]

colnames(submit_sample.data) <- c("", "")

options(scipen=20)

write.csv(submit_sample.data, "submit_sample.csv", quote=FALSE, row.names=FALSE)










