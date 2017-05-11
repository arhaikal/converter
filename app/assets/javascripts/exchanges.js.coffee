jQuery ->
  new (Morris.Line)(
    element: 'rates_chart'
    data: $('#rates_chart').data('rates')
    xkey: 'date'
    ykeys: [ 'rate' ]
    labels: [ 'Rate', 'Date' ])
