//= require helpers/timepicker

  var regional = 'en'
  function updateForm() {
  	updateValves();
  	
    var hasFaded = false;
    val = $("#sprinkler_plan_repeat").val();
    $("#sprinkler_plan_repeat option").each(function(value){
      if( $("#"+this.value).is(":visible") ) {
        $("#"+this.value).fadeOut('normal',function() {
          $("#" + val).fadeIn();
        });
        hasFaded = true;
      }
    });
    if(!hasFaded)
      $("#" + val).fadeIn();
  }
  $(document).ready(function() {
    $("#sprinkler_plan_repeat").change(function() {
      updateForm();
    });

    for (dayIndex in weekly) {
      $("#sprinkler_plan_weekly_" + weekly[dayIndex] ).prop("checked", true);
    }
    var beginDate = new Date();
    beginDate.setDate(1);
    var endDate = new Date();
    endDate.setDate(31);
    $.datepicker.regional[regional];
    $.timepicker.setDefaults($.timepicker.regional[regional]);
    
    $("#div_day_of_month").datepicker( {altField: "#sprinkler_plan_day_of_month", altFormat: "d", minDate:beginDate , maxDate: endDate, defaultDate: currentDate } );
    
    // create start time      
    $("#sprinkler_plan_start_date").datetimepicker({dateFormat: 'dd/mm/yy', defaultDate: currentDate});
    $("#sprinkler_plan_start_date").datepicker("setTime", startDate);
    
    // create end time
    $("#sprinkler_plan_end_date").datetimepicker({dateFormat: 'dd/mm/yy', defaultDate: currentDate});
    
    updateForm();
    
    $("input:reset").click(function() {
      this.form.reset();
      updateForm();
      return false; // prevent reset button from resetting again
    });
  });

  function updateDestroyField(checked, id){
    var elm = $("#sprinkler_plan_valf_destroy_"+id);
    elm.val(checked);  
  }
  function updateIrrigationDiv(checked, id){
    var elm = $("#div_sprinkler_plan_valf_ids_"+id);
    elm.stop(true,true);
    if(checked)
      elm.fadeIn();
    else
      elm.fadeOut();
  }
  function updateValves(){
    for(id_index in valf_ids){
      var id = valf_ids[id_index];
      var checked = $("#checkbox_valf_" + id ).is(':checked');
      updateDestroyField(!checked, id);
      updateIrrigationDiv(checked, id);
    }
  }
  