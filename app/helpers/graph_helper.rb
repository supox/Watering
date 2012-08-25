module GraphHelper
	# show a graph with the time as the x label and data as the y label
	# Expected input : graph_data is an array of hash with keys :date and :value 
	def show_graph( graph_data, graph_title )
	  if(!@has_put_js)
	   content_for(:head, javascript_include_tag("http://www.google.com/jsapi"))
	   # content_for(:head, javascript_include_tag("graphs.js"))
	   @has_put_js = true;
	  end
    render 'shared/graph', data: graph_data, title:graph_title
  end
  
  # Same as show_graph, but render a js update code instead.
  # Expected input : graph_data is an array of hash with keys :date and :value 
  def update_graph( graph_data, graph_title )
    render 'shared/graph', data: graph_data, title:graph_title
  end
end
