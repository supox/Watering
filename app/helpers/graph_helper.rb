module GraphHelper
	# show a graph with the time as the x label and data as the y label
	# Expected input : graph_data is an array of hash with keys :date and :value 
	def show_graph( graph_data, graph_title )
    content_for(:head, javascript_include_tag("highcharts.js"))
  
    values = graph_data.sort{ |x,y| x[:date].to_i <=> y[:date].to_i}.collect{|d| [d[:date].to_i*1000, d[:value]]}
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:title][:text] = graph_title
      f.options[:chart] = {:defaultSeriesType =>"area", :inverted => false, :zoomType => 'x', spacingRight:20}
      f.options[:legend] = {:layout => "horizontal", :borderWidth => "0"}
      f.options[:plotOptions] = {
                area: {
                    fillColor: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, "#4572A7"],
                            [1, "white"]
                        ]
                    },
                    lineWidth: 1,
                    marker: {
                        enabled: false
                    },
                    shadow: false,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    threshold: nil
                }
            }
      
      f.options[:rangeSelector] = {
        :buttons => (1..7).collect{|i| {count: i, type: 'days', text:"#{i} day"} },        
        :selected => 1
      }      
      f.options[:tooltip][:formatter] = %|
        function() {
          return '<div>'+ Highcharts.dateFormat('%d %b %H:%M',this.x) + '<br>'
          + '<b>' + this.y +'</b></div>';
        }|.js_code
      f.series(:name => 'Readings', :color => "#0000b0", :data => values)
      f.options[:xAxis] =
      {
          :minTickInterval => 24*3600 * 1000, :type => "datetime", :dateTimeLabelFormats => { day: "%b %e"}, :title => { :text => nil },
          :labels => {
            :formatter => %|
             function() {
              return Highcharts.dateFormat('%d %b %H:%M', this.value);
             }|.js_code
          }
      }
   
    end
    render 'shared/graph'
  end
  
  # Same as show_graph, but render a js update code instead.
  # Expected input : graph_data is an array of hash with keys :date and :value 
  def update_graph( graph_data, graph_title )
    @data = graph_data.sort{ |x,y| x[:date].to_i <=> y[:date].to_i}.collect{|d| [d[:date].to_i*1000, d[:value]]}
    render 'shared/graph'
  end
end
