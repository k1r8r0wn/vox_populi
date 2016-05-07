class City < ActiveRecord::Base

  scope :find_default_city, -> { find_or_create_by(name: 'Moscow') }

  has_many :themes, dependent: :destroy

  validates :name, :ru_name, presence: true

  # TODO: Move into service
  def self.find_by_ip(ip = nil)
    return City.find_default_city if ip.blank?

    db = SypexGeo::Database.new('./db/geolocation/SxGeoCity.dat')
    location = db.query(ip)

    city = find_by_name(location.city[:name_en]) if location && location.city.present?
    return city if city

    City.find_default_city
  end

end
