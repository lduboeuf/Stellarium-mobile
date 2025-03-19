/*
 * Stellarium
 * Copyright (C) 2013 Fabien Chereau
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA  02110-1335, USA.
 */

import QtQuick 2.2
import QtQuick.Controls 2.2

StelDialog {
	id: root
	title: country ? qsTr("Pick City") : qsTr("Pick Country")
	width: rootStyle.niceMenuWidth
	height: 320*rootStyle.scale
	property string country
	property string city

    Rectangle {
        id: searchFieldHolder
        color: 'transparent'
        border.width: 1*rootStyle.scale
        border.color: 'white'
        height: 45*rootStyle.scale
        width: parent.width
        anchors.margins: rootStyle.margin

        Image {
            id: loupeImage
            source: "images/search.png"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: rootStyle.margin
            width: 24*rootStyle.scale
            height: 24*rootStyle.scale
        }

        TextInput {
            id: searchField
            anchors {
                top: parent.top
                left: loupeImage.right
                right: parent.right
                bottom: parent.bottom
                leftMargin: rootStyle.margin
            }
            inputMethodHints: Qt.ImhNoPredictiveText
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: rootStyle.fontNormalSize
            color: "#AAAAAA"

            onTextChanged: {
                if (text.length > 0 ) {
                    root.applyFilter(text);
                } else {
                    root.reload();
                }
            }

        }
    }


	ListView {
		id: countriesList
		anchors.left: parent.left
        anchors.top: searchFieldHolder.bottom
		width: root.country ? root.width / 2 : root.width
		Behavior on width {
			NumberAnimation { easing.type: Easing.InOutQuad }
		}
		height: root.height
		delegate: StelListItem {
			withArrow: false
			text: qsTr(modelData)
			selected: root.country === modelData
            onClicked: {
                root.country = modelData
                searchField.text = ""
            }
		}
        model: stellarium.getCountryNames()
        clip: true
	}
	ListView {
        id: citiesList
        anchors.top: searchFieldHolder.bottom
		anchors.left: countriesList.right
		anchors.right: parent.right
        height: root.height
		delegate: StelListItem {
			withArrow: false
			text: qsTr(modelData)
			selected: root.city === modelData
			onClicked: root.city = modelData
		}
        model: stellarium.getCityNames(root.country, "")
		clip: true
	}

	onCityChanged: {
		if (!country || !city) return;
		stellarium.location = "%1, %2".arg(city).arg(country)
		close();
	}

    function reload() {
        if (!root.country) {
            countriesList.model = stellarium.getCountryNames()
        } else {
            citiesList.model = stellarium.getCityNames(root.country, "")
        }
    }
    function applyFilter(cName){
        var cList
        if (!root.country) {
            cList = stellarium.getCountryNames()
        } else {
            cList = stellarium.getCityNames(root.country, "")
        }

        var temp = [];
        cName = cName.toLowerCase()
        for (var i = 0; i < cList.length; i++)
        {
            if (cList[i].toLowerCase().includes(cName)) {
                temp.push(cList[i])
            }
        }
        if (!root.country) {
            countriesList.model = temp;
        } else {
           citiesList.model = temp
        }
    }

    Component.onCompleted: {
        searchField.forceActiveFocus()
    }

}
