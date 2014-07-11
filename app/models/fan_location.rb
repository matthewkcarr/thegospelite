class FanLocation < ActiveRecord::Base

  include ActiveModel::Serialization

  attr_accessor :updated, :occurences

  def attributes
    { :city => nil, :state => nil, :country_code => nil, :created_at => nil, :occurences => nil, :updated => '' }
  end

  def self.newest_three
    retarry = []
    rval = FanLocation.select("distinct(city) as city, state, country_code, max(created_at) as created_at").group('city').order("created_at DESC").limit(3)
    blah = rval[0] #force arel to give back data here
    unless rval.size < 3
      retarry = FanLocation.select("count(*) as occurences, city").where("city in (?)", rval.collect { |e| e.city }).group("city, state, country_code")
      blah = retarry[0] #force arel to give back data again here
      if retarry.size == 3
        for i in 0..2
          d = rval[i]['created_at'].to_s.to_datetime.strftime("%m/%d/%Y").to_s
          rval[i].updated = d
          for j in 0..2
            if rval[i]['city'] == retarry[j]['city']
              rval[i].occurences = retarry[j]['occurences'].to_i
            end
          end
        end
      end
    end
    if rval.size < 3
      rval[0] = FanLocation.new(:city => "San Francisco", :state => "CA",:occurences => '5', :country_code => "US", :updated => Time.now.strftime("%m/%d/%Y"))
      rval[1] = FanLocation.new(:city => "Los Angeles", :state => "CA", :occurences => '2', :country_code => "US", :updated  => Time.now.strftime("%m/%d/%Y"))
      rval[2] = FanLocation.new(:city => "Austin", :state => "TX", :occurences => '1', :country_code => "US", :updated => Time.now.strftime("%m/%d/%Y"))
    end
    return rval
  end

  def self.top_three
    rval = FanLocation.select("count(*) as occurence, city, state, country_code, created_at").group("city, state, country_code").order("occurence DESC").limit(3)
    blah = rval[0]
    rval.each do |fl|
      fl.occurences = fl['occurence'].to_i
    end
    if rval.size < 3
      rval[0] = FanLocation.new(:city => "San Francisco", :state => "CA",:occurences => '5', :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
      rval[1] = FanLocation.new(:city => "Los Angeles", :state => "CA", :occurences => '3', :country_code => "US", :updated  => Time.now.strftime("%m%d%Y"))
      rval[2] = FanLocation.new(:city => "Austin", :state => "TX", :occurences => '1', :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
    end
    return rval
  end

end
