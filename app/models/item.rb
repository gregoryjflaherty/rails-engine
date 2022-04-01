class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.search_name(name)
    where('name ILIKE ?', "%#{name}%").first
  end

  def self.search_all_names(name)
    where('name ILIKE ?', "%#{name}%").limit(18).order(:name)
  end

  def self.search_by_min_price(price)
    where('unit_price >= ?', price.to_f).order(:name).first
  end

  def self.search_by_max_price(price)
    where('unit_price <= ?', price.to_f).order(:name).first
  end

  def self.between_range(min, max)
    where('unit_price >= ? AND unit_price <= ?', min.to_f, max.to_f).order(:name).first
  end

  def get_invoices

    invoices.joins(:items).select('invoices.*, count(items.*)')
    .group('invoices.id').having('count(items.*) = 1').pluck(:id)
  end
end
