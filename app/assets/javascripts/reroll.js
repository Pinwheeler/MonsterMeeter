$( document ).ready(function() {
    $( ".button.reroll" ).click(function(event) {
        var reroll_id = event.target.id;
        var reroll_num = reroll_id.match(/([0-9]+)/)[0];
        var party_cr = $("#party-cr-field").attr('value');
        var terrains = terrainsArray();
        var passed_data = {
                            "reroll_num": reroll_num,
                            "party_cr": party_cr,
                            "terrains": terrains
        }
        console.log ("re rolling row: "+ reroll_num);
        $.get("/encounter_table/reroll", passed_data).done(function(data){
            var encounter_id = "#encounter_" + reroll_num;
            var cr_id = "#cr_" + reroll_num;
            var xp_id = "#xp_" + reroll_num;
            $(encounter_id).val(data['string']);
            $(cr_id).val(data['cr']);
            $(xp_id).val(data['xp']);
        });
    });
    
    function terrainsArray() {
        var terrainsList = [];
        $(".terrain-list li input").each( function() {
            if (this.checked) {
                terrainsList.push(this.name)
            }
        });
        return terrainsList;
    }
});