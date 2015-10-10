# ファイル収集用クラス
class Collector

  # 探索基底パスを設定し初期化
  def initialize(root_path)
    # TODO : パス文字を意識せずに動くようにしたい...(windowsでも)
    # @root_path = root_path
    @path = Pathname.new(root_path)
  end

  # 基底パス配下を探索し、ファイルごとに受け取ったprocを呼ぶ
  def collect
    @path.each_child {|pathname|
      yield pathname
    }

    # Dir.glob("#{@root_path}/*").each {|filename|
    #   p "#{filename} -> #{File.ftype(filename)}"
    #   if File.file?(filename)
    #     yield filename
    #   end
    # }
  end
end