# app/models/task.rb
class Task < ApplicationRecord
    belongs_to :user
  
    validates :title, presence: true, length: { maximum: 40 }
    validates :description, length: { maximum: 100 }
    validates :due_date, presence: true
    validates :status, inclusion: { in: %w(Backlog In_Progress Done) }
  
    enum status: { Backlog: 0, In_Progress: 1, Done: 2 }
  end
  