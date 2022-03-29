$( document ).ready(function() {


    setInputFilter(document.getElementById("rescount"), function (value) {
        return /^\d*$/.test(value);
    });

    setInputFilter(document.getElementById("getrescount"), function (value) {
        return /^\d*$/.test(value);
    });

    $('#sendResource').change(function(){
        let disableRes = $(this).val();
        $('#getResource option').each(function(){
            $(this).removeAttr('disabled');
        });
        $('#getResource option[value='+disableRes+']').attr('disabled', 'disabled');

    });

    $('.trader-buy-button').on('click',function(){

        let buyerAmount = $(this).prev().val();
        buyerAmount = (buyerAmount == "undefined" || buyerAmount == "" ) ? 0 : buyerAmount;
    });


    $('.buyAmount').on('keyup', function(){

        var id = $(this).attr('id');
        var tradecontainer = $('player_trade_' + id);


    });


});

function setInputFilter(textbox, inputFilter) {
    var el = textbox;
    ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function (event) {
        if (el) {
            textbox.addEventListener(event, function () {
                if (inputFilter(this.value)) {
                    this.oldValue = this.value;
                    this.oldSelectionStart = this.selectionStart;
                    this.oldSelectionEnd = this.selectionEnd;
                } else if (this.hasOwnProperty("oldValue")) {
                    this.value = this.oldValue;
                    this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                } else {
                    this.value = "";
                }
            });
        }
    });
}