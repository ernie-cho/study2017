
window.chartColors = {
	red: 'rgb(255, 71, 110)',
	orange: 'rgb(255, 192, 0)',
	yellow: 'rgb(255, 205, 86)',
	green: 'rgb(75, 192, 192)',
	blue: 'rgb(54, 162, 235)',
	purple: 'rgb(153, 102, 255)',
	grey: 'rgb(201, 203, 207)'
};



//랜덤 숫자 생성
var randomScalingFactor = function () {
	return Math.round(Math.random() * 100);
};
var randomScalingFactor2 = function () {
	return Math.round(Math.random() * 100);
};

//각 서버의 데이터용 변수
var serv1_cpu = randomScalingFactor(), serv1_mem = randomScalingFactor(), serv1_disk = randomScalingFactor();
var serv2_cpu = randomScalingFactor(), serv2_mem = randomScalingFactor(), serv2_disk = randomScalingFactor();
var serv3_cpu = randomScalingFactor(), serv3_mem = randomScalingFactor(), serv3_disk = randomScalingFactor();
var serv4_cpu = randomScalingFactor(), serv4_mem = randomScalingFactor(), serv4_disk = randomScalingFactor();
var serv5_cpu = randomScalingFactor(), serv5_mem = randomScalingFactor(), serv5_disk = randomScalingFactor();
var serv6_cpu = randomScalingFactor(), serv6_mem = randomScalingFactor(), serv6_disk = randomScalingFactor();


Chart.pluginService.register({
	beforeDraw: function (chart) {
		var width = chart.chart.width,
		height = chart.chart.height,
		ctx = chart.chart.ctx;

		ctx.restore();
		var fontSize = (height / 114).toFixed(2);
		ctx.font = fontSize + "em sans-serif";
		ctx.textBaseline = "middle";
		//Text color
		ctx.fillStyle = "#FFFFFF";

		var dataType = chart.config.options.dataType;
		var text = dataType,
		textX = Math.round((width - ctx.measureText(text).width) / 2),
		textY = height / 7 * 3;

		ctx.fillText(text, textX, textY);
		
		var valueString = chart.config.data.datasets[0].data[0];
		var text = valueString + "%",
		textX = Math.round((width - ctx.measureText(text).width) / 2),
		textY = height / 7 * 4;

		ctx.fillText(text, textX, textY);

		ctx.save();

	}
});
//////////server1/////////////
if(serv1_cpu >= 70){
		var config1 = {
		type: 'doughnut',
		data: {
			datasets: [{
					data: [
						serv1_cpu,
						100-serv1_cpu,

					],
					backgroundColor: [
						window.chartColors.red,
						window.chartColors.grey,
					],
					borderColor: [
						"#FF476E", //핑크
						"#C9CBCF" //회색
					],
					borderWidth: [
						1, 1
					],
					label: 'Dataset 1'
				}
			],
		},
		options: {
			dataType: "CPU",
			responsive: true,
			cutoutPercentage: 85

		}
	};
}else if(serv1_cpu >= 50){
		var config1 = {
		type: 'doughnut',
		data: {
			datasets: [{
					data: [
						serv1_cpu,
						100-serv1_cpu,

					],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
					borderWidth: [
						1, 1
					],
					label: 'Dataset 1'
				}
			],
		},
		options: {
			dataType: "CPU",
			responsive: true,
			cutoutPercentage: 85

		}
	};
}else {
		var config1 = {
		type: 'doughnut',
		data: {
			datasets: [{
					data: [
						serv1_cpu,
						100-serv1_cpu,

					],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
					borderWidth: [
						1, 1
					],
					label: 'Dataset 1'
				}
			],
		},
		options: {
			dataType: "CPU",
			responsive: true,
			cutoutPercentage: 85

		}
	};
}

if(serv1_mem >= 70){
	var config2 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv1_mem,
					100-serv1_mem,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,
				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

	}
};
}
else if(serv1_mem >= 50){
	var config2 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv1_mem,
					100-serv1_mem,

				],
				backgroundColor: [
					window.chartColors.orange,
					window.chartColors.grey,
				],
				borderColor: [
					"#FFC000", //주황
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

	}
};
}
else {
	var config2 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv1_mem,
					100-serv1_mem,

				],
				backgroundColor: [
					window.chartColors.green,
					window.chartColors.grey,
				],
				borderColor: [
					"#4BC0C0", //녹색
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

	}
};}

if(serv1_disk >= 70){
	var config3 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv1_disk,
					100-serv1_disk,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,

				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

	}
};}
else if(serv1_disk >= 50){
	var config3 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv1_disk,
					100-serv1_disk,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],

				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

	}
};
}
else {
	var config3 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv1_disk,
					100-serv1_disk,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

	}
};
}




