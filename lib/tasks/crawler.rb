require "collector.rb"

# ファイル収集バッチ本体
class Tasks::Crawler
  # クローリングの実行
  def self.run
    setting = Setting.first

    if setting.nil?
      p "setting not find"
    end

    collector = Collector.new setting.root_path

    collector.collect
  end
end