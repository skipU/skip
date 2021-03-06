class Recruitment < ApplicationRecord
  acts_as_taggable
  acts_as_taggable_on :skills, :interests, :industries
  has_many :stocks, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :employment_entries, dependent: :destroy
  has_many :users, through: :entries
  belongs_to :company
  belongs_to :occupation
  has_many :entry_sheets
  has_many :staffs, through: :company
  enum category: {internship:0, employment:1, both:2}
  enum status: {draft:0, published:1, deleted:2}
  validates :status,
    presence: true
  validates :title,
    presence: true
  validates :body,
    presence: true
  # validates :deadline,
  #   presence: true
  validate :file_invalid?
  validates :prefecture,
  presence: true
  validates :city,
  presence: true
  validates :street,
  presence: true
  validates :capacity,
  presence: true
  # validates :schedule,
  # presence: true
  # validates :start_time,
  # presence: true
  # validates :end_time,
  # presence: true
  validates :culture,
  presence: true
  has_one :job

  # dataというパラメータがある場合に呼び出される。
  def data=(data)
    self.ctype = data.content_type
    self.photo = data.read
  end

  private
    def file_invalid?
      if self.photo
        ps = ['image/jpeg', 'image/gif', 'image/png']
        errors.add(:photo, 'は画像ファイルではありません。') if !ps.include?(self.ctype)
        errors.add(:photo, 'のサイズが1MBを超えています。') if self.photo.size > 1.megabyte
      end
    end
end