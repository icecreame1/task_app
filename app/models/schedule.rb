class Schedule < ApplicationRecord
  validates :title, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  validate :start_day_check
  validate :end_day_check

  def start_day_check
    if start_day.blank?
      return
    elsif start_day < Date.today - 1
      errors.add(:start_day,"は今日以降の日付を選択して下さい")
    end
  end

  def end_day_check
    if end_day.blank?
      return
    elsif end_day < start_day - 1
      errors.add(:end_day,"は開始日以降の日付を選択して下さい") 
    end
  end
  
end
