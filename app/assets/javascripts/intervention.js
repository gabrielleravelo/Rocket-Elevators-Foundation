// Display the building of the selected customer
$("#customer_company").change(function () {
    if($("#customer_company").find(":selected").text() == 'Select a customer'){
        $('#buildingcustomer').empty();
        $('#buildingcustomer').append($('<option>',
        {
            text: "Select a Building"
        }));
        $('#buildingcustomer').prop("disabled", true);

        $('#batterycustomer').empty();
        $('#batterycustomer').append($('<option>',
        {
            text: "Select a Battery"
        }));
        $('#batterycustomer').prop("disabled", true)

        $('#columncustomer').empty();
        $('#columncustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#columncustomer').prop("disabled", true);

        $('#elevatorcustomer').empty();
        $('#elevatorcustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#elevatorcustomer').prop("disabled", true);

    }
    $('#buildingcustomer').empty();
    $('#buildingcustomer').append($('<option>',
    {
        text: "Select a Building"
    }));

        
    let id = $("#customer_company").find(":selected").val();
    console.log(id)          
    Rails.ajax({
        url: '/getBuildingByCustomer/' +id,
        type: "GET",  
         
        success: function(data){
            data.forEach((item) => {
                $("#buildingcustomer").append($('<option>',
                {
                    value: item.id,
                    text: item.buildingAddress
                })); 
            });
            $('#buildingcustomer').prop("disabled", false);
        }, 
        error: function (data){ 
        }
    });
})

// Display all batteries of the building selected
$("#buildingcustomer").change(function () {
    if($("#buildingcustomer").find(":selected").text() == 'Select a Building'){
        $('#batterycustomer').empty();
        $('#batterycustomer').append($('<option>',
        {
            text: "Select a Battery"
        }));
        $('#batterycustomer').prop("disabled", true);

        $('#columncustomer').empty();
        $('#columncustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#columncustomer').prop("disabled", true);

        $('#elevatorcustomer').empty();
        $('#elevatorcustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#elevatorcustomer').prop("disabled", true);
    
    }
    $('#batterycustomer').empty();
        $('#batterycustomer').append($('<option>',
        {
            text: "Select a Battery"
        }));
    
    let building = $("#buildingcustomer").find(":selected").val();
    Rails.ajax({
        url: '/getBatteryByBuilding/' +building,
        type: "GET",  
            
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

// // Display all columns of the battery selected 
$("#batterycustomer").change(function () {
    if($("#batterycustomer").find(":selected").text() == 'Select a Battery'){
        $('#columncustomer').empty();
        $('#columncustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#columncustomer').prop("disabled", true);
    } 
    
    let battery = $("#batterycustomer").find(":selected").val();
    Rails.ajax({
        url: '/getColumnByBattery/' +battery,
        type: "GET",  
           
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

// // Display all elevators of the column selected 
$("#columncustomer").change(function () {
    if($("#columncustomer").find(":selected").text() == 'None'){
        $('#elevatorcustomer').empty();
        $('#elevatorcustomer').append($('<option>',
        {
            text: "None"
        }));
        $('#elevatorcustomer').prop("disabled", true);
    } 
    
    let column = $("#columncustomer").find(":selected").val();
    Rails.ajax({
        url: '/getElevatorByColumn/' +column,
        type: "GET",  
           
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
    
    



