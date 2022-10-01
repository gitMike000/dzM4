import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Window 2.15

Window {

    property variant x: [7, 31, 61, 99, 129, 178, 209]
    property variant y: [10, 13, 9, 10, 12, 20, 26]

    property variant w: [0,0]

    function leastSquare(xt, yt) {

      if (xt.length<2 || yt.length<2 || xt.length != yt.length)
      {
          return [0,0];
      }

      var sum_x = 0;
      var sum_y = 0;
      var sum_xy = 0;
      var sum_xx = 0;
      for (var j = 0; j < x.length; j++)
      {
        sum_x += xt[j];
        sum_y += yt[j];
        sum_xy += xt[j] * yt[j];
        sum_xx += xt[j] * xt[j];
       }
      var b = (sum_xx*sum_y - sum_x*sum_xy)*1.0 / (xt.length*sum_xx - sum_x*sum_x);
      var a = (xt.length*sum_xy - sum_x*sum_y)*1.0 / (xt.length*sum_xx - sum_x*sum_x)
      return [b,a]
    }

    width: 640
    height: 480
    visible: true

    ChartView {
        title: "Метод наименьших квадратов"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true

        ValueAxis {
            id: axisX
            min: 0
            max: 220
            tickCount: 5
        }

        ValueAxis {
            id: axisY
            min: 5
            max: 30
        }

        LineSeries {
            id: series1
            axisX: axisX
            axisY: axisY
        }

        ScatterSeries {
            id: series2
            axisX: axisX
            axisY: axisY
        }
    }

    Component.onCompleted: {
        for (var i = 0; i <= 6; i++) {
            series2.append(x[i], y[i]);
        }
        w = leastSquare(x,y)
        for (var i = 0; i <= 6; i++) {
            series1.append(x[i], (w[1]*x[i]+w[0]));
        }
    }
}

