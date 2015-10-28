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
    mark_not_found @root_path
  end

  # 再帰的に登録していく
  def recursive_collect(pathname)
    if pathname.directory?
      pathname.each_child {|p|
        recursive_collect p
      }
    end

    if pathname.file?
      register @root_path, pathname
    end
  end

  # ファイル情報を登録。登録時にsha512によるハッシュ値を作成。
  # - 同一パスのデータが登録されていない + 同一ハッシュのファイルがない => 新規
  # - 同一パスのデータが登録されている + ハッシュが一致する => 登録済み（何もしない）
  # - 同一パスのデータが登録されている + ハッシュが一致しない => 更新されたとみなしハッシュ値だけ変更
  # - 同一パスのデータが登録されていない + 同一ハッシュのファイルがある => 移動後のディレクトリ検知。ディレクトリパスだけ変更。
  def register(root_path, pathname)
    # .から始まるファイルは隠しファイルとみなし処理しない
    return if pathname.basename.to_s.start_with?('.')

    relative_path = pathname.relative_path_from(root_path).to_s
    digest = Digest::SHA512.file(pathname.to_s).to_s

    # 同一パスのデータの登録有無を確認
    path_matched_file = Item.where(relative_path: relative_path).first

    # 存在する => hashがマッチするかどうかで判定
    if path_matched_file.present?
      return if path_matched_file.digest == digest

      # hashを更新
      path_matched_file.digest = digest
      path_matched_file.save

      p "hash changed : #{relative_path}"
    else
      # 同一hashのファイルが存在するか確認
      digest_matched_file = Item.where(digest: digest).first_or_initialize
      digest_matched_file.relative_path = relative_path
      digest_matched_file.digest = digest
      digest_matched_file.save

      p "register : #{relative_path}"
    end
  end


  # 登録済みの全データをチェックし、行方不明のものにはnot_foundマークを付与する
  def mark_not_found(root_path)
    Item.all.each do |item|
      path = root_path + item.relative_path

      item.not_found = !path.file?
      item.save
    end
  end
end