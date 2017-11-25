/***************************************************************************
* Copyright (c) 2017 Fawix  <fawixfa@gmail.com>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.2
import SddmComponents 2.0


Rectangle {

  id: container
  width: 1920
  height: 1080

  LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
  LayoutMirroring.childrenInherit: true

  property int sessionIndex: session.index

  TextConstants {
    id: textConstants
  }

  Connections {
    target: sddm
    onLoginSucceeded: {}
    onLoginFailed: {
      errorMessage.color = "#b58900",
      errorMessage.text = textConstants.loginFailed
    }

  }

  //see theme.conf to modify font
  FontLoader {
    id: textFont;
    name: config.displayFont
  }

  Repeater {
    model: screenModel

    Background {
      x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
      source: config.background
      fillMode: Image.PreserveAspectCrop
      
      onStatusChanged: {
        if (status == Image.Error && source != config.defaultBackground) {
	  source = config.defaultBackground
	}
      }

    }
  }

  Rectangle {
   anchors.fill: parent
   color: "transparent"

   Rectangle {
     id: clockContainer
     width: parent.width / 2
     height: parent.height * 0.2
     color: "transparent"
     anchors.left: parent.left
     anchors.verticalCenter: parent.verticalCenter
     anchors.leftMargin: 40

     Clock {
       id: clock
       color: "#fdf6e3"
       timeFont.family: textFont.name
       dateFont.family: textFont.name
     }
   }

   Rectangle {
     width: parent.width / 2
     height: parent.height * 0.3
     color: "transparent"
     anchors.left: parent.left
     anchors.top: clockContainer.bottom
     anchors.leftMargin: 40
     clip: true

     Item {
       id: userContainer
       width: 3 * parent.width / 4
       height: parent.height

       Column {
         id: nameColumn
	 width: parent.width * 0.4
	 spacing: 10
	 anchors.margins: 10

	 Text {
	   id: lblName
	   width: parent.width
	   text: textConstants.userName
	   font.family: textFont.name
	   font.bold: true
	   font.pixelSize: 16
	   color: "#eee8d5"
	 }

	 TextBox {
	   id: name
	   width: parent.width
	   text: userModel.lastUser
	   font: textFont.name
	   //color: "#268bd2"
	   color: "transparent"
	   //borderColor: "transparent"
	   borderColor: "#268bd2"
	   textColor: "#eee8d5"

	   Keys.onPressed: {
	     if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
	       sddm.login(name.text, password.text, session.index)
	       event.accepted = true
	     }
	   }

	   KeyNavigation.backtab: layoutBox;
	   KeyNavigation.tab: password;
	 }

         Text {
	   id: errorMessage
	   anchors.left: name.left
	   font.family: textFont.name
	   font.pixelSize: 16
	   font.bold: true
           color: "#fdf6e3"
	 }
	}//Name Column
       
       Column {
         id: passColumn
	 width: parent.width * 0.4
	 spacing: 10
	 anchors.margins: 10
	 anchors.left: nameColumn.right

	 Text {
	   id: lblPassword
	   width: parent.width
	   text: textConstants.password
	   font.family: textFont.name
	   font.bold: true
	   font.pixelSize: 16
           color: "#fdf6e3"
	 }

	 PasswordBox {
	   id: password
	   width: parent.width
	   font: textFont.name
           //color: "#268bd2"
           color: "transparent"
	   //borderColor: "transparent"
	   borderColor: "#268bd2"
	   textColor: "#eee8d5"
	   tooltipBG: "#eee8d5" 
	   tooltipFG: "#268bd2"
	   image:"warning.svg"

           Keys.onPressed: {
	     if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
	       sddm.login(name.text, password.text, session.index)
	       event.accepted = true
	     }
	   }

	   KeyNavigation.backtab: name;
	   KeyNavigation.tab: loginButton;

	 }

	 Button {
	   id: loginButton
	   text: textConstants.login
	   width: parent.width * 0.4
	   anchors.right: password.right
	   color: "#268bd2"
	   disabledColor: "#93a1a1"
	   activeColor: "#268bd2"
	   pressedColor: "#6c71c4"
	   textColor: "#eee8d5"
	   font: textFont.name

	   onClicked: sddm.login(name.text,password.text,session.index)
	   KeyNavigation.backtab: password;
	   KeyNavigation.tab: btnReboot
	 }
       }//Pass Column
     
     }//Item
   
   }//Rectangle

   Rectangle {
     id: actionBar
     anchors.top: parent.top
     anchors.horizontalCenter: parent.horizontalCenter
     width: parent.width
     height: 40
     color: "transparent"

     Row {
       anchors.left: parent.left
       anchors.margins: 5
       height: parent.height
       spacing: 10

       Text {
         height: parent.height
	 anchors.verticalCenter: parent.verticalCenter
	 font.family: textFont.name
	 verticalAlignment: Text.AlignVCenter
	 color: "#268bd2"
       }

       ComboBox {
         id: session
	 width: 245
	 height: 20
	 anchors.verticalCenter: parent.verticalCenter
	 color: "transparent"
	 textColor: "#eee8d5"
	 borderColor: "transparent"
	 hoverColor: "#268bd2"
	 arrowColor: "transparent"

	 model: sessionModel
	 index: sessionModel.lastIndex

	 KeyNavigation.backtab: btnShutdown;
	 KeyNavigation.tab: layoutBox
       }

       Text {
         height: parent.height
	 anchors.verticalCenter: parent.verticalCenter
	 font.family: textFont.name
	 font.pixelSize: 16
	 font.bold: true
	 verticalAlignment: Text.AlignVCenter
	 color: "red"
       }

       ComboBox {
         id: layoutBox
	 width: 50
	 height: 20
	 anchors.verticalCenter: parent.verticalCenter
	 color: "transparent"
	 textColor: "#eee8d5"
	 borderColor: "transparent"
	 hoverColor: "#268bd2"
	 //arrowColor: "#eee8d5"
	 arrowColor: "transparent"

	 model: keyboard.layouts
	 index: keyboard.currentLayout

	 onValueChanged: keyboard.currentLayout = id

	 Connections {
	   target: keyboard
	   onCurrentLayoutChanged: combo.index = keyboard.currentLayout
	 }

	 rowDelegate: Rectangle {
	   color: "transparent"

	   Text {
	     anchors.margins: 4
	     anchors.top: parent.top
	     anchors.bottom: parent.bottom

	     verticalAlignment: Text.AlignVCenter

	     text: modelItem ? modelItem.modelData.shortName : "zz"
	     font.family: textFont.name
	     font.pixelSize: 14
	     color: "white"
	   }
	 }

	 KeyNavigation.backtab: session;
	 KeyNavigation.tab: name;
       }
     }//Row Action Bar 1 

    Row {
      height: parent.height
      anchors.right: parent.right
      anchors.margins: 5
      spacing: 10

      ImageButton {
        id: btnReboot
	height: parent.height
	source: "reboot.svg"

	visible: sddm.canReboot
	onClicked: sddm.reboot()

	KeyNavigation.backtab: loginButton;
	KeyNavigation.tab: btnShutdown
      }

      ImageButton {
        id: btnShutdown
	height: parent.height
	source: "shutdown.svg"

	visible: sddm.canPowerOff
	onClicked: sddm.powerOff()

	KeyNavigation.backtab: btnReboot;
	KeyNavigation.tab: session;
      }
    }//Row Action Bar 2

   } //Action Bar Rectangle

   Component.onCompleted: {
     if (name.text == "")
        name.focus = true
     else
        password.focus = true
   
   }
  
  }

}
