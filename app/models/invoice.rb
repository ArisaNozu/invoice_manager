class Invoice < ApplicationRecord

belongs_to :user
belongs_to :client
acts_as_taggable_on :tags




end
