import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import ru.gb.MyGraphikCalc 1.0

Window {    

    function findElement(myModel, myId) {
        for(var i = 0; i < myModel.count; i++) {
            var element = myModel.get(i);

            if(myId == element.value) {
//                console.log("Found element: ", i);
                return element.key;
            }
        }
        return "";
    }

    function seriesApp() {
        for (var i = 0; i <= 49; i++) {
            series1.append(graphicCalc.getX(i), graphicCalc.getY(i));
        }
    }

    id: chartGraphic
    width: 640
    height: 480
    visible: true        

    ListModel {
        id: graphic
        ListElement { key: "y = sin(x)"; value: 0 }
        ListElement { key: "y = x"; value: 1 }
        ListElement { key: "y = |x - 2.5|"; value: 2 }
        ListElement { key: "y = x ^ 2"; value: 3 }
        ListElement { key: "y = log2(x)"; value: 4 }        
    }

    ListModel {
        id: graphicColor
        ListElement { key: "black"; value: 0 }
        ListElement { key: "blue"; value: 1 }
        ListElement { key: "red"; value: 2 }
        ListElement { key: "green"; value: 3 }
        ListElement { key: "yellow"; value: 4 }
    }

    GraphikCalc {
        id: graphicCalc

        onGraphicReady: {
            console.log("graph update");
            series1.clear();
            seriesApp();
        }
    }

Column {
    id: grid
    y: 10
    height: parent.height-y
    width: parent.width
    Row {
        width: parent.width
        ComboBox {
            id: graphicSelect
            width: 200
            height: 30
            x: (parent.width/3-width)/2
            textRole: "key"
            background: Rectangle {
                color: "white"
                border.width: parent && parent.activeFocus ? 2 : 1
                border.color: parent && parent.activeFocus ? graphicSelect.palette.highlight : graphicSelect.palette.button
            }
            model: graphic
            font.pointSize: 14
            font.family: "Courier"
            font.italic: true
            font.bold: true

//            onCurrentIndexChanged: {
//                graphicCalc.modelGraphic  = graphicSelect.currentIndex
//                graphicCalc.chGraphic()
//            }
        }
        ComboBox {
            id: colorSelect
            width: 100
            height: 30
            x: graphicSelect.x+parent.width/3
            textRole: "key"
            background: Rectangle {
                color: "white"
                border.width: parent && parent.activeFocus ? 2 : 1
                border.color: parent && parent.activeFocus ? colorSelect.palette.highlight : colorSelect.palette.button
            }
            model: graphicColor
            font.pointSize: 14
            font.family: "Courier"
            font.italic: true
            font.bold: true

//            onCurrentIndexChanged: {
//                graphicCalc.modelColor = colorSelect.currentText
//                graphicCalc.chColor()
//            }
        }
        Button {
            id: buttonSelect
            width: 100
            height: 30
            x: colorSelect.x+parent.width/3
            text: "Построить"
            onClicked: {
                graphicCalc.modelGraphic  = graphicSelect.currentIndex
                graphicCalc.modelColor = colorSelect.currentIndex
//                series1.clear();
//                seriesApp();
            }
        }
    }

    ChartView {
        id: graphicChart        
        title: findElement(graphic, graphicCalc.modelGraphic)
        width: parent.width
        height: parent.height-graphicSelect.height
        y: graphicSelect.height
        x: 0

        legend.visible: false        
        antialiasing: true

        ValueAxis {
            id: axis_X
            min: 0
            max: 5
            tickCount: 5
        }

        ValueAxis {
            id: axis_Y
            min: graphicCalc.minY()
            max: graphicCalc.maxY()
        }

        LineSeries {
            id: series1            
            color: findElement(graphicColor, graphicCalc.modelColor)
            axisX: axis_X
            axisY: axis_Y
        }
        }
    }
    Component.onCompleted: {
//         // Вызов
//        //invocable-метода из зарегистрированного класса
//        graphicCalc.somethingHappened() // Эмит сигнала
//        graphicCalc.registeredClassSlot() // Вызов слота из
//        //зарегистрированного класса
        seriesApp();

    }
}

