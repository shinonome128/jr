
# 富山と糸魚川に停車した列車データを抽出

library(dplyr)
library(data.table)

# 富山駅データ抽出

train.data.toyama <- as.data.table(
    train.data %>%
        filter(train.data$停車駅名 == "富山")
)

# 糸魚川データ抽出

train.data.itoigawa <- as.data.table(
    train.data %>%
        filter(train.data$停車駅名 == "糸魚川")
)

# 列名変更

var1 <- c("toyama年月日","toyama列車番号","toyama停車駅名","toyamaフェンダー部分(東京方向)","toyama台車部分","toyamaフェンダー部分(金沢方向)","toyama合計")
var2 <- c("itoigawa年月日","itoigawa列車番号","itoigawa停車駅名","itoigawaフェンダー部分(東京方向)","itoigawa台車部分","itoigawaフェンダー部分(金沢方向)","itoigawa合計")
colnames(train.data.toyama) <- var1
colnames(train.data.itoigawa) <- var2


# ダイヤ情報から金沢発と富山着時間を取得

diagram.data.kanazawa_to_toyama <- diagram.data[c(1, 3), ]


# 富山の着雪量データに金沢発と富山着の時刻の列を追加

train.time <- train.data.toyama


# ダイヤ表の行と列を入れ替える

diagram.data.kanazawa_to_toyama.t <- as.data.frame(
    t(diagram.data.kanazawa_to_toyama)
)


# マージ用に車両列と列名をつける

var3 <- rownames(diagram.data.kanazawa_to_toyama.t)
diagram.data.kanazawa_to_toyama.t$toyama列車番号 <- var3
colnames(diagram.data.kanazawa_to_toyama.t) <- c("kanazawaTime", "toyamaTime", "toyama列車番号")


# マージ

train.time.merge <-
merge(train.time, diagram.data.kanazawa_to_toyama.t, by = "toyama列車番号")


# 結果が車両でソートされているので日付と時刻でソート

train.time.merge.sort <-
    train.time.merge[order(train.time.merge$toyama年月日, train.time.merge$kanazawaTime), ]


# Rで最後に行番号を振りなおす

rownames(train.time.merge.sort) <- c(1:nrow(train.time.merge.sort))


# マスターデータの保存

train.master <- train.time.merge.sort


