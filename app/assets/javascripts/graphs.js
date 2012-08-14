function drawChart( div_id ) {
	var data = new google.visualization.DataTable();
	data.addColumn('datetime', 'Date');
	data.addColumn('number', graph_y_title);
	for( key in graphRows )
	{
		data.addRow( [new Date( graphRows[key].date ), graphRows[key].value] );
	}
	var chart = new google.visualization.AnnotatedTimeLine(document.getElementById(div_id));
	chart.draw(data, {
		displayAnnotations : true,
		displayZoomButtons : false,
		displayRangeSelector: false
	});
}
