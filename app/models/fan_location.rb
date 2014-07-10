class FanLocation < ActiveRecord::Base

  include ActiveModel::Serialization

  attr_accessor :updated, :occurences

  def attributes
    { :city => nil, :state => nil, :country_code => nil, :created => nil, :occurences => nil, :updated => '' }
  end

  def self.newest_three
    retarry = []
    rval = FanLocation.select("distinct(city) as city, state, country_code, max(created_at) as created_at, '' as occurences, '' as updated").group('city').order("created_at DESC").limit(3)
    blah = rval[0]
    puts 'rval is '
    puts rval.to_sql
    unless rval.size < 3
      retarry = FanLocation.select("count(*) as occurences, city").where("city in (?)", rval.collect { |e| e.city }).group("city, state, country_code")
      blah = retarry[0]
      #retarry.reverse
      if retarry.size == 3
        for i in 0..2
          #rval[i]['updated'] = rval[i]['created_at'].to_s.to_datetime.strftime("%m/%d/%Y")
          #puts rval[i]['created_at'].to_s
          #puts rval[i]['created_at'].to_s.to_datetime
          #d = puts rval[i]['created_at'].to_s.to_datetime.strftime("%m/%d/%Y")
          #rval[i]['updated'] = d
          d = rval[i]['created_at'].to_s.to_datetime.strftime("%m/%d/%Y").to_s
          rval[i]['updated'] = d
          rval[i]['created_at'] = rval[i]['created_at'].to_s.to_datetime.strftime("%m/%d/%Y").to_s
          puts rval[i]['updated'].to_s
          puts d
          puts rval[i]['created_at']
          puts rval[i]['updated'].class.to_s
          for j in 0..2
            if rval[i]['city'] == retarry[j]['city']
              rval[i]['occurences'] = retarry[j]['occurences'].to_i
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
    rval = FanLocation.select("count(*) as occurences, city, state, country_code, '' as created").group("city, state, country_code").order("occurences DESC").limit(3)
    rval.each do |fl|
      candidate = FanLocation.where(:city => fl.city, :state => fl.state, :country_code => fl.country_code).order("updated_at DESC").limit(1)
      #rval['updated'] = candidate['updated_at'] #.strftime("%m/%d/%Y").to_s 
    end
    if rval.size < 3
      rval[0] = FanLocation.new(:city => "San Francisco", :state => "CA",:occurences => '5', :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
      rval[1] = FanLocation.new(:city => "Los Angeles", :state => "CA", :occurences => '3', :country_code => "US", :updated  => Time.now.strftime("%m%d%Y"))
      rval[2] = FanLocation.new(:city => "Austin", :state => "TX", :occurences => '1', :country_code => "US", :updated => Time.now.strftime("%m%d%Y"))
    end
    return rval
  end

end
