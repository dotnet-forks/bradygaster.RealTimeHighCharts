<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RealTimeHighCharts.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div id="container" style="width:100%; height:400px;"></div>

    <script src="Scripts/jquery-1.6.4.js"></script>
    <script src="Scripts/jquery.signalR-2.1.2.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script type="text/javascript">
        $(function () {
            var con = $.hubConnection();
            var hub = con.createHubProxy('chartingHub');
            hub.on('updateChart', function (chartBit) {
                var c = {
                    chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: 1,
                        plotShadow: false
                    },
                    title: {
                        text: chartBit.QuestionCode
                    },
                    tooltip: {
                        pointFormat: '{series.name}:'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            dataLabels: {
                                enabled: true,
                                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            }
                        }
                    },
                    series: [{
                        type: 'pie',
                        name: chartBit.QuestionCode,
                        data: [
                            ['Answer1', chartBit.Answer1],
                            ['Answer2', chartBit.Answer2],
                            ['Answer3', chartBit.Answer3],
                            ['Answer4', chartBit.Answer4],
                            ['Answer5', chartBit.Answer5]
                        ]
                    }]
                };

                $('#container').highcharts(c);
            });
            con.start();
        });
    </script>
</body>
</html>
