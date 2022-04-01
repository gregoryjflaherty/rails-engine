class Merchant < ApplicationRecord
  has_many :items

  def self.search_name(name)
    where('name ILIKE ?', "%#{name}%").first
  end

  def self.search_all_names(name)
    where('name ILIKE ?', "%#{name}%").limit(18).order(:name)
  end
end
