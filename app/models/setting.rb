class Setting < ActiveRecord::Base
  validate :writable_path

  # 基底パスがアクセス可能なディレクトリであることを確認する
  def writable_path
    path = Pathname.new(root_path)

    if path.nil? || !path.directory? || !path.writable_real?
      errors.add(:writable_path, "ベースパスは存在する書き込み可能ディレクトリである必要があります。")
    end
  end
end
