class Blog < ApplicationRecord
    validates :title, :body, :author, presence: true
end
