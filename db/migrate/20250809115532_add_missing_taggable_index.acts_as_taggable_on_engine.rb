# frozen_string_literal: true

# This migration comes from acts_as_taggable_on_engine (originally 4)
class AddMissingTaggableIndex < ActiveRecord::Migration[6.0]
    def up
    # 既に同じインデックスがあるなら何もしない
    return if index_exists?(:taggings, [:taggable_id, :taggable_type, :context],
                            name: "taggings_taggable_context_idx")

    add_index :taggings, [:taggable_id, :taggable_type, :context],
              name: "taggings_taggable_context_idx"
  end

  def down
    remove_index :taggings, name: "taggings_taggable_context_idx" if
      index_exists?(:taggings, [:taggable_id, :taggable_type, :context],
                    name: "taggings_taggable_context_idx")
  end

end