//////////server2//////////////
if(serv2_cpu >= 70){
	var config4 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_cpu,
					100-serv2_cpu,

				],

					backgroundColor: [
						window.chartColors.red,
						window.chartColors.grey,
					],
					borderColor: [
						"#FF476E", //핑크
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else if(serv2_cpu >= 50){
	var config4 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_cpu,
					100-serv2_cpu,

				],
				
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else {
	var config4 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_cpu,
					100-serv2_cpu,

				],
				backgroundColor: [
					window.chartColors.green,
					window.chartColors.grey,
				],
				borderColor: [
					"#4BC0C0", //녹색
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}

if(serv2_mem >= 70){
	var config5 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_mem,
					100-serv2_mem,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,
				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv2_mem >= 50){
	var config5 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_mem,
					100-serv2_mem,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config5 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_mem,
					100-serv2_mem,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80
		}
	};
}
if(serv2_disk >= 70){
	var config6 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_disk,
					100-serv2_disk,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,

				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv2_disk >= 50){
	var config6 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_disk,
					100-serv2_disk,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config6 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv2_disk,
					100-serv2_disk,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}

//////////server3//////////////
if(serv3_cpu >= 70){
	var config7 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_cpu,
					100-serv3_cpu,

				],

					backgroundColor: [
						window.chartColors.red,
						window.chartColors.grey,
					],
					borderColor: [
						"#FF476E", //핑크
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else if(serv3_cpu >= 50){
	var config7 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_cpu,
					100-serv3_cpu,

				],
				
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else {
	var config7 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_cpu,
					100-serv3_cpu,

				],
				backgroundColor: [
					window.chartColors.green,
					window.chartColors.grey,
				],
				borderColor: [
					"#4BC0C0", //녹색
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}

if(serv3_mem >= 70){
	var config8 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_mem,
					100-serv3_mem,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,
				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv3_mem >= 50){
	var config8 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_mem,
					100-serv3_mem,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config8 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_mem,
					100-serv3_mem,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80
		}
	};
}
if(serv3_disk >= 70){
	var config9 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_disk,
					100-serv3_disk,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,

				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv3_disk >= 50){
	var config9 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_disk,
					100-serv3_disk,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config9 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv3_disk,
					100-serv3_disk,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
//////////server4/////////////
if(serv4_cpu >= 70){
	var config10 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_cpu,
					100-serv4_cpu,

				],

					backgroundColor: [
						window.chartColors.red,
						window.chartColors.grey,
					],
					borderColor: [
						"#FF476E", //핑크
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else if(serv4_cpu >= 50){
	var config10 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_cpu,
					100-serv4_cpu,

				],
				
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else {
	var config10 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_cpu,
					100-serv4_cpu,

				],
				backgroundColor: [
					window.chartColors.green,
					window.chartColors.grey,
				],
				borderColor: [
					"#4BC0C0", //녹색
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}

if(serv4_mem >= 70){
	var config11 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_mem,
					100-serv4_mem,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,
				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv4_mem >= 50){
	var config11 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_mem,
					100-serv4_mem,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config11 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_mem,
					100-serv4_mem,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80
		}
	};
}
if(serv4_disk >= 70){
	var config12 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_disk,
					100-serv4_disk,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,

				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv4_disk >= 50){
	var config12 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_disk,
					100-serv4_disk,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config12 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv4_disk,
					100-serv4_disk,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
//////////server5//////////////
if(serv5_cpu >= 70){
	var config13 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_cpu,
					100-serv5_cpu,

				],

					backgroundColor: [
						window.chartColors.red,
						window.chartColors.grey,
					],
					borderColor: [
						"#FF476E", //핑크
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else if(serv5_cpu >= 50){
	var config13 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_cpu,
					100-serv5_cpu,

				],
				
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else {
	var config13 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_cpu,
					100-serv5_cpu,

				],
				backgroundColor: [
					window.chartColors.green,
					window.chartColors.grey,
				],
				borderColor: [
					"#4BC0C0", //녹색
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}

if(serv5_mem >= 70){
	var config14 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_mem,
					100-serv5_mem,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,
				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv5_mem >= 50){
	var config14 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_mem,
					100-serv5_mem,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config14 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_mem,
					100-serv5_mem,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80
		}
	};
}
if(serv5_disk >= 70){
	var config15 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_disk,
					100-serv5_disk,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,

				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv5_disk >= 50){
	var config15 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_disk,
					100-serv5_disk,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config15 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv5_disk,
					100-serv5_disk,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
//////////server6//////////////
if(serv6_cpu >= 70){
	var config16 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_cpu,
					100-serv6_cpu,

				],

					backgroundColor: [
						window.chartColors.red,
						window.chartColors.grey,
					],
					borderColor: [
						"#FF476E", //핑크
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else if(serv6_cpu >= 50){
	var config16 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_cpu,
					100-serv6_cpu,

				],
				
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}
else {
	var config16 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_cpu,
					100-serv6_cpu,

				],
				backgroundColor: [
					window.chartColors.green,
					window.chartColors.grey,
				],
				borderColor: [
					"#4BC0C0", //녹색
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "CPU",
		responsive: true,
		cutoutPercentage: 85

		}
	};
}

