import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.4
import QtCharts 2.15
// Different layouts found here https://doc.qt.io/qt-5/qtquick-layouts-qmlmodule.html -- might be interested in grid layout
ApplicationWindow{
    id: window
    minimumHeight: 720
    minimumWidth: 1280
    width: 1280
    height: 720
    title: "Spending Habit Reader"
    visible: true

    header: Rectangle {
        id: header
        height: 60
        color: 'blue'

        Text{
            id: header_text
            anchors.horizontalCenter: header.horizontalCenter //COMMENT
            anchors.verticalCenter: header.verticalCenter
            text: "Predictor"
            color: 'white'
        }

        MouseArea{
            id: mouse_area
            anchors.fill: parent
            onClicked: backend.completed('App loaded');
        }
    }
    ListModel{
                id: month_model
                ListElement {
                    text : "1"
                    value : "01"
                }
                ListElement {
                    text : "2"
                    value : "02"
                }
                ListElement {
                    text : "3"
                    value : "03"
                }
                ListElement {
                    text : "4"
                    value : "04"
                }
                ListElement {
                    text : "5"
                    value : "05"
                }
                ListElement {
                    text : "6"
                    value : "06"
                }
                ListElement {
                    text : "7"
                    value : "07"
                }
                ListElement {
                    text : "8"
                    value : "08"
                }
                ListElement {
                    text : "9"
                    value : "09"
                }
                ListElement {
                    text : "10"
                    value : "10"
                }
                ListElement {
                    text : "11"
                    value : "11"
                }
                ListElement {
                    text : "12"
                    value : "12"
                }
            }
        
    ListModel{
            id: year_model
            ListElement {text : "2018"}
            ListElement {text : "2019"}
            ListElement {text : "2020"}
            ListElement {text : "2021"}
            ListElement {text : "2022"}
            ListElement {text : "2023"}
            ListElement {text : "2024"}
            ListElement {text : "2025"}
            ListElement {text : "2026"}
            ListElement {text : "2027"}
            ListElement {text : "2028"}
            ListElement {text : "2029"}
            ListElement {text : "2030"}

    }
    // easiest way I found of having "different" pages.
    StackView{
        id: main
        anchors.fill: parent
        Text{
            text : "Year"
            anchors.bottom : year_input.top
            anchors.bottomMargin : 25
            anchors.horizontalCenter: year_input.horizontalCenter
            
        }
        ComboBox {
            id : year_input    
            x: 100
            y: 100
            height : 100
            width : 200
            model : year_model
            font.pixelSize : 30
            onActivated: backend.tester1(year_model.get(currentIndex).text)
        }
        ComboBox {
            id : month_input    
            x: parent.width - 300
            y: 100
            height : 100
            width : 200
            model : month_model
            font.pixelSize : 30
            Text{
                text : "Month"
                anchors.bottom : parent.top
                anchors.bottomMargin : 25
                anchors.horizontalCenter: parent.horizontalCenter
            }
            textRole: "text" //to specify which value we wish to have present
            onActivated: backend.tester1(month_model.get(currentIndex).value)
        }

        Button{
            id : butt_ion
            text : "compute"
            anchors.horizontalCenter: parent.horizontalCenter
            y : month_input.y + month_input.height
            onClicked: {
                backend.calculate(
                    year_model.get(year_input.currentIndex).text,
                    month_model.get(month_input.currentIndex).value
                )
            }
        }

        Rectangle {
            id : pie_zone
            height : 500
            width : 500
            anchors.bottom : parent.bottom
            anchors.top : butt_ion.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 25
            ChartView{
                anchors.fill: parent
                PieSeries {
                    id: pieSeries
                    PieSlice { label: "Bills"; value: 0}
                    PieSlice { label: "Food"; value: 0 }
                    PieSlice { label: "Other"; value: 0 }
                    PieSlice { label: "Retail"; value: 0 }
                    PieSlice { label: "Third Party"; value: 0 }
                    PieSlice { label: "Travel"; value: 10 }
                }
            }
        }
    }
    Component.onCompleted: {
        backend.completed('App loaded');
        alert.visible = false
    }

    // Creates a connection to our backend. This exposes Slot() functions with to this QML script and it's children
    Connections {
        target: backend
        function onResults(data){
            data = JSON.parse(data);
            var counter = 0
            for(let key in data) {
                pieSeries.at(counter).value = data[key]
                // reset the label in case order ever gets mixed up
                pieSeries.at(counter).label = key
                counter++
            }
            //to get the percentage value of the chosen slice
            //pieSeries.at(0).percentage
        }

        // implementation of a signal emitted by the backend
        function onAlert(msg){
            console.log("ENTERED")
            alert.message = msg
            alert.visible = true
            alert.startAnim();
        }
    }

    Rectangle{
        id: alert
        x: (parent.width / 2) - (width/2)
        y: 25
        height: 50
        width: 750
        color: "#b71c1c"
        property alias message: alert_msg.text

        SequentialAnimation {
            id: anim
            NumberAnimation { target: alert; property: "x"; to: alert.x - 25; duration: 10}
            NumberAnimation { target: alert; property: "x"; to: alert.x + 25; duration: 10}
            NumberAnimation { target: alert; property: "x"; to: alert.x; duration: 10}
        }

        ImageButton{
            id: exit_button
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            imageSource: "../assets/close_button_white.png"
            onClicked: {
                alert.visible = false
            }
        }

        Text {
            id: alert_msg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.right: exit_button.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            text: ""
            font.pointSize: 12
            color: "#ff8a80"
            wrapMode: Text.WordWrap
        }
        visible: true

        function startAnim(){
            anim.restart();
        }
    }
}