# 登録済みのデータの調整・確認用クラス
class Adjuster

  # 探索基底パスを設定し初期化
  def initialize(root_path)
    # TODO : パス文字を意識せずに動くようにしたい...(windowsでも)
    @root_path = Pathname.new(root_path)
  end

  def adjust

  end

end