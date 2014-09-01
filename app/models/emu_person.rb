class EmuPerson < ActiveRecord::Base
  DEFAULT_SEGMENT = 50
  DEFAULT_PERCENTILE = 10

  def self.frequency_data(segment = DEFAULT_SEGMENT)
    segment = segment.to_i
    segment = DEFAULT_SEGMENT if segment <= 0
    result = EmuPerson.connection.execute("SELECT count / #{segment} as floor_count, count(*) 
                                           FROM emu_people 
                                           GROUP BY floor_count
                                           ORDER BY floor_count")
    data = []
    result.each do |item|
      data << {segment: item["floor_count"].to_i*segment, count: item["count"].to_i }
    end
    data
  end


  #{"ntile"=>"1", "avg"=>"1.00000000000000000000", "max"=>"1", "min"=>"1", "total"=>"3629"}
  #{"ntile"=>"2", "avg"=>"1.00000000000000000000", "max"=>"1", "min"=>"1", "total"=>"3629"}
  #{"ntile"=>"3", "avg"=>"1.00000000000000000000", "max"=>"1", "min"=>"1", "total"=>"3629"}
  #{"ntile"=>"4", "avg"=>"1.00000000000000000000", "max"=>"1", "min"=>"1", "total"=>"3628"}
  #{"ntile"=>"5", "avg"=>"1.9878721058434399", "max"=>"2", "min"=>"1", "total"=>"7212"}
  #{"ntile"=>"6", "avg"=>"2.5931642778390298", "max"=>"3", "min"=>"2", "total"=>"9408"}
  #{"ntile"=>"7", "avg"=>"4.3718302094818082", "max"=>"6", "min"=>"3", "total"=>"15861"}
  #{"ntile"=>"8", "avg"=>"8.5143329658213892", "max"=>"13", "min"=>"6", "total"=>"30890"}
  #{"ntile"=>"9", "avg"=>"23.2147188533627343", "max"=>"42", "min"=>"13", "total"=>"84223"}
  #{"ntile"=>"10", "avg"=>"416.7130650496141125", "max"=>"24979", "min"=>"42", "total"=>"1511835"}

  def self.frequency_by_percent(percentile = DEFAULT_PERCENTILE)
    percentile = percentile.to_i
    percentile = DEFAULT_PERCENTILE if percentile <= 0
    segment = 100/percentile

    result = EmuPerson.connection.execute("SELECT ntile, ntile * 100/#{segment} as perc,
                      avg(count) AS avg, max(count) AS max, min(count) AS min, sum(count) AS total
                      FROM (SELECT count, ntile(#{segment}) OVER (ORDER BY count) AS ntile FROM emu_people) x
                      GROUP BY ntile ORDER BY ntile")

    data = []
    result.each do |item|
      item.keys.each do |k|
        item[k] = item[k].to_f
      end
      item = HashWithIndifferentAccess.new(item)
      data << item
    end
    data
  end
end

