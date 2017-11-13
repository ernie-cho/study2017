
<html>
<head></head>
<body>
<script type="text/javascript" src="js/Chart.js"></script>
<canvas id="myChart"></canvas>
<script>
Chart.pluginService.register({
  afterDraw: function(chart) {
    if (chart.config.options.elements.center) {
      var helpers = Chart.helpers;
      var centerX = (chart.chartArea.left + chart.chartArea.right) / 2;
      var centerY = (chart.chartArea.top + chart.chartArea.bottom) / 2;

      var ctx = chart.chart.ctx;
      ctx.save();
      var fontSize = helpers.getValueOrDefault(chart.config.options.elements.center.fontSize, Chart.defaults.global.defaultFontSize);
      var fontStyle = helpers.getValueOrDefault(chart.config.options.elements.center.fontStyle, Chart.defaults.global.defaultFontStyle);
      var fontFamily = helpers.getValueOrDefault(chart.config.options.elements.center.fontFamily, Chart.defaults.global.defaultFontFamily);
      var font = helpers.fontString(fontSize, fontStyle, fontFamily);
      ctx.font = font;
      ctx.fillStyle = helpers.getValueOrDefault(chart.config.options.elements.center.fontColor, Chart.defaults.global.defaultFontColor);
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(chart.config.options.elements.center.text, centerX, centerY);
      ctx.restore();
    }
  },
})


var config = {
  type: 'doughnut',
  data: {
    labels: [
      "Red",
      "Green",
      "Yellow"
    ],
    datasets: [{
      data: [300, 50, 100],
      backgroundColor: [
        "#FF6384",
        "#36A2EB",
        "#FFCE56"
      ],
      hoverBackgroundColor: [
        "#FF6384",
        "#36A2EB",
        "#FFCE56"
      ]
    }]
  },
  options: {
    elements: {
      center: {
        text: 'Hello',
        fontColor: '#111111',
        fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
        fontSize: 24,
        fontStyle: 'normal'
      }
    }
  }
};


var ctx = document.getElementById("myChart").getContext("2d");
var myChart = new Chart(ctx, config);

</script>
</body>
</html>