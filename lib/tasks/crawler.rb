# ファイルクローラ
class Tasks::Crawler

  # TODO : テスト用/基底ルートパス - modelから取得する形に変えること
#  ROOT_PATH = "/Users/mugi/develop/ruby/tsumota/work"

  # クローリングの実行
  def self.run
    p "run!"

    # 管理画面等から登録された設定情報をすべて取得
    setting = Setings.first


    # 基底ディレクトリ内の全ファイルを捜査
    # 未登録状態のファイルをすべて登録する

    Dir.glob("#{ROOT_PATH}/*").each {|filename|
      p "#{filename} -> #{File.ftype(filename)}"
      if File.file?(filename)
        p "file !! : #{filename}"
      else
        p "not file !! : #{filename}"
      end
    }
  end
end