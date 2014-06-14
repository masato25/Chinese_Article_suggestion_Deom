這是以ruby實作簡單的文章推薦系統的小程式：

require: ruby 1.9以上
gem install bundle
在clone下的檔案下面下bundle install安裝所需外部lib.

list_sample:是我們假設的文章標題
list_manaully_subreater:假設中文斷字已經完成

＃你可以利用中研院的斷字系統先協助你斷字
http://ckipsvr.iis.sinica.edu.tw


How to execute? (index就是你選擇的文章,[0-7])
執行"ruby compare2.rb [index]"

這只是一個簡單的中文推薦系統。
