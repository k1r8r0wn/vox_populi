class City < ActiveRecord::Base
  scope :find_default_city, -> { find_or_create_by(title: I18n.t('cities.default.title')) }
  scope :find_by_title, -> (title) { find_by(title: title) }

  has_many :themes, dependent: :destroy

  validates :title, presence: true

  def self.find_by_ip(ip = nil)
    return City.find_default_city if ip.blank?

    db = SypexGeo::Database.new('./db/geolocation/SxGeoCity.dat')
    location = db.query(ip)

    city = find_by_title(location.city[:name_ru]) if location && location.city.present?
    return city if city

    City.find_default_city
  end
end
