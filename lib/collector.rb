require 'digest/sha2'

# ファイル収集用クラス
class Collector

  # 探索基底パスを設定し初期化
  def initialize(root_path)
    # TODO : パス文字を意識せずに動くようにしたい...(windowsでも)
    @root_path = Pathname.new(root_path)
  end

  # 基底パス配下を探索し、ファイルごとに受け取ったprocを呼ぶ
  def collect
    recursive_collect @root_path
  end

  # 再帰的に登録していく
  def recursive_collect(pathname)
    if pathname.directory?
      pathname.each_child {|childpath|
        recursive_collect childpath
      }
    end

    if pathname.file?
      register @root_path, pathname
    end
  end

  # パス登録
  def register(root_path, pathname)
    relative_path = pathname.relative_path_from(root_path)

    item = Item.new({
      relative_path: relative_path.to_s,
      digest: Digest::SHA512.file(pathname.to_s)
    })

    if item.save
      p "register : #{relative_path.to_s}"
    end
  end
end