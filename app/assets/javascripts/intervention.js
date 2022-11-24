
$("#customer_company").change(function () {
    if($("#customer_company").find(":selected").text() == 'Select a customer'){
        $('#buildingcustomer').empty();
        $('#buildingcustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#buildingcustomer').prop("disabled", true);

        $('#batterycustomer').empty();
        $('#batterycustomer').prop("disabled", true)

    }         
    let id = $("#customer_company").find(":selected").val();
    console.log(id)          
    Rails.ajax({
        url: '/getBuildingByCustomer/' +id,
        type: "GET",  
    //   dataType: "json",
    //   data: {customer_id: customer},
        
        success: function(data){
            data.forEach((item) => {
                $("#buildingcustomer").append($('<option>',
                {
                    value: item.id,
                    text: item.id
                })); 
            });
            $('#buildingcustomer').prop("disabled", false);
        }, 
        error: function (data){ 
        }
    });
})

$("#buildingcustomer").change(function () {
    if($("#buildingcustomer").find(":selected").text() == 'Select a Building'){
        $('#batterycustomer').empty();
        // $('#buildingcustomer').append($('<option>',
        // {
        //     text: "None"
        // }));
        $('#batterycustomer').prop("disabled", true);
    

    } 
    let building = $("#buildingcustomer").find(":selected").val();
    // console.log("building :", building)
    // console.log(buildingcustomer.value)          
    Rails.ajax({
        // url: '/getBuildingByCustomer/' +id,
        url: '/getBatteryByBuilding/' +building,
        type: "GET",  
    //   dataType: "json",
    //   data: {customer_id: customer},
        
        success: function(data){
            data.forEach((item) => {
                $("#batterycustomer").append($('<option>',
                {
                    value: item.id,
                    text: item.id
                })); 
            });
            $('#batterycustomer').prop("disabled", false);
        }, 
        error: function (data){ 
        }
    });
})

$("#batterycustomer").change(function () {
    if($("#batterycustomer").find(":selected").text() == 'Select a Battery'){
        $('#columncustomer').empty();
        // $('#columncustomer').append($('<option>',
        // {
        //     text: "None"
        // }));
        $('#columncustomer').prop("disabled", true);
    } 
    $('#columncustomer').append($('<option>',
        {
            text: "None"
        }));
    let battery = $("#batterycustomer").find(":selected").val();
    Rails.ajax({
        url: '/getColumnByBattery/' +battery,
        type: "GET",  
    //   dataType: "json",
    //   data: {customer_id: customer},
        
        success: function(data){
            data.forEach((item) => {
                $("#columncustomer").append($('<option>',
                {
                    value: item.id,
                    text: item.id
                })); 
            });
            $('#columncustomer').prop("disabled", false);
        }, 
        error: function (data){ 
        }
    });
})

$("#columncustomer").change(function () {
    if($("#columncustomer").find(":selected").text() == 'Select a Column'){
        $('#elevatorcustomer').empty();
        // $('#columncustomer').append($('<option>',
        // {
        //     text: "None"
        // }));
        $('#elevatorcustomer').prop("disabled", true);
    } 
    $('#elevatorcustomer').append($('<option>',
        {
            text: "None"
        }));
    let column = $("#columncustomer").find(":selected").val();
    Rails.ajax({
        url: '/getElevatorByColumn/' +column,
        type: "GET",  
    //   dataType: "json",
    //   data: {customer_id: customer},
        
        success: function(data){
            data.forEach((item) => {
                $("#elevatorcustomer").append($('<option>',
                {
                    value: item.id,
                    text: item.id
                })); 
            });
            $('#elevatorcustomer').prop("disabled", false);
        }, 
        error: function (data){ 
        }
    });
})
    
    



