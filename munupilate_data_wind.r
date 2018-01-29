library(data.table)
library(dplyr)
library(stringr)

# ファイル名取得
cat("ファイル名取得")
date()
files <- c(
    "wind_gejogawa.csv",
    "wind_otomaru.csv",
    "wind_kurami.csv",
    "wind_karamatagawa.csv",
    "wind_sakaigawa.csv",
    "wind_himekawa.csv",
    "wind_oyabegawa.csv",
    "wind_joganji.csv",
    "wind_shogawa.csv",
    "wind_asahi.csv",
    "wind_higashiaraya.csv",
    "wind_morimoto.csv",
    "wind_namegawa.csv",
    "wind_katakaigawa.csv",
    "wind_jinzugawa.csv",
    "wind_no.csv",
    "wind_aomi.csv",
    "wind_takaokaaramatagawa.csv",
    "wind_takada.csv",
    "wind_kurobegawa.csv"
)
date()
# 全ファイルに対して実施
cat("全ファイルに対して実施")
date()
for (file.name in files) {
    # CSVの取り込み
    cat("CSVの取り込み")
    date()
    library(data.table)
    d <- fread(file.name, header = TRUE)
    date()
    # 2015/12/1～2016/3/31の取り込みとCSV出力
    cat("2015/12/1～2016/3/31の取り込みとCSV出力")
    date()
    library(dplyr)
    library(stringr)
    d.fy15 <- d %>%
        filter(
        str_detect(年月日時, "2015-12-") |
        str_detect(年月日時, "2016-01-") |
        str_detect(年月日時, "2016-02-") |
        str_detect(年月日時, "2016-03-")
        )
    date()
    # 2016/12/1～2017/3/31の風速データの取り込み
    cat("2016/12/1～2017/3/31の風速データの取り込み")
    date()
    library(dplyr)
    library(stringr)
    d.fy16 <- d %>%
        filter(
        str_detect(年月日時, "2016-12-") |
        str_detect(年月日時, "2017-01-") |
        str_detect(年月日時, "2017-02-") |
        str_detect(年月日時, "2017-03-")
        )
    date()
 # CSVへの書き出し
    cat("CSVへの書き出し")
    date()
    library(data.table)
    fwrite(d.fy15, sprintf("%s.fy15.csv", file.name))
    fwrite(d.fy16, sprintf("%s.fy16.csv", file.name))
    date()
    # 不要データオブジェクトの削除とメモリ開放
    cat("不要データオブジェクトの削除とメモリ開放")
    date()
    rm(d)
    rm(d.fy15)
    rm(d.fy16)
    gc()
    gc()
    date()
}
date()

