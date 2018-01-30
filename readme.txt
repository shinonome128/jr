
###########################
# 作業前にやること
## ワークスペースで下記を削除
".RData"
"jr.Rproj"

## RStudioのTerminalから実施
git pull origin master

## RStudioのコンソールから実施
load(".RData")


# 作業後にやること

## RStudioのコンソールから実施
save.image()

## RStudioのTerminalから実施
git push --set-upstream origin master
###########################



