require 'rails_helper'

describe City, type: :model do

  context 'relationships' do
    it { should have_many(:themes).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_presence_of :title }
  end

  describe '.find_by_ip' do
    subject { City.find_by_ip(ip) }

    let!(:default_city) { create(:city, title: 'Москва') }
    let!(:city) { create(:city, title: 'СПБ') }
    let(:sypex_geo) { instance_double(SypexGeo::Database) }
    let(:location) { instance_double(SypexGeo::Result) }

    context 'when ip present' do
      let(:ip) { '37.204.57.162' }
      let(:location_city) { { id: 123, name_ru: 'СПБ' }  }

      before do
        expect(SypexGeo::Database).to receive(:new).and_return(sypex_geo)
        expect(sypex_geo).to receive(:query).and_return(location)
      end

      it 'should find current city' do
        expect(location).to receive(:city).twice.and_return(location_city)

        expect(subject).to eq city
      end

      context 'when not find city from database' do
        let(:ip) { '127.0.0.1' }
        let(:location_city) { nil }

        it 'should return default city' do
          expect(location).to receive(:city).and_return(location_city)

          expect(subject).to eq default_city
        end
      end
    end

    context 'when ip not present' do
      let(:ip) { nil }
      let(:location_city) { nil }

      it { expect(subject).to eq default_city }
    end
  end
end
