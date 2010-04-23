module Admin::StatsHelper

  def stats_graph( stats )    
    #     bc = GoogleChart::BarChart.new('800x200', "Bar Chart", :vertical, false)
    #     bc.data "Trend 1", [5,4,3,1,3,5], '0000ff'     
    labels = []
    0.upto(16) do |day|
      if day == 0
        labels << "Today"
      elsif day == 6
        labels << "1 week ago"
      elsif day == 13
        labels << "2 weeks ago"
      else
        labels << ""
      end
    end
    chart = GoogleChart::BarChart.new('600x200', "Visits per day", :vertical, false) do |bc|
      bc.data "Hits", stats, '0000ff'     
      bc.axis :x, :labels => labels
      bc.axis :y, :labels => ["", stats.max.to_s]
    end
    image_tag chart.to_url, :alt => ''
  end
  
end
