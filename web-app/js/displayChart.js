/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 7/2/13
 * Time: 12:23 PM
 * To change this template use File | Settings | File Templates.
 */

function drawPieChart(data,chartType,heading){

    $('#leftDiv').show()

    if(chartType=="Pie"){
        $('#chartDiv').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: heading+' Pie Chart'

            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>',
                percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },

            series: [{
                type: 'pie',
                name: 'Total Revenue',
                data: [

                    data [0],
                    data [1],
                    data [2],
                    data [3],
                    data [4],
                    data [5]

                ]
            }]
        });
    }

    else if(chartType=="Bar" && heading!="License Collection"){

        $('#chartDiv').highcharts({
            chart: {
                type: 'bar'
//                defaultSeriesType: chartType
            },
            title: {
                text:  heading+' Bar Chart'
            },
            xAxis: {
                categories: ['Districts' ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total Revenue',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: 'millions'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend:{ layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 40,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },

            series: [{

                name: [data[0][0]],
                data: [data[0][1]]
            },
                {
                name: [data[1][0]],
                data: [data[1][1]]
            },
                {
                    name: [data[2][0]],
                    data: [data[2][1]]
                } ,
                {
                    name: [data[3][0]],
                    data: [data[3][1]]
                },
                {
                    name: [data[4][0]],
                    data: [data[4][1]]
                } ,
                {
                    name: [data[5][0]],
                    data: [data[5][1]]
                }



            ]
        });
    }
    else if (chartType=="Bar" && heading=="License Collection"){

        $('#chartDiv').highcharts({
            chart: {
                type: 'bar'
//                defaultSeriesType: chartType
            },
            title: {
                text:  heading+' Bar Chart'
            },
            xAxis: {
                categories: ['Districts' ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total Revenue',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: 'millions'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend:{ layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 40,
                floating: true,
                borderWidth: 1,
                backgroundColor: '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Total Revenue',
                data: [
                    data [0],
                    data [1],
                    data [2],
                    data [3],
                    data [4],
                    data [5]


                ]
            }]





        });
    }
    else{

        $('#chartDiv').highcharts({
            chart: {
                zoomType: 'x',
                spacingRight: 20
            },
            title: {
                text:  heading + ' TimeLine Chart'
            },
            xAxis: {
                type: 'datetime',
                maxZoom: 14 * 24 * 3600000, // fourteen days
                title: {
                    text: null
                }
            },
            yAxis: {
                title: {
                    text: 'Excise amount'
                }
            },
            tooltip: {
                shared: true
            },
            legend: {
                enabled: false
            },
            plotOptions: {
                area: {
                    fillColor: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                        stops: [
                            [0, Highcharts.getOptions().colors[0]],
                            [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
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
                    threshold: null
                }
            },

            series: [{
                type: 'area',
                name: 'Total Revenue',
                pointInterval: 24 * 3600 * 1000,
                pointStart: Date.UTC(2006, 0, 01),
                data: [
                    data [0],
                    data [1],
                    data [2],
                    data [3],
                    data [4],
                    data [5]


                ]
            }]
        });



    }

}
