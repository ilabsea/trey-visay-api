"use strict";

TV.Personality_testsShow = (() => {
  return {
    init: initChart
  }

  function toTitleCase(str) {
    return str.replace(/^[a-z]/, function (x) {return x.toUpperCase()})
  }

  function initChart() {
    let category = $('.test-result').data('category');
    if (!category) {return}
    let labels = category.map(a => toTitleCase(a.name));
    let data = category.map(a => a.count);
    let ctx = document.getElementById("myChart").getContext('2d');
    let myChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'Personality',
          data: data,
          backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)'
          ],
          borderColor: [
            'rgba(255,99,132,1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)',
            'rgba(255, 159, 64, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero:true
            }
          }]
        }
      }
    });
  }
})();