if(serv6_mem >= 70){
	var config17 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_mem,
					100-serv6_mem,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,
				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv6_mem >= 50){
	var config17 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_mem,
					100-serv6_mem,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config17 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_mem,
					100-serv6_mem,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Mem",
		responsive: true,
		cutoutPercentage: 80
		}
	};
}
if(serv6_disk >= 70){
	var config18 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_disk,
					100-serv6_disk,

				],
				backgroundColor: [
					window.chartColors.red,
					window.chartColors.grey,

				],
				borderColor: [
					"#FF476E", //핑크
					"#C9CBCF" //회색
				],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else if(serv6_disk >= 50){
	var config18 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_disk,
					100-serv6_disk,

				],
					backgroundColor: [
						window.chartColors.orange,
						window.chartColors.grey,
					],
					borderColor: [
						"#FFC000", //주황색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
else {
	var config18 = {
	type: 'doughnut',
	data: {
		datasets: [{
				data: [
					serv6_disk,
					100-serv6_disk,

				],
					backgroundColor: [
						window.chartColors.green,
						window.chartColors.grey,
					],
					borderColor: [
						"#4BC0C0", //녹색
						"#C9CBCF" //회색
					],
				borderWidth: [
					1, 1
				],
				label: 'Dataset 1'
			}
		],
	},
	options: {
		dataType: "Disk",
		responsive: true,
		cutoutPercentage: 80

		}
	};
}
///////////////////////////////////////////////////////////////////////////////////////////////

//var opt1 = {
// canvasBorders : true,
// canvasBordersWidth : 2,
// canvasBordersColor : "black",
// graphTitle : "CPU STATUS",
// graphTitleFontSize: 18,

// crossTextAlign : ["center"],
// crossTextBaseline : ["middle"],

// animationEasing : "linear",
// crossText : ["%call function..."],
// crossTextOverlay :   [true],
// crossTextFontSize : [50],
// crossTextFontColor : ["black"],
// crossTextRelativePosX : [2],
// crossTextRelativePosY : [2],
// crossTextFunction : dispPct1,


// multiGraph : true,

// spaceTop : 30,
// spaceBottom : (defCanvasHeight)/3,
// spaceLeft : 0,
// spaceRight : defCanvasWidth/3*2

//}
window.onload = function () {

	var ctx1 = document.getElementById("chart-area1").getContext("2d");
	window.myDoughnut = new Chart(ctx1, config1);

	var ctx2 = document.getElementById("chart-area2").getContext("2d");
	window.myDoughnut = new Chart(ctx2, config2);

	var ctx3 = document.getElementById("chart-area3").getContext("2d");
	window.myDoughnut = new Chart(ctx3, config3);

	var ctx4 = document.getElementById("chart-area4").getContext("2d");
	window.myDoughnut = new Chart(ctx4, config4);

	var ctx5 = document.getElementById("chart-area5").getContext("2d");
	window.myDoughnut = new Chart(ctx5, config5);

	var ctx6 = document.getElementById("chart-area6").getContext("2d");
	window.myDoughnut = new Chart(ctx6, config6);

	var ctx7 = document.getElementById("chart-area7").getContext("2d");
	window.myDoughnut = new Chart(ctx7, config7);

	var ctx8 = document.getElementById("chart-area8").getContext("2d");
	window.myDoughnut = new Chart(ctx8, config8);

	var ctx9 = document.getElementById("chart-area9").getContext("2d");
	window.myDoughnut = new Chart(ctx9, config9);

	var ctx10 = document.getElementById("chart-area10").getContext("2d");
	window.myDoughnut = new Chart(ctx10, config10);

	var ctx11 = document.getElementById("chart-area11").getContext("2d");
	window.myDoughnut = new Chart(ctx11, config11);

	var ctx12 = document.getElementById("chart-area12").getContext("2d");
	window.myDoughnut = new Chart(ctx12, config12);

	var ctx13 = document.getElementById("chart-area13").getContext("2d");
	window.myDoughnut = new Chart(ctx13, config13);

	var ctx14 = document.getElementById("chart-area14").getContext("2d");
	window.myDoughnut = new Chart(ctx14, config14);

	var ctx15 = document.getElementById("chart-area15").getContext("2d");
	window.myDoughnut = new Chart(ctx15, config15);

	var ctx16 = document.getElementById("chart-area16").getContext("2d");
	window.myDoughnut = new Chart(ctx16, config16);

	var ctx17 = document.getElementById("chart-area17").getContext("2d");
	window.myDoughnut = new Chart(ctx17, config17);

	var ctx18 = document.getElementById("chart-area18").getContext("2d");
	window.myDoughnut = new Chart(ctx18, config18);
};
