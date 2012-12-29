require 'spec_helper'

describe LatitudeSphere::Scope do
  describe 'available scope methods' do
    it 'should define all_best' do
      LatitudeSphere::Scope.all_best.should eq('https://www.googleapis.com/auth/latitude.all.best')
    end

    it 'should define current_best' do
      LatitudeSphere::Scope.current_best.should eq('https://www.googleapis.com/auth/latitude.current.best')
    end

    it 'should define all_city' do
      LatitudeSphere::Scope.all_city.should eq('https://www.googleapis.com/auth/latitude.all.city')
    end

    it 'should define current_city' do
      LatitudeSphere::Scope.current_city.should eq('https://www.googleapis.com/auth/latitude.current.city')
    end
  end
end