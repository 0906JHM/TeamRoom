

function createBarChart(data, chartId) {
    var colors = ["#4b77a9", "#5f255f", "#d21243", "#ff5733", "#ffcc29", "#6bf178", "#854c6f", "#ff9933", "#6699cc", "#ff6666"];

    var bar_ctx = document.getElementById(chartId).getContext('2d');

	// 이전 차트를 제거합니다.
    var existingChart = Chart.getChart(chartId);
    if (existingChart) {
      existingChart.destroy();
    }

	// JSON 형태의 데이터 배열에서 최대 값을 찾습니다.
	var maxDataValue = Math.max.apply(null, data.map(function (item) {
    					return item.data;
						}));
						
	var max = Math.ceil(maxDataValue * 1.2); // 최대 값을 1.2배로 설정					

	var stepSize = Math.ceil(maxDataValue / 10); // 원하는 눈금 간격 설정

    var bar_data = {
        datasets: [{
            data: data.map(function (item) {
                return item.data;
            }),
            backgroundColor: colors.slice(0, data.length)
        }],
        labels: data.map(function (item) {
        return item.label;
      }),
        borderColor: "#fff"
    };
    
	var bar_options = {
        plugins: {
            tooltip: {
                titleFont: {
                    size: 20
                },
                bodyFont: {
                    size: 20
                },
                footerFont: {
                    size: 20
                },
                mode: 'nearest',
                intersect: true
            },
            datalabels: {
                color: '#black',
                anchor: 'end',
                align: 'top',
                offset: 0,
                font: {
                    size: 20
                }
            },
            legend: {
                display: false
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                max: max,
                stepSize: stepSize
            },
            x: {}
        }
    };

	// 새로운 차트를 생성하고 이전 차트를 업데이트합니다.
  	 new Chart(bar_ctx, {
        type: 'bar',
        data: bar_data,
        options: bar_options,
        plugins: [ChartDataLabels]
    });
}


