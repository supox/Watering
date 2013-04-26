module GraphHelper
	# show a graph with the time as the x label and data as the y label
	# Expected input : graph_data is an array of hash with keys :date and :value 
	def show_graph( graph_data, graph_title )
    content_for(:head, javascript_include_tag("highcharts.js"))
  
    values = graph_data.sort{ |x,y| x[:date].to_i <=> y[:date].to_i}.collect{|d| [d[:date].to_i*1000, d[:value]]}
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.options[:title][:text] = graph_title
      f.options[:chart][:defaultSeriesType] = "area"
      f.options[:chart][:inverted] = false
      f.options[:chart][:zoomType] = 'x'
      f.options[:legend][:layout] = "horizontal"
      f.options[:legend][:borderWidth] = "0"
      f.options[:tooltip][:formatter] = %|
        function() {
          return '<div>'+ Highcharts.dateFormat('%d %b %H:%M',this.x) + '<br>'
          + '<b>' + this.y +'</b></div>';
        }|.js_code
      f.series(:name => 'Readings', :color => "#b00000", :data => values)
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
