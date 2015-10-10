# ファイル登録用クラス
class Register
  def self.register(path)
    return unless path
    item = Item.new({filename: filename})
    item.save
  end
end