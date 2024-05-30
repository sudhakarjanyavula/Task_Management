# app/models/task.rb
class Task < ApplicationRecord
    belongs_to :user
  
    validates :title, presence: true, length: { maximum: 40 }
    validates :description, length: { maximum: 100 }
    validates :due_date, presence: true
    validates :status, inclusion: { in: %w(Backlog In Progress Done) }
  
    enum status: ["Backlog", "In Progress", "Done"]
  end
  