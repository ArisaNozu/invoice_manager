# frozen_string_literal: true

# This migration comes from acts_as_taggable_on_engine (originally 2)
class AddMissingUniqueIndices < ActiveRecord::Migration[6.0]
  # DDLをトランザクション外にしたい場合はコメントアウト解除
  # disable_ddl_transaction!

  def up
    # すでにユニークインデックスがあるなら何もしない
    if index_exists?(:tags, :name, name: "index_tags_on_name", unique: true)
      return
    end

    # 非ユニークの同名インデックスがある場合は落として作り直す
    if index_exists?(:tags, :name, name: "index_tags_on_name")
      remove_index :tags, name: "index_tags_on_name"
    end
    add_index :tags, :name, unique: true, name: "index_tags_on_name"

    # ※ taggings の複合ユニークインデックス（taggings_idx）は
    #   既存データの重複状況により失敗する可能性があるため、
    #   ここでは触りません（必要なら別マイグレーションで安全に追加します）
  end

  def down
    # このマイグレーションでは元に戻す操作は行いません
    # （必要であれば remove_index :tags, name: "index_tags_on_name" を検討）
  end
end